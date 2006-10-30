Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161352AbWJ3S5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161352AbWJ3S5z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161372AbWJ3S5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:57:55 -0500
Received: from smtpout.mac.com ([17.250.248.186]:34551 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161352AbWJ3S5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:57:54 -0500
In-Reply-To: <1162219080.2948.21.camel@laptopd505.fenrus.org>
References: <200610282350.k9SNoljL020236@freya.yggdrasil.com> <Pine.LNX.4.64.0610281651340.3849@g5.osdl.org> <A2B15573-3DDD-4F70-AC04-C37DBA3AC752@mac.com> <1162219080.2948.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D8540CD5-5223-4010-B1C3-8F90C0C422D9@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>, "Adam J. Richter" <adam@yggdrasil.com>,
       akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       matthew@wil.cx, pavel@ucw.cz, shemminger@osdl.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch] drivers: wait for threaded probes between initcall	levels
Date: Mon, 30 Oct 2006 13:56:45 -0500
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30, 2006, at 09:38:00, Arjan van de Ven wrote:
>> I admit the complexity is a bit high, but since the maximum  
>> nesting is bounded by the complexity of the hardware and the  
>> number of busses, and the maximum memory-allocation is strictly  
>> limited in the single-threaded case this could allow 64-way  
>> systems to probe all their hardware an order of magnitude faster  
>> than today without noticeably impacting an embedded system even in  
>> the absolute worst case.
>
> how much of this complexity goes away if you consider the scanning/ 
> probing as a series of "work elements", and you end up with a queue  
> of work elements that threads can pull work off one at a time (so  
> that if one element blocks the others just continue to flow). If  
> you then find, say, a new PCI bus you just put another work element  
> to process it at the end of the queue, or you process it  
> synchronously. Etc etc.

Well, I suppose the "trick" would be to ensure that the top-level  
code can probe multiple independent busses in parallel, while  
allowing certain of those to serialize their execution order for  
whatever reason without changing the resulting linear order.  This  
would make it possible to have independent pci.multithread_probe=1  
and scsi.multithread_probe=1 arguments so the sysadmin can force  
serialization for one subsystem if they don't have their device- 
numbering issues with that subsystem entirely sorted out.

Cheers,
Kyle Movvett
