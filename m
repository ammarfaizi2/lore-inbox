Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283016AbRLIFTZ>; Sun, 9 Dec 2001 00:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283019AbRLIFTQ>; Sun, 9 Dec 2001 00:19:16 -0500
Received: from mnh-1-28.mv.com ([207.22.10.60]:21520 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S283016AbRLIFTD>;
	Sun, 9 Dec 2001 00:19:03 -0500
Message-Id: <200112090638.BAA06592@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.53-2.4.16
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Dec 2001 01:38:51 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.16 is available.

gdb is now much more responsive to ^C and it's now possible to interrupt
processes in userspace.  

Fixed ^S and ^Q in the console driver (thanks to agitation by Daniel 
Phillips...).

mconsole commands can now run from either interrupt context or process
context.  The ones that run from interrupt context are now much more
likely to happen when UML is sick.  

There is now an mconsole 'cad' command, which simulates Ctrl-Alt-Del. 

UML will now boot with 'con=pty', although the console output never
appears on its assigned pty for some reason.  

Core dump support is now there, except that the registers aren't dumped
correctly, so they don't make gdb very happy.  

There is some support for SIGWINCH.  If the main console is stdin/stdout
and you resize that window, whatever is running in it will get a
SIGWINCH. Other things, like other xterms and ptys, won't generate
SIGWINCH for UML because they are not controlling terminals for it. 

A couple of problems with rebooting were fixed.  An overlap between errno
and some code, causing that code to be corrupted, was fixed.  The new
channel stuff was accidentally closing stdin and stdout on shutdown,
making the subsequent reboot rather interesting. 

The error message from the TUN/TAP backend was fixed. 

Fixed a crash caused by the gdb cleanup when gdb hadn't run. 

The window IDs in xterms are now gone. 

Ptys are now hung up properly.  So, disconnecting from a console or serial
line on a pty will no longer hang UML.  

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at 
	http://user-mode-linux.sourceforge.net/dl-sf.html

				Jeff

