Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285161AbRLMUjO>; Thu, 13 Dec 2001 15:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285165AbRLMUjE>; Thu, 13 Dec 2001 15:39:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2579 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285161AbRLMUiw>; Thu, 13 Dec 2001 15:38:52 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Mounting a in-ROM filesystem efficiently
Date: 13 Dec 2001 12:38:28 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9vb3k4$9kj$1@cesium.transmeta.com>
In-Reply-To: <20011213160007.D998D23CCB@persephone.dmz.logatique.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011213160007.D998D23CCB@persephone.dmz.logatique.fr>
By author:    Thomas Capricelli <orzel@kde.org>
In newsgroup: linux.dev.kernel
> 
> Hello,
> 
> I'm looking for a way to put a filesystem into ROM.
> Seems pretty trivial, isn't it ?
> 
> My understanding is (the way initrd does, and the way I do as of today)
> * create a RAMDISK
> * loads the data into ramdisk
> * mount the ramdisk
> 
> problem is that I don't want to waste the RAM as the data in the ROM is 
> already in the address space. (it's an embedded system, btw)
> 
> Speed is not an issue here. ROM access might be slower than RAM, it will 
> always be so much quicker than a disk access. (wrong?)
> 

Frequently wrong.  Depending on the interface, ROM can be just
unbelievably slow.

> Ideally, i would give address/length of the fs in ROM to a function, and I 
> would get a ramdisk configured to read its data exactly there, and not in 
> ram.

The right thing for you to do is to write a block device driver, and
then mount that block device like any order device.  Your in-use data
will be copied to RAM (i.e. cached), but it can be dropped and
re-fetched as necessary.  This should be the desired behaviour.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
