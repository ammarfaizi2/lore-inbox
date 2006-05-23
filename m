Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWEWFJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWEWFJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 01:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWEWFJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 01:09:41 -0400
Received: from smtpout.mac.com ([17.250.248.183]:6356 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751257AbWEWFJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 01:09:40 -0400
In-Reply-To: <44700ACC.8070207@gmail.com>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
Cc: linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: OpenGL-based framebuffer concepts
Date: Tue, 23 May 2006 01:08:57 -0400
To: Manu Abraham <abraham.manu@gmail.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tentatively going with the assumption put forth by Jon Smirl in his  
future-of-linux-graphics document and the open-graphics-project group  
that 3d rendering is an absolutely essential part of any next- 
generation graphics system, I'd be interested in ideas on a new or  
modified /dev/fbX device that offers native OpenGL rendering  
support.  Someone once mentioned OpenGL ES as a possibility as it  
provides extensions for multiple-process windowing environments.   
Other requirements would obviously be the ability to allow client  
programs to allocate and share out chunks of graphics memory to other  
clients (later used as textures for compositing), support for  
multiple graphics cards with different hardware renderers over  
different busses, using DMA to transfer data between cards as  
necessary (and user-configurable policy about how to divide use of  
the cards), support for single or multiple framebuffers per GPU, as  
well as an arbitrary number of hardware and software viewports per  
framebuffer.  There would also need to be a way for userspace to trap  
and emulate or ignore unsupported OpenGL commands.  The kernel would  
need some rudimentary understanding of OpenGL to be able to handle  
buggy GPUs and prevent them from hanging the PCI bus (some GPUs can  
do that if sent invalid commands), but you obviously wouldn't want a  
full software renderer in the kernel.  The system should also support  
transmitting OpenGL textures, commands, and other data asynchronously  
over a TCP socket, though doing it locally via mmap would be far more  
efficient.  I'm probably missing other necessary generics, but that  
should provide a good discussion starter.

The necessary kernel support would include a graphics-memory  
allocator, resource management, GPU-time allocation, etc, as well as  
support for an overlaid kernel console.  Ideally an improved graphics  
driver like that would be able to dump panics directly to the screen  
composited on top of whatever graphics are being displayed, so you'd  
get panics even while running X.  If that kind of support was  
available in-kernel, fixing X to not need root would be far simpler,  
plus you could also write replacement X-like tools without half the  
effort.  Given that sort of support, a rootless xserver would be a  
fairly trivial wrapper over whatever underlying implementation there  
was.

Cheers,
Kyle Moffett

