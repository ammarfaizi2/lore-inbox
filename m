Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277097AbRJDDP5>; Wed, 3 Oct 2001 23:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277098AbRJDDPs>; Wed, 3 Oct 2001 23:15:48 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:44783 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277097AbRJDDPh>; Wed, 3 Oct 2001 23:15:37 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 3 Oct 2001 21:15:08 -0600
To: linux-lvm@sistina.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: partition table read incorrectly
Message-ID: <20011003211508.O8954@turbolinux.com>
Mail-Followup-To: linux-lvm@sistina.com, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
In-Reply-To: <200110031901.TAA04080@vlet.cwi.nl> <20011004013950.A16757@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011004013950.A16757@cistron.nl>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 04, 2001  01:39 +0200, Wichert Akkerman wrote:
> Previously Andries.Brouwer@cwi.nl wrote:
> > But why do you call it wrong?
> 
> I deleted all partitions with fdisk so I expect none to be there.
> fdisk shows none, but the kernel does.

The safest thing to do at this point is to simply delete the whole thing:

dd if=/dev/zero of=/dev/sdb count=1

then pvcreate the disk again.  If you already have data on the PV in
question, you can "dd if=/dev/zero of=/dev/sdb bs=1 seek=510 count=2"
to remove only the partition signature.

Note also that it is a bug in LVM that it did not zero the whole thing
in the first place.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

