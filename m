Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWHUEbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWHUEbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 00:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWHUEbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 00:31:18 -0400
Received: from web8809.mail.in.yahoo.com ([203.84.221.18]:57703 "HELO
	web8809.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S964884AbWHUEbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 00:31:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bkKw/X+NrXmCxIRF7xxkFRz8AkynfHW66gifMUPpy6pRFvwkAfiJoWSdYj4x3i1iwvIYXkvfeNjXcFVtszZ1VCCTEoBDWg9twoGh0WD9Ev1nMQRdb50Wr6qKml645vUJhtHTPu+NkER1R2pHnsx77j7adxiuArujmOBTxx4rEDo=  ;
Message-ID: <20060821043114.54716.qmail@web8809.mail.in.yahoo.com>
Date: Mon, 21 Aug 2006 05:31:14 +0100 (BST)
From: Dinesh Ahuja <mdlinux7@yahoo.co.in>
Subject: Trying to make kernel thread sleep
To: Kernel Newbies <kernelnewbies@nl.linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am trying to put kernel thread to sleep via
interruptible_sleep_on_timeout(). Body of kernel
thread function is as follows

static int print_taskinfo(void * data)
{
     wait_queue_head_t wait;
                                                      
                                   
init_waitqueue_head (&wait);
     for (;;)
     {
         // do something useful here.
         interruptible_sleep_on_timeout(&wait, HZ);  
         //check whether we have to break loop or 
continue.      
     }
}

I am facing following kernel oops :

Unable to handle kernel NULL pointer dereference at
virtual address 00000005
 printing eip:
c011905d
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c011905d>]    Tainted: PF
EFLAGS: 00010086

EIP is at interruptible_sleep_on_timeout [kernel] 0x2d
(2.4.20-6)
eax: c2cadfc4   ebx: 00000286   ecx: c2cadfac   edx:
00000001
esi: 00000064   edi: c8dc7540   ebp: c2cadfbc   esp:
c2cadfa4
ds: 0068   es: 0068   ss: 0068
Process insmod (pid: 3884, stackpage=c2cad000)
Stack: 00000000 c2cac000 00000f2b 00000000 c034c000
c8dc74c0 c2cadfec d087d1a1 
       00000001 c2cadfc8 c2cadfc8 00000000 00000000
00000000 00000000 d087d074 
       00000000 00000000 00000000 c010742d 00000000
00000000 00000000 
Call Trace:   [<d087d1a1>] print_taskinfo [hello1]
0x12d (0xc2cadfc0))
[<d087d074>] print_taskinfo [hello1] 0x0 (0xc2cadfe0))
[<c010742d>] kernel_thread_helper [kernel] 0x5
(0xc2cadff0))
 
Can anyone guide me where I am going wrong?

Regards
Dinesh


		
__________________________________________________________
Yahoo! India Answers: Share what you know. Learn something new
http://in.answers.yahoo.com/
