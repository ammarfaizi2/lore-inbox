Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269593AbUJSSSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269593AbUJSSSw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269563AbUJSSSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:18:47 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:35499 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270019AbUJSRoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:44:32 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=efUYNOGyBJagX6+s/S6Jg2nY21ZaB15tQiCW1Azs8zgkxsb2P6I7G1+xhH3d7qHx2jqmEAO+vs6lNjdZIiOK/YRwX2yM6II6RBM9xv3G89Ao+Z69MCW2B2/L9auPf1a+g/XKoZvjW/9arYq1jEwuCFHWWvFUDT2/uen8JT3fSLo
Message-ID: <8783be6604101910443a76e223@mail.gmail.com>
Date: Tue, 19 Oct 2004 13:44:32 -0400
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Johan Groth <jgroth@dsl.pipex.com>
Subject: Re: Dma problems with Promise IDE controller
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <41754D7B.8090203@dsl.pipex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41741CDB.5010300@dsl.pipex.com>
	 <58cb370e04101813221d36b793@mail.gmail.com>
	 <8783be660410181420683d1341@mail.gmail.com>
	 <41753E1D.8010608@dsl.pipex.com>
	 <8783be660410191013230a1b48@mail.gmail.com>
	 <41754D7B.8090203@dsl.pipex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 18:23:07 +0100, Johan Groth <jgroth@dsl.pipex.com> wrote:
> Ross Biro wrote:
> [snip]
> 
> >
> > The drive still has a bad sector.  You are having trouble because the
> > error recover in the Linux ide code is not the same as Windows and
> > most drive vendors care about Windows, not the ATA-Spec.  On top of
> > that Linux switches out of DMA mode once it hits a bad sector, so the
> > drive will be very slow from the on.
> >
> > The only way you are going to fix the problem is if your drive has
> > some spare sectors still available, and you do a write with out a read
> > to the bad sector.
> 
> Ok, I pretty sure it has spare sectors. How do I write to that sector
> without a read and how do I find which sector is bad?

That part is easy.  It's in your error message. 156064 is the bad
sector.  I would use dd if=/dev/zero of=/dev/hd???? bs=512 seek=?????
count=1 to write the sector, but before I did that, I would be very
sure of my sector number.  The best way I can think of to do that is
to turn off read aheda for that device and attempt to read one sector
at a time until you find the bad one.  Then reboot, double check,
reboot again, and finally write that sector out.  Then you'll need to
do an fsck to fix the file system.  You will have lost some data, but
it may not be clare what file(s) have been damaged.

If you are very confident in your backups, you could just dd
if=/dev/zero of=/dev/hd???? bs=something big and wipe the whole drive.
 That will remapp all of the bad sectors, then just mke2fs the device
and start over.

Becareful doing any of the above, if you do it wrong, you lose data. 
Even if you do it write, you lose some data, just not as much.

    Ross
