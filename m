Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265687AbTB0Rgm>; Thu, 27 Feb 2003 12:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265686AbTB0Rgm>; Thu, 27 Feb 2003 12:36:42 -0500
Received: from adsl-63-195-13-67.dsl.chic01.pacbell.net ([63.195.13.67]:44817
	"EHLO mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id <S265680AbTB0Rgl>; Thu, 27 Feb 2003 12:36:41 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Thu, 27 Feb 2003 09:46:53 -0800
MIME-Version: 1.0
Subject: Is the GIO_FONT ioctl() busted in Linux kernel 2.4?
Message-ID: <3E5DDE8D.14024.6FCE7D82@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have some old code that used to work great on older Linux 2.2 kernels 
that is now giving me a perror() error message of 'no space left on 
device' (ie: ENOSPC) when I call ioctl(GIO_FONT) to save the current 
console font.

>From looking at the 2.4 kernel source code that comes with Red Hat 8.0, 
it is clear that these functions are implemented on top of a new console 
font interface that supports 512 characters and up to 32x32 pixel fonts 
(obviously for fb consoles). From my quick look at the code, the ENOSPC 
error must be coming because when the new code attempts to save the 
console font it must have more than 256 characters or bigger than 8x32 
pixels for the font glyphs (which is what the old font interface 
supported).

I know I can switch to the new console interfaces (which I will do once I 

determine how to do a runtime check for a 2.4 kernel so I can still use 
the old code for 2.2 and earlier kernels), but it seems to me that this 
bug should be fixed. Is anyone more familiar with the console code able 
to provide some feedback on this?

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

