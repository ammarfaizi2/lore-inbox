Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVGLTbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVGLTbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 15:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVGLT3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 15:29:03 -0400
Received: from taxbrain.com ([64.162.14.3]:18908 "EHLO petzent.com")
	by vger.kernel.org with ESMTP id S262275AbVGLT2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 15:28:00 -0400
Message-ID: <02e201c58717$cb97adc0$4b010059@petzent.com>
From: "karl malbrain" <karl@petzent.com>
To: "Linux-Os@Analogic. Com" <linux-os@analogic.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9: serial_core: uart_open
Date: Tue, 12 Jul 2005 12:27:51 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Spam-Processed: petzent.com, Tue, 12 Jul 2005 12:24:09 -0700
	(not processed: message from valid local sender)
X-Return-Path: karl@petzent.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: petzent.com, Tue, 12 Jul 2005 12:24:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, 12 Jul 2005, karl malbrain wrote:

>> The uart_open code loops waiting for CD to be asserted (whenever CLOCAL
>> is not set).  The bottom of the loop contains the following code:
>>
>> up(&state->sem);
>> schedule();
>> down(&state->sem);
>>
>> if( signal_pending(current) )
>>   break;
>>
>> When I issue an open("/dev/ttyS1", O_RDWR) from a terminal session on
>> the console, the system seems to come to a stop in this loop until the
>> process is killed.  I suspect that the scheduler is choosing this process
>> to run again because of an elevated console priority of some sort.
>>
>> Is there a kernel mechanism to put a process to sleep until awakened by
>> an event to replace this looping behaviour?
>>
>> Thanks, karl malbrain, malbrain-at-yahoo-dot-com
>>

>In the first place, you should perform an open(O_NDELAY), so the open
>returns immediately with anything that has potential "modem-control".
>Then you can set the device to blocking using fcntl(F_GETFL), F_SETFL.

>Also, the task that is waiting for the open() is sleeping. That's
>what schedule() does.

>Cheers,
>Dick Johnson

I'm looking for the POSIX behaviour of delaying the open until CD is
asserted by the modem.  If schedule() doesn't select another process to run,
no wonder the system is hung at this point, because the uart_open loop
doesn't break until CD is asserted by the modem.  This sounds like a serious
bug.

karl_m



