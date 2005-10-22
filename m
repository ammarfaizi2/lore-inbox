Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbVJVT1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVJVT1Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 15:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVJVT1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 15:27:16 -0400
Received: from smtpout.mac.com ([17.250.248.97]:56815 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751231AbVJVT1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 15:27:16 -0400
In-Reply-To: <43591652.6080505@csc.ncsu.edu>
References: <4358F0E3.6050405@csc.ncsu.edu> <1129903396.2786.19.camel@laptopd505.fenrus.org> <4359051C.2070401@csc.ncsu.edu> <1129908179.2786.23.camel@laptopd505.fenrus.org> <43590B23.2090101@csc.ncsu.edu> <je64rqlued.fsf@sykes.suse.de> <43591652.6080505@csc.ncsu.edu>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8A96F014-05E9-48A3-BA5E-344448948A48@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Understanding Linux addr space, malloc, and heap
Date: Sat, 22 Oct 2005 15:27:06 -0400
To: "Vincent W. Freeh" <vin@csc.ncsu.edu>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 21, 2005, at 12:24:50, Vincent W. Freeh wrote:
> I guess I live in a different world.  I do lots of things I'm not  
> "supposed" to do.

So why are you complaining that it doesn't work?  "Doctor, it hurts  
when I use my toes to hold a nail as I hammer it in!" "Well don't do  
that then!"

> Moreover, it is very sensible and usable to mprotect malloc pages.

DANGER! DANGER WILL ROBINSON! DANGER!  malloc() is *NOT* guaranteed  
or even theoretically implemented to return pages.  It might return  
all memory at some random 16-byte offset into a page.  If you make  
malloc'ed memory read only, you might make malloc()-internal data  
read-only too and cause malloc() to crash.  YOU CANNOT RELY ON THIS  
TO WORK!!! Is that sufficiently clear?  It may work for you, and it  
may not, but when it breaks, don't whine on the LKML.

> I have implemented simple sandboxing this way.  For my dissertation  
> I implemented a DSM by mprotect'g malloc'd memory.  This system  
> worked for >6 on several version of Linux and SunOS.  I actually  
> have a better track record for this technique than for some things  
> that are within the specifications.

If it works for you, good luck, but don't try to tell us that it's  
wrong when it breaks in a very documented way.

Cheers,
Kyle Moffett

--
Premature optimization is the root of all evil in programming
   -- C.A.R. Hoare



