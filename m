Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263788AbUEGU1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbUEGU1C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUEGU0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:26:19 -0400
Received: from main.gmane.org ([80.91.224.249]:13999 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263766AbUEGUSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:18:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <ajp@aripollak.com>
Subject: 2.6.6-rc3-mm2 oops in psmouse/serio after resuming from APM suspend-to-ram
Date: Fri, 07 May 2004 16:18:41 -0400
Message-ID: <409BEF21.6040206@aripollak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: wve202.resnet.neu.edu
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a Thinkpad T41 after going into suspend via APM and then resuming, 
the psmouse driver seems to crash after resetting itself, at which point 
the PS/2 mouse device (obviously) stops responding and I can't unload 
the psmouse module. I don't know if this is a new bug or not, as this is 
the first time I'm trying APM suspend on this laptop. The oops and the 
kernel messages before it:

  Synaptics Touchpad, model: 1
   Firmware: 5.9
   Sensor: 44
   new absolute packet format
   Touchpad has extended capability bits
   -> multifinger detection
   -> palm detection
   -> pass-through port
   printing eip:
  c0206121
  Oops: 0002 [#1]
  PREEMPT
  CPU:    0
  EIP:    0060:[__serio_unregister_port+17/64]    Not tainted VLI
  EFLAGS: 00010246   (2.6.6-rc3-mm2)
  EIP is at __serio_unregister_port+0x11/0x40
  eax: ec67b534   ebx: ec67b504   ecx: 00000000   edx: 00000000
  esi: c02d7a60   edi: c02d79a0   ebp: c02d79c0   esp: efda7f94
  ds: 007b   es: 007b   ss: 0068
  Process kseriod (pid: 104, threadinfo=efda7000 task=efdd3130)
  Stack: ed37b000 f0920d5b ec6813c4 ec6813bc c0205dfd efda7000 fffff000 
efda7fc0
         efda7000 c0205e85 c027b1d7 00000000 efdd3130 c0113f80 00100100 
00200200
         00000000 00000000 00000000 c0205e40 00000000 00000000 00000000 
c0103d7d
  Call Trace:
   [__crc_unlock_buffer+2625559/3107416] psmouse_disconnect+0x2b/0x90 
[psmouse]
   [serio_handle_events+157/224] serio_handle_events+0x9d/0xe0
   [serio_thread+69/320] serio_thread+0x45/0x140
   [default_wake_function+0/16] default_wake_function+0x0/0x10
   [serio_thread+0/320] serio_thread+0x0/0x140
   [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18

Code: 00 5b c3 8d b4 26 00 00 00 00 ba 04 00 00 00
e9 76 fe ff ff 8d b6 00 00 00 00 53 89 c3 e8 f8 fb ff ff 8d 43 30 8b 53 
30 8b 48 04 <89> 4a 04 89 11 89 40 04 89 43 30 8b 43 2c 85 c0 74 07 8b 50 18

