Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWJAJ14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWJAJ14 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 05:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWJAJ14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 05:27:56 -0400
Received: from ns2.suse.de ([195.135.220.15]:64181 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751402AbWJAJ14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 05:27:56 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Date: Sun, 1 Oct 2006 11:27:35 +0200
User-Agent: KMail/1.9.3
Cc: Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <Pine.LNX.4.64.0609301713460.3952@g5.osdl.org> <Pine.LNX.4.64.0609301748340.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609301748340.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610011127.35393.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Side note: it's entirely possible that the "unwinder" code shouldn't even 

How often do I need to repeat that it wasn't the dwarf2 unwinder that crashed 
here,  but the fallback code that is essentially just the old unwinder? Somehow 
I don't seem to get through. 

> try to return the address outside the page, since the first/last frame on 
> a page is likely to be special (ie it's an exception/interrupt kind of 
> thing), and it's entirely possible that the "page-level" loop is better at 
> handling that part too.
> 
> That way you wouldn't even need to make the exception frames haev the 
> dwarf info etc, because you could choose to just depend on knowing what 
> the format of such a page was. But that's obviously just an implementation 
> choice..
> 
> Doesn't that sound like it should be both fairly straightforward and 
> reasonable?

Ok I guess it would be possible to add another level of stack validation to
the unwinder if you insist of it. 

I don't think it would help all that much because the unwinder already does 
pretty good validation based on CFI and it wouldn't have avoided that 
particular problem anyways (which was already fixed in 2.6.18 BTW, Eric's 
bisect just managed to find a bad spot before 2.6.18) 

Also I still think the code will be fairly ugly to do this, but at least it's 
already written for the old unwinder. The x86-64 code needed
at least one state variable, requiring more function arguments
all over the unwinder, but it might be possible to do it without that.

-Andi
