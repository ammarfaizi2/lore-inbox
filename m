Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbUBWPYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbUBWPYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:24:43 -0500
Received: from smtpq3.home.nl ([213.51.128.198]:49281 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S261922AbUBWPYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:24:41 -0500
Message-ID: <403A1B21.8000100@keyaccess.nl>
Date: Mon, 23 Feb 2004 16:24:17 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Coywolf Qi Hunt <coywolf@greatcn.org>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: BOOT_CS
References: <c16rdh$gtk$1@terminus.zytor.com> <40375261.6030705@greatcn.org> <20040221163213.GB15991@mail.shareable.org> <403984DD.4030108@greatcn.org> <20040223143056.GC30321@mail.shareable.org>
In-Reply-To: <20040223143056.GC30321@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

> Your patch uses two instructions to flush the queue (push+ret) instead
> of one (jmp or ljmp).  Is that documented as reliable?

No. The current arch manuals seem to say nothing definite, but Intel's 
386 manual (ie, the cpu, not the arch) from 1986 explicitly says "after 
setting PG, a jump must follow immediately".

> I can easily imagine an implementation which decodes one instruction
> after a mode change predictably, but not two.
> 
> I doubt that it makes a difference - we're setting PG, not changing 
> the instruction format - but I'd like us to be sure it cannot fail on
>  things like 386s and 486s, and similar non-Intel chips.

I believe you should either keep it as is, do the long jump (although I 
don't believe that to be necessary: setup.s already long jumped to us) 
or only delete the indirect jump (we've just been longjumped to, and 
identity-mapped, so everything would seem to be normalised already).

In any case, please jump directly after setting PG.

Rene.


