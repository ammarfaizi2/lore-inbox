Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbUK0CCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbUK0CCv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbUK0Bod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:44:33 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:61079 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261902AbUK0Blm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 20:41:42 -0500
Date: Sat, 27 Nov 2004 02:41:34 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Tomas Carnecky <tom@dbservice.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       matthew@wil.cx, dwmw2@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <41A7D814.6060900@dbservice.com>
Message-ID: <Pine.LNX.4.60.0411270234520.13348@alpha.polcom.net>
References: <19865.1101395592@redhat.com> <Pine.LNX.4.60.0411270049520.29718@alpha.polcom.net>
 <41A7D814.6060900@dbservice.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2004, Tomas Carnecky wrote:

> Grzegorz Kulewski wrote:
>> On Thu, 25 Nov 2004, David Howells wrote:
>> 
>>> (b) Make kernel file #include the user file.
>> 
>> 
>> Does kernel really need to include user headers? When it is definition
>> of some const then it should be defined in one file (to be sure it has
>> only one definition).
>
> You have do define a interface between the kernel and the userspace..
> you either include kernel headers from userspace (with a lot of __KERNEL__ in 
> them) or you make separate headers with the definitions and include them in 
> both kernel and userspace (better).
> BTW, these are not userspace headers like the ones in /usr/include, those are 
> just special headers preparated so that they can be included both from the 
> kernel and userspace.

Ok, so maybe do it in this way:
1. common headers (included by 2. and 3.)
2. kernel headers (things only for kernel + included 1.)
3. userspace headers (things only for userspace + included 1.)

This way we will have no ifdefs, one definition per thing, user code in 
userspace and kernel code in kernelspace only.


>> But user headers may have some compatibility hacks
>> that kernel do not need (and even maybe does not want) to have.
>
> About the compatibility hacks.. now it's time to remove them, together with 
> this change. I don't think this will happen before 2.7/2.8 and until then all 
> should have changed their code.
> If you announce these changes soon enough and the developers have enough time 
> to change their code, I don't see any problems.
> Maybe you also could wrap these definitions in some #ifdef's and mark them as 
> deprecated and write somewhere that they'll be removed in the next stable 
> tree (2.8). So you could check if a library compiles with the new headers or 
> if it still uses some old definitions.

Are you talking about breaking userspace (API and ABI) compatibility? And 
possibly breaking compatibility with older versions of standards? I do not 
think it could happen. (Well at least not for common widely-used APIs).

Instead we can place such userspace only hacks in 3.


Thanks,

Grzegorz Kulewski

