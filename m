Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbTCSBW1>; Tue, 18 Mar 2003 20:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbTCSBW1>; Tue, 18 Mar 2003 20:22:27 -0500
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70]:44216
	"EHLO mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id <S262877AbTCSBWZ>; Tue, 18 Mar 2003 20:22:25 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Tue, 18 Mar 2003 17:33:01 -0800
MIME-Version: 1.0
Subject: Help with patch for vesafbd support again?
Message-ID: <3E77584D.959.5228A36@localhost>
In-reply-to: <20030319005803.GL30541@dualathlon.random>
References: <20030318.163701.56035556.davem@redhat.com>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

Well I managed to finally dig up the old code that Aki Laukkanen deveoped 
sometime in early 2000. Unfortunately Aki died sometime in January 2001, 
so his work on the vesafbd daemon and patches to the vesafb device driver 
were lost - until now.  

I would like to revive this project, and the code I received from Matan 
Ziv-Av still configures and compiles correctly on Red Hat 8.0. I need to 
patch the latest kernel vesafb driver, but I think his patch is very old 
(probably around 2.2.14 timeframe). I am grabbing the 2.2.14 code to see 
if the patch will apply to that code, and then try to port the patch to 
the latest kernel release. Which brings up the first question. What 
kernel version should I patch against? 2.4.x or 2.5.x?

However since I am not that familiar with the patching mechanism for the 
Linux kernel, would someone more familiar with this be willing to help 
out? I would like to modify the vesafb module in the kernel to optionally 
support the vesafbd daemon if it is present on the system, if not it will 
function as it does today. If vesafbd is present, it will be used to 
provide extended features to the default VESA framebuffer console driver.

I would also like to generalise the daemon module a bit such that it does 
not need to be a VESA specific daemon, but could in fact contain it's own 
hardware interfacing module. For instance the daemon could use XFree86 
loadable driver modules to implement the functions rather than the VESA 
interface code, which would also open up the option of doing accelerated 
screen blits using the existing XFree86 driver modules. Hence I was 
thinking that the name 'vesafbd' for the daemon is a misnomer and should 
probably be changed to something else like 'fbcond' or something. Any 
suggestions? Or should we just leave it as 'vesafbd' even though it could 
be updated to support more than just the VESA BIOS interface?

Also the code I have right now for the daemon relies on the /dev/vesafb 
special file to have been created, which is used as the communication 
mechanism between the modified vesafb kernel driver and the daemon code. 
The daemon simply constantly reads from /dev/vesafb for command packets 
to process and writes the results to /dev/vesafb. Some people suggested 
in the past that a better approach might be to either use extended 
ioctl()'s to the existing /dev/fb special file, and have the kernel 
module sleep until it needs to do something, or use other polling methods 
(of which I am not familiar). I would like some guidance here as to the 
best way to implement this daemon if people think it should be changed.

Finally, before I embark on this project, will this patch will be 
accepted into the kernel source code tree? I would hate to spend my time 
on it only to find out that the kernel developers don't like it and won't 
accept it.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

