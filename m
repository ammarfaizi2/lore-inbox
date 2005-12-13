Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbVLMJke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVLMJke (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVLMJke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:40:34 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49870 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964807AbVLMJkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:40:33 -0500
Date: Tue, 13 Dec 2005 10:39:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213093949.GC26097@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213090219.GA27857@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213090219.GA27857@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Dec 13, 2005 at 08:54:41AM +0100, Ingo Molnar wrote:
> > - i did not touch the 'struct semaphore' namespace, but introduced a
> >   'struct compat_semaphore'.
> 
> Because it's totally braindead.  Your compat_semaphore is a real 
> semaphore and your semaphore is a mutex.  So name them as such.

well, i had the choice between a 30K patch, a 300K patch and a 3000K 
patch. I went for the 30K patch ;-)

> > - i introduced a 'type-sensitive' macro wrapper that switches down() 
> >   (and the other APIs) to either to the assembly variant (if the 
> >   variable's type is struct compat_semaphore), or switches it to the new 
> >   generic mutex (if the type is struct semaphore), at build-time. There 
> >   is no runtime overhead due to this build-time-switching.
> 
> And this one is probably is a great help to win the obsfucated C 
> contests, but otherwise just harmfull.

i never found it to be harmful in any way, and we've now got a year of 
experience with them. Could you elaborate?

	Ingo
