Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbUA0TQY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265754AbUA0TOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:14:20 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:911 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265751AbUA0TOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:14:06 -0500
Message-ID: <4016B872.3090309@samwel.tk>
Date: Tue, 27 Jan 2004 20:13:54 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: felix-kernel@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording
References: <20040124181026.GA22100@codeblau.de>	<20040124153551.24e74f63.akpm@osdl.org>	<40144A36.5090709@samwel.tk>	<20040125150914.1583d487.akpm@osdl.org>	<4014516D.5070409@samwel.tk> <20040125153803.4d7e1015.akpm@osdl.org>
In-Reply-To: <20040125153803.4d7e1015.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> You could certainly do that.  Given disk block #N you need to search all
> files on the disk asking "who owns this block".  The FIBMAP ioctl can be
> used on most filesystems (ext2, ext3, others..) to find out which blocks a
> file is using.   See bmap.c in
> 
> http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz
> 
> Unfortunately you cannot determine a directory's blocks in this way. 
> Ext3's directories live in the /dev/hda1 pagecache anyway.  ext2's
> directories each have their own pagecache.

OK, I've written something that does this (but only correctly for ext3). 
I've put it here:

http://www.xs4all.nl/~bsamwel/bootup_prefetch.tar.gz

I haven't had the opportunity to do good measurements, so I don't really 
know if it even increases performance. If anyone feels like benchmarking 
this, I'd be very happy to hear from you. I don't really expect 
performance increases, as the bootup scripts seem to have enough 
processing to do to keep the system busy even without disk I/O. I wonder 
if it might make a difference on a faster processor though, my system's 
kind of sluggish by today's standards.

-- Bart
