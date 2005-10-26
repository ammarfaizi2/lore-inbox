Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVJYX4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVJYX4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 19:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVJYX4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 19:56:16 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:50001 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932490AbVJYX4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 19:56:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=AZCtbf2hx8NuAKOzoUULMgaYY9xkhzIedxigRNCp7QcShalzRZvCvk5lniIDziQuvbqHrQ5JagCfJ4TueckDNQmrgL1ajMPEVy6mhsdJbhQnYaubq0bv3tnFSrA7UHTRYas3z+ThPBqFMI0TT/V4W+4YtM58TVV4XazOfucv+s8=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 4/6] x86_64: fix L1_CACHE_SHIFT_MAX for Intel EM64T [for 2.6.14?]
Date: Wed, 26 Oct 2005 02:00:15 +0200
User-Agent: KMail/1.8.3
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
References: <20051025221105.21106.95194.stgit@zion.home.lan> <200510260044.26138.blaisorblade@yahoo.it> <200510260133.03425.ak@suse.de>
In-Reply-To: <200510260133.03425.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510260200.16501.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 01:33, Andi Kleen wrote:
> On Wednesday 26 October 2005 00:44, Blaisorblade wrote:
> > For what I see, that's based on the tradeoff between space and contention
> > - for instance there are few zones only, so there's no big waste.

> If space is precious it shouldn't be padded at all.
Ah, when the structure has many instances padding should be reduced, you mean. 
But well, I think slab itself adds some padding to separate instances, for 
this effect and for cache colouring (I guess that means to prevent too many 
different things from being allocated on addresses matching on the low-order 
bits, so that inserting one in the cache means evicting another of the two - 
it's something I guessed when I studied set-associative caches).

> > In  practice, interpreting !X86_GENERIC as "I will run this kernel on
> > _this_ processor" could also be done.
>
> That is what it always meant yes.
>
> > However, in case you didn't note, max_align is never enough on EM64T
> > currently, right?
>
> I will prepare patches for .15 to remove it completely, that should fix
> that problem.
Making L1_CACHE_SHIFT_MAX and L1_CACHE_SHIFT match, right? Or forcing all 
architectures to support something like X86_GENERIC?

Also, 

#define L1_CACHE_BYTES  (1 << L1_CACHE_SHIFT)

should probably be made general, while at it.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com
