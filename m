Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbTDGT6k (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 15:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263616AbTDGT6k (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 15:58:40 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:19217 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S263614AbTDGT6j (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 15:58:39 -0400
Date: Mon, 7 Apr 2003 22:10:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <b6s3tm$i2d$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.44.0304071742490.12110-100000@serv>
References: <200303311541.50200.pbadari@us.ibm.com> <Pine.LNX.4.44.0304031256550.5042-100000@serv>
 <20030403133725.GA14027@win.tue.nl> <Pine.LNX.4.44.0304031548090.12110-100000@serv>
 <b6s3tm$i2d$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7 Apr 2003, H. Peter Anvin wrote:

> > This still doesn't answer what will come next. You must have _some_ idea, 
> > otherwise you wouldn't add a new interface, remove other infrastructure 
> > and provide a patch which modifies MKDEV & co. All of this only leads us 
> > away from the goal of dynamic device numbers. Why?
> > 
> 
> I have an idea, why don't you read the archives of this mailing list
> for the past eight years and learn, once again, why dynamic numbers
> are broken for nearly all applications (disks and ptys being, perhaps,
> the few case where they actually work.)
> 
> This has been hashed and rehashed on this list so many times it's not
> even funny.

I ignore the flame bait in the hopes to get a reasonable answer this time, 
if you have a personal problem with me, you are free to tell me this 
directly, but flaming will help nobody.

The dynamic number discussion I remember were not only about numbering but 
also about naming. A specific device had to be addressable with a specific
number. We currently have a fixed mapping between numbers and names (as 
documented in devices.txt). Disks are an area where this doesn't work, the 
only exception is IDE, because most machines have a builtin controller, 
so it's easy to map to a fixed number. SCSI already has to use dynamic 
numbers, because it wouldn't otherwise fit into a 16bit dev_t and with SAN 
even 64bit will not be enough. This makes SCSI very annoying, when at the 
next boot everything has a new name, because a disk was added/removed.

Consequently it's impossible that the kernel guarantees a static name/ 
number for a specific device. devfs showed that the kernel is the wrong 
place for name policies. Is see no other possibility than to number 
devices dynamically and leave it to userspace to name them or did I miss 
an important point in previous discussions?
Maybe you could also answer me, what exactly you need a 64bit dev_t for?
If anything of this has been discussed previously, I'd also be happy about 
any URLs. Thanks.

bye, Roman

