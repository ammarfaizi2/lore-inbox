Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318034AbSGRGYn>; Thu, 18 Jul 2002 02:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318035AbSGRGYn>; Thu, 18 Jul 2002 02:24:43 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:13725 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S318034AbSGRGYk>;
	Thu, 18 Jul 2002 02:24:40 -0400
From: irfan_hamid@softhome.net
To: linux-kernel@vger.kernel.org
Reply-To: irfan_hamid@softhome.net
Subject: cli()/sti() clarification
Date: Thu, 18 Jul 2002 00:27:40 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.52.197.1]
Message-ID: <courier.3D365FDC.0000712F@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I added two system calls, blockintr() and unblockintr() to give cli()/sti() 
control to userland programs (yes I know its not advisable) but I only want 
to do it as a test. My test program looks like this: 

	blockintr();
	/* Some long calculations */
	unblockintr(); 

The problem is that if I press Ctrl+C during the calculation, the program
terminates. So I checked the _syscallN() and __syscall_return() macros to 
see if they explicitly call sti() before returning to userspace, but they 
dont. 

Reading the lkml archives, I found that cli() disables only the interrupts, 
exceptions are allowed, so it makes sense that the SIGINT was delivered, but 
if thats the case, then how come the SIGINT was delivered from the Ctrl+C? 
Doesnt this mean that the SIGINT signal was generated as a result of the 
keyboard interrupt? 

I know I am missing something here, would appreciate if someone could point 
me in the right direction. 

Regards,
Irfan Hamid.
