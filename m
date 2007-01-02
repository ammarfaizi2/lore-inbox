Return-Path: <linux-kernel-owner+w=401wt.eu-S932702AbXABRyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbXABRyA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 12:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932888AbXABRyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 12:54:00 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:14220 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702AbXABRx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 12:53:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=uuyzi8VJLxPBcYS7laNo9Q/tZry+dW2BADMbeN73cm4CKE2alTB8Eh0OQu/ztBEpN3veum5OqYbwGl9kD3AdArvyLLllgrG/Od/SKvnuKDr6nNhNRyYYDbP68LwZpDVMQg/djEFfcB40MEMPFBrNh5DG3D3N09vq8HP+96K6sbU=
Message-ID: <459A9C30.20204@gmail.com>
Date: Wed, 03 Jan 2007 02:53:52 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Jens Axboe <jens.axboe@oracle.com>, Rene Herman <rene.herman@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com> <4599992D.8000607@rtr.ca> <20070102083414.GQ2483@kernel.dk> <459A73CB.8010901@rtr.ca> <459A8E17.80601@gmail.com> <459A97EC.8090903@rtr.ca>
In-Reply-To: <459A97EC.8090903@rtr.ca>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
>>
>> OT but care to make -i and -I work equivalently?  Such that -i reports
>> more detailed info and user can dump stored id block.
> 
> hdparm -I works just fine now.

No objection there.

> hdparm -i requires the HDIO_GET_IDENTITY ioctl() from drivers/ide,
> to retrieve the "boot time" copy of the identify block, before any
> mods are made by the driver.  But in recent years, drivers/ide has
> broken it, in that it tries to maintain the "boot time" copy in sync
> with the on-drive copy.  Kinda makes -i pointless.
> 
> Is there a way to retrieve the libata cached copy of the ID block?
> How?

Just implemented and posted patch for HDIO_GET_IDENTITY in an attempt to
access ATAPI IDENTIFY block using hdparm.

>> Support for IDENTIFY PACKET DEVICE would be nice too.
> 
> It already does that, using HDIO_DRIVE_CMD to retrieve it
> in the same way as for regular IDENTIFY DEVICE commands.

Hmmm... My hdparm doesn't seem to do that.

# hdparm -V
hdparm v6.9
# hdparm -I /dev/sr0

/dev/sr0:
 HDIO_DRIVE_CMD(identify) failed: Input/output error

Am I missing something?

> In hdparm-7.0, I'll have it use ATA passthrough when possible
> for most/all commands.

Glad to hear.

Happy new year.

-- 
tejun
