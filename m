Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbTB0RrF>; Thu, 27 Feb 2003 12:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbTB0RrF>; Thu, 27 Feb 2003 12:47:05 -0500
Received: from adsl-63-195-13-67.dsl.chic01.pacbell.net ([63.195.13.67]:530
	"EHLO mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id <S265725AbTB0RrE>; Thu, 27 Feb 2003 12:47:04 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Thu, 27 Feb 2003 09:57:16 -0800
MIME-Version: 1.0
Subject: Re: Is the GIO_FONT ioctl() busted in Linux kernel 2.4?
Message-ID: <3E5DE0FC.29370.6FD7FC8B@localhost>
In-reply-to: <3E5DDE8D.14024.6FCE7D82@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kendall Bennett" <KendallB@scitechsoft.com> wrote:

> From looking at the 2.4 kernel source code that comes with Red
> Hat 8.0, it is clear that these functions are implemented on top
> of a new console font interface that supports 512 characters and
> up to 32x32 pixel fonts (obviously for fb consoles). 

Yep, after further investigation the problem is that the VGA console is 
configured to run with 512 characters, yet the 'old' interface code is 
trying to save/restore only 256 characters so it fails. It could be fixed 
if it was changed to save/restore 512 characters, but I don't know if 
that will break old code (it won't break mine as I always uses a 64K 
buffer to save/restore the font tables).

Can someone who is more experienced with the kernel describe how this can 
be properly patched? 

I have worked around the problem in my code by simply switching to the 
new interface (KDFONTOP), but I would like to know what kernel version 
this new interface showed up in. If it was in the 2.0 or even 2.2 kernels 
that would be fine since that goes back far enough for the support we 
need.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

