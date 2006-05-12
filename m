Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWELODi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWELODi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWELODi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:03:38 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:19607 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932067AbWELODh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:03:37 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Andi Kleen <ak@suse.de>
Subject: Re: Segfault on the i386 enter instruction
Date: Fri, 12 May 2006 17:03:23 +0300
User-Agent: KMail/1.8.2
Cc: Tomasz Malesinski <tmal@mimuw.edu.pl>, linux-kernel@vger.kernel.org
References: <20060512131654.GB2994@duch.mimuw.edu.pl> <p734pzv73oj.fsf@bragg.suse.de>
In-Reply-To: <p734pzv73oj.fsf@bragg.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605121703.23366.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 May 2006 16:50, Andi Kleen wrote:
> Tomasz Malesinski <tmal@mimuw.edu.pl> writes:
> 
> > The code attached below segfaults on the enter instruction. It works
> > when a stack frame is created by the three commented out
> > instructions and also when the first operand of the enter instruction
> > is small (less than about 6500 on my system).
> 
> The difference is the value of the stack pointer when the page fault
> of extending the stack downwards occurs. For the long sequence 
> ESP is already changed when it happens. For ENTER the CPU undoes
> the change before raising the fault. The page fault handler
> checks the page fault against ESP to catch invalid references below
> the stack.
> 
> I don't think the 64bit kernel does anything different here than the 
> 32bit kernel. I tested it on a 32bit box and it faulted there too.

For me, it doesn't fault. I looked with strace. It doesn't fault even with
enter $64008, $0

Is it something in newest kernels? Mine is 2.6.16-rc5.
--
vda
