Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUDUWik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUDUWik (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 18:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUDUWik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 18:38:40 -0400
Received: from zero.aec.at ([193.170.194.10]:52235 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262431AbUDUWii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 18:38:38 -0400
To: dipankar@in.ibm.com
cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
References: <1Nt5d-84u-3@gated-at.bofh.it> <1NwPD-2RW-37@gated-at.bofh.it>
	<1NwPE-2RW-39@gated-at.bofh.it> <1Nx8Y-3ev-15@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 22 Apr 2004 00:38:34 +0200
In-Reply-To: <1Nx8Y-3ev-15@gated-at.bofh.it> (Dipankar Sarma's message of
 "Wed, 21 Apr 2004 23:10:16 +0200")
Message-ID: <m3r7uhardh.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> writes:

> On Wed, Apr 21, 2004 at 09:46:05PM +0100, Christoph Hellwig wrote:
>> On Thu, Apr 22, 2004 at 02:13:04AM +0530, Dipankar Sarma wrote:
>> > I think CPU_MASK_NONE can be used only for assignments. You need
>> > to actually declare a generic idle_cpu_mask and set it to CPU_MASK_NONE
>> > for all other archs. Of course, then the compiler will not be able
>> > to optimize it out :)
>> 
>> Well, there's a const keyword in C these days, no?

It is not strong enough in C unfortunately. It is still legal 
to change const variables, so the compiler has to take that into
account and it is hard for global variables. C++ is better here.

> OK, then I missed what optimization you were talking about or underestimated
> gcc. Can gcc do inter-procedural constant propagation ?

Only when the functions are inlined
(but it is much better at that than it used to be, gcc 3.4 can even
inline across multiple files and order doesn't matter anymore) 

-Andi

