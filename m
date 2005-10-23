Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVJWVaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVJWVaR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 17:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVJWVaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 17:30:16 -0400
Received: from smtpout.mac.com ([17.250.248.83]:30956 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750805AbVJWVaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 17:30:15 -0400
In-Reply-To: <1130064287.2775.3.camel@laptopd505.fenrus.org>
References: <505ru-8qi-1@gated-at.bofh.it> <505Lp-B4-81@gated-at.bofh.it> <506QZ-2cH-3@gated-at.bofh.it> <5070Y-2qP-23@gated-at.bofh.it> <507ac-2Cm-25@gated-at.bofh.it> <507NL-3Em-29@gated-at.bofh.it> <507Xd-3QT-19@gated-at.bofh.it> <50xnU-7s2-37@gated-at.bofh.it> <E1ETdIF-0000h8-Iw@be1.lrz> <1130064287.2775.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D1C65891-3300-4537-8450-6AAC18251F45@mac.com>
Cc: 7eggert@gmx.de, "Vincent W. Freeh" <vin@csc.ncsu.edu>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Understanding Linux addr space, malloc, and heap
Date: Sun, 23 Oct 2005 17:29:50 -0400
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 23, 2005, at 06:44:47, Arjan van de Ven wrote:
>> But even if Vincend makes the next malloc/free/whatever to be  
>> fubar, or if he made the world explode, mprotect is still required  
>> to report an error if the requested action failed.
>
> but.. there's no proof yet that it failed...

Precisely.  The only code sample he's sent that exhibits this  
"problem" is buggy because it checks the wrong addresses for  
protected status.  In any case, if you _were_ going to try to change  
protection bits on malloc()ed memory, you would need to make  
_damn_sure_ that you didn't change the protection bits on internal  
data structures that malloc uses to keep track of allocations.  If  
you remove read or write privs on malloc-internal linked-list  
pointers, an attempt to malloc() or free() memory might (and probably  
will) crash.

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you  
looked at it in the right way, did not become still more complicated.
   -- Poul Anderson



