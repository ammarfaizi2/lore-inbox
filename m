Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314477AbSDWWn6>; Tue, 23 Apr 2002 18:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314480AbSDWWn5>; Tue, 23 Apr 2002 18:43:57 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:27914 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S314477AbSDWWn5>;
	Tue, 23 Apr 2002 18:43:57 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200204232242.g3NMgaW215059@saturn.cs.uml.edu>
Subject: Re: Why HZ on i386 is 100 ?
To: matti.aarnio@zmailer.org (Matti Aarnio)
Date: Tue, 23 Apr 2002 18:42:35 -0400 (EDT)
Cc: rml@tech9.net (Robert Love), torvalds@transmeta.com (Linus Torvalds),
        mark@mark.mielke.cc (Mark Mielke), davidm@hpl.hp.com,
        davidel@xmailserver.org (Davide Libenzi), linux-kernel@vger.kernel.org
In-Reply-To: <20020417110440.G12961@mea-ext.zmailer.org> from "Matti Aarnio" at Apr 17, 2002 11:04:40 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio writes:
> On Wed, Apr 17, 2002 at 02:01:42AM -0400, Robert Love wrote:
>> On Wed, 2002-04-17 at 01:34, Linus Torvalds wrote:

>>> No, it also makes it much easier to convert to/from the standard UNIX time
>>> formats (ie "struct timeval" and "struct timespec") without any surprises,
>>> because a jiffy is exactly representable in both if you have a HZ value
>>> of 100 or 100, but not if your HZ is 1024.
>>
>> Exactly - this was my issue.  So what _was_ the rationale behind Alpha
>> picking 1024 (and others following)?  More importantly, can we change to
>> 1000?
>
> Alpha processors don't have full division hardware, they have to
> iterate it one bit at the time. They do have a flash multiplier,
> and a barrel-shifter.  Shifts take one pipeline cycle, like to
> addition and substraction.  Multiply takes 6-12 depending on model,
> but division takes 64...

Division by 1000 is a UMULH followed by a right shift.
So maybe it costs you one cycle more than division by 1024 would.
