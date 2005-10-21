Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbVJUP6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVJUP6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVJUP6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:58:51 -0400
Received: from [195.23.16.24] ([195.23.16.24]:43684 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S965003AbVJUP6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:58:50 -0400
Message-ID: <43591036.6000702@grupopie.com>
Date: Fri, 21 Oct 2005 16:58:46 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
       "Vincent W. Freeh" <vin@csc.ncsu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Understanding Linux addr space, malloc, and heap
References: <4358F0E3.6050405@csc.ncsu.edu>	 <1129903396.2786.19.camel@laptopd505.fenrus.org>	 <4359051C.2070401@csc.ncsu.edu>	 <1129908179.2786.23.camel@laptopd505.fenrus.org>	 <9EF45D4BE7AB7134B6342106@Satori.nominet.org.uk> <1129909657.2786.25.camel@laptopd505.fenrus.org>
In-Reply-To: <1129909657.2786.25.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Fri, 2005-10-21 at 16:37 +0100, Alex Bligh - linux-kernel wrote:
> 
>>--On 21 October 2005 17:22 +0200 Arjan van de Ven <arjan@infradead.org> 
>>wrote:
>>
>>
>>>Ok I meant in the "while adhering to the standard" :)
>>
>>More precisely, as per the man page:
>>
>>>POSIX.1b says that mprotect can be used only on regions of memory
>>>obtained from mmap(2).
>>
>>But what is interesting (if anything) is this:
>>
>>>ERRORS
>>>       EINVAL addr is not a valid pointer, or not a  multiple  of
>>>       PAGESIZE.
>>
>>So if he calls mprotect with memory allocated by malloc (which should
>>fail), why doesn't he get EINVAL? He says it returns 0 (meaning it
>>succeeded). Which it shouldn't (unless he is stupendously lucky in
>>malloc's allocation, in which case it should work).
> 
> 
> it succeeds all right; it just does other things than you expect
> perhaps ;)
> 
> your alignment code had a bug, so it would align potentially to the
> wrong piece of memory

Actually, it should give a SIGSEGV for the first byte allocated, 
although I agree that it might not work for any other byte allocated in 
the case where malloc returns a pointer just at the end of a page.

I just tested the sample code and in fact I do get a SIGSEGV.

What kernel version / architecture are you testing this on?

-- 
Paulo Marques
Software Development Department - Grupo PIE, S.A.
Phone: +351 252 290600, Fax: +351 252 290601
Web: www.grupopie.com

The rule is perfect: in all matters of opinion our
adversaries are insane.
Mark Twain
