Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbTAIKlp>; Thu, 9 Jan 2003 05:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265886AbTAIKlp>; Thu, 9 Jan 2003 05:41:45 -0500
Received: from host1.trilliumlane.com ([67.40.6.137]:53934 "EHLO
	mail1.trilliumlane.com") by vger.kernel.org with ESMTP
	id <S265872AbTAIKlo>; Thu, 9 Jan 2003 05:41:44 -0500
Date: Thu, 9 Jan 2003 02:50:25 -0800
Mime-Version: 1.0 (Apple Message framework v551)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: oss bug introduced since 2.4.18?
From: Paul Forgey <paulf@trilliumlane.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <288553BE-23C0-11D7-A604-00039384AA90@trilliumlane.com>
X-Mailer: Apple Mail (2.551)
X-OriginalArrivalTime: 09 Jan 2003 10:47:25.0468 (UTC) FILETIME=[7F2D45C0:01C2B7CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since upgrading from 2.4.18 to 2.4.20, I've had a problem unmapping 
mmap'd sound buffers.  This problem is still present in 21-pre3.  
Machine is a P-III Celeron on an Asus CUSL-2 board.

I have a program which captures audio for streaming using mmap 
(verified with ptrace).  When I'm done, I issue a SNDCTL_DSP_SETTRIGGER 
with pointer to int value of 0 and munmap the buffer.  There is about a 
2/3 chance the munmap call will never return and the process will not 
die.  At this point, I can still login to the machine through another 
window or the console, but any process making system calls which I have 
not yet determined follow the same fate as the original problem 
process.  So far, I've found the 'who' and 'ps' commands do this.  The 
ps output runs until what seems to be just before reporting the 
original hung process.

This is not a problem if I boot with .18, but I need to run >= 20 for 
my network card.

I'm using a Sound Blaster Live 5.1, and I've tried switching from the 
supplied drivers in the kernel to using Creative's open source drivers 
with the same results.  So it may be in the core sound and not specific 
to the sound card driver?

