Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262657AbSJGWsO>; Mon, 7 Oct 2002 18:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263208AbSJGWsI>; Mon, 7 Oct 2002 18:48:08 -0400
Received: from [209.48.37.1] ([209.48.37.1]:42221 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id <S262745AbSJGWsG>;
	Mon, 7 Oct 2002 18:48:06 -0400
Date: Mon, 7 Oct 2002 15:53:40 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200210072253.g97MreU29529@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 bug related to virtual consoles
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc me on replies.

I'm running 2.5.40 on a cutting edge via embedded C3 motherboard. When I
turn off CONFIG_FB and CONFIG_VGA_CONSOLE I get this during bootup:
Unable to handle kernel NULL pointer dereference at virtual address 00000004    
 printing eip:                                                                  
c01e5a1d                                                                        
*pde = 00000000                                                                 
Oops: 0000                                                                      
                                                                                
CPU:    0                                                                       
EIP:    0060:[<c01e5a1d>]    Not tainted                                        
EFLAGS: 00010246                                                                
eax: c6ee4a00   ebx: 00000000   ecx: 00000001   edx: 00000000                   
esi: 00000000   edi: 00000000   ebp: c0399dc0   esp: c116fe70                   
ds: 0068   es: 0068   ss: 0068                                                  
Process init (pid: 1, threadinfo=c116e000 task=c116c040)                        
Stack: c6ee4a00 00000001 c6ee4a00 00000000 c01e5af8 00000000 00000001 00000000  
       c6427000 00000000 00000401 c116fec0 c01e924f 00000000 c6427000 00000001  
       c01d8b58 c6427000 c6ed9120 01024180 c6427000 c6bba2d0 00000006 c116ff70  
Call Trace: [<c01e5af8>] [<c01e924f>] [<c01d8b58>] [<c014813d>] [<c013de06>] [<]
Code: ff 52 04 8b 83 c0 9d 39 c0 5a 59 66 83 78 22 00 75 17 ba 00               
 <0>Kernel panic: Attempted to kill init!                                       

This is inside drivers/char/vt.c in vc_allocate just after the visual_init
call.

Related configs are:
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250_CONSOLE=y

If I turn either CONFIG_FB or CONFIG_VGA_CONSOLE back on it boots fine.
With CONFIG_FB I don't actually have any other FB related settings on and
I never actually use the frame buffer device.

Let me know if more information is needed. Thanks!
-Dave
