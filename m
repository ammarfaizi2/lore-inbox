Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVLXMEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVLXMEU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 07:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVLXMEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 07:04:20 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62867 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932432AbVLXMET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 07:04:19 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: 4k stacks
Date: Sat, 24 Dec 2005 14:03:38 +0200
User-Agent: KMail/1.8.2
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512241403.38482.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 December 2005 23:53, linux-os (Dick Johnson) wrote:
> 
> Yesterday I sent a patch to add stack-poison so the stack usage
> could be observed.
> 
> Today I wrote a small program and tested the stack usage. Both
> the program and the patch is attached. The result is:
> 
> Offset : 2ec8f000	Available Stack bytes = 3104
> Offset : 2ecb1000	Available Stack bytes = 3104
> Offset : 2ee5f000	Available Stack bytes = 20
> Offset : 2f36d000	Available Stack bytes = 3104
> Offset : 2fd09000	Available Stack bytes = 3012
> Offset : 2fd0b000	Available Stack bytes = 3312
> Offset : 2fd0f000	Available Stack bytes = 2132
> Offset : 2fd2f000	Available Stack bytes = 2744
> Offset : 2fd57000	Available Stack bytes = 2900
> Offset : 2fdd5000	Available Stack bytes = 1400
> Offset : 2fe35000	Available Stack bytes = 2832
> Offset : 2ff3f000	Available Stack bytes = 776
> Offset : 2ff45000	Available Stack bytes = 3188
> 
> This, after compiling the kernel. I did not have 4k stacks
> enabled for this test so any crashing of the stack beyond
> one page will not hurt the system. This was on linux-2.6.13.4.
> 
> Anyway, I tried to enable 4k stacks and the machine would
> not boot past trying to install the first module. It just
> stopped with the interrupts disabled. So, I am now rebuilding
> the kernel back as I write this. That's why I am using 2.6.13
> at the moment.
> 
> Anyway, getting down to 20 bytes of stack-space available
> seems to be pretty scary.

+       movl    %esp, %edi
+       movl    %edi, %ecx
+       andl    $~0x1000, %edi
+       subl    %edi, %ecx

ecx will be equal to ?

+       movb    $'Q', %al
+       rep     stosb
--
vda
