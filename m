Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbTDFW3u (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 18:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbTDFW3u (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 18:29:50 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:57093
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263144AbTDFW3s (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 18:29:48 -0400
Date: Sun, 6 Apr 2003 18:36:34 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Ingo Molnar <mingo@elte.hu>
Subject: 2.5.66-(bk) == horrible response times for non X11 applications
Message-ID: <Pine.LNX.4.50.0304061757240.2268-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The X server is not reniced nor are any of the called tasks. This is very 
easy to reproduce by doing the following;

open two xterms, run glxgears from one and then 5 or so seconds after that 
run an application which you can easily determine completion, such as 
ifconfig. You will notice that the console app doesn't make much progress 
and essentially get's starved.

ifconfig      R 00000000 5738320  1213   1032                     (NOTLB)       
Call Trace:                                                                     
 [<c011ee20>] autoremove_wake_function+0x0/0x40                                 
 [<c02b6462>] generic_make_request+0x112/0x1b0                                  
 [<c011dc4d>] io_schedule+0x2d/0x40                                             
 [<c015851a>] __wait_on_buffer+0xba/0xc0                                        
 [<c011ee20>] autoremove_wake_function+0x0/0x40     

glxgears      S C010A1E8 4265977488  1209   1019                   (NOTLB)    
Call Trace:                                                                     
 [<c010a1e8>] common_interrupt+0x18/0x20                                        
 [<c01298d5>] schedule_timeout+0xb5/0xc0                                        
 [<c03e8490>] unix_poll+0x20/0x90                                               
 [<c0391e69>] sock_poll+0x19/0x20                                               
 [<c0169c22>] do_select+0x132/0x270                                             
 [<c0169960>] __pollwait+0x0/0xa0         

Afflicted system was;

K6 500MHz laptop
128M RAM w/ 8M shared (Trident X11 Server)

This was not reproduceable with 2.4.18-3 nor with 2.5.66 and the 
following patch applied;

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.66/2.5.66-mm3/broken-out/sched-interactivity-backboost-revert.patch

-- 
function.linuxpower.ca
