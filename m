Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWIMWWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWIMWWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 18:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWIMWWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 18:22:37 -0400
Received: from gw.goop.org ([64.81.55.164]:55719 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751149AbWIMWWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 18:22:37 -0400
Message-ID: <450884A1.2060905@goop.org>
Date: Wed, 13 Sep 2006 15:22:25 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>
Subject: Re: Assignment of GDT entries
References: <450854F3.20603@goop.org> <Pine.LNX.4.64.0609131358090.4388@g5.osdl.org> <45087C78.20308@goop.org> <Pine.LNX.4.64.0609131454480.4388@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609131454480.4388@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> So I'd not be surprised if movign the TLS segments around would break 
> something. 
>   

I don't think so.  32-bit code running on x86-64 has different TLS 
selectors, and everything seems to work there...

> That said, numbers talk, bullshit walks. If the above just works a lot 
> better for all modern CPU's that all have 64-byte cachelines (because now 
> _everything_ is in that bigger cacheline), and if you can show that with 
> numbers, and nothing breaks in practice, then hey..
>   

My goal would be to do a minimal change which packs all the useful stuff 
together in a 64-byte line.  Ideally it would just use two 32-byte 
lines, but I don't think that's as important.

Caching effects are pretty hard to measure anyway, and with something as 
deeply x86-microarchitectural as this, I could imagine lots of other CPU 
cleverness which could obscure any simple measurement.  But packing 
things into a line certainly can't hurt.

I'll put something together, and see how it goes...

    J
