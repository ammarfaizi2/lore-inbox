Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVDAKle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVDAKle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 05:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbVDAKle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 05:41:34 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:61410 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262696AbVDAKlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 05:41:31 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: AMD64 Machine hardlocks when using memset
Date: Fri, 1 Apr 2005 13:41:02 +0300
User-Agent: KMail/1.5.4
References: <3NTHD-8ih-1@gated-at.bofh.it> <3O99L-40N-9@gated-at.bofh.it> <424CD018.5000005@shaw.ca>
In-Reply-To: <424CD018.5000005@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504011341.02790.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 April 2005 07:37, Robert Hancock wrote:
> Stelian Pop wrote:
> > Just a thought: does deactivating cpufreq change anything ?
> > 
> > I haven't tested yet your program, but on my Asus K8NE-Deluxe very
> > strange things happen if cpufreq/powernow is activated *and* 
> > the cpu frequency is changed...
> 
> Didn't change anything for me, I tried deactivating cpufreq, still 
> crashes when I run that test program.
> 
> This is getting pretty ridiculous.. I've tried memory timings down to 
> the slowest possible, ran Memtest86 for 4 passes with no errors, and 
> it's been stable in Windows for a few months now. Still something is 
> blowing up in Linux with this test though..

If you want to dig deeper, go to assembler level.
That is, instead of using memset(), disassemble
your program and make your own

void my_memset(...)
{
	asm volatile(/* code sequence from your crashing prog*/);
}

and use that in your memsetting loop. Sure, it won't change anything,
but:

a) we will know exactly which instruction sequence drives
   your CPU/chipset crazy
b) others can try to reproduce without danger of memset being
   implemented differently on their perticular version of gcc/glibc/whatever
c) you can try other memsets in order to know more about this bug
   (for example, if inserting some NOPs in the my_memset body
   makes bug disappear will definitely point towards defective/
   overheating CPU. etc...)
--
vda

