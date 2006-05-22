Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWEVTJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWEVTJt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWEVTJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:09:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:27841 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751069AbWEVTJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:09:48 -0400
Date: Mon, 22 May 2006 21:09:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       jakub@redhat.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, kraxel@suse.de
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range patch
Message-ID: <20060522190947.GA6730@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain> <20060519174303.5fd17d12.akpm@osdl.org> <20060522162949.GG30682@devserv.devel.redhat.com> <4471EA60.8080607@vmware.com> <20060522101454.52551222.akpm@osdl.org> <20060522172710.GA22823@elte.hu> <Pine.LNX.4.64.0605221045140.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605221045140.3697@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Backwards compatibility is absolutely paramount. Much more important 
> than just about anything else.

ok, and i agree that in this particular case we should not break older 
glibc. And that's the primary direction i'm going into: i've been trying 
to create CONFIG_COMPAT_VDSO [which defaults to =y] variants that both 
keep old glibc working and still have the randomization code active. 
Having the code active by default is very important because breakages 
get noticed early on, etc.

But wrt. binary compatibility, the vdso (ignoring for a moment that it's 
tied to other parts of glibc) is kind of border line. Nothing but glibc 
knows about its internal structure. So i dont think "binary 
compatibility" per se is violated: no app breaks. This is more analogous 
to the situation where say old modutils cannot read new modules and the 
kernel wont boot at all.

The _real_ argument i think, and the biggest practical difference is 
that glibc is _much harder to upgrade_ than other system utilities. So 
by _that_ argument i'd say we should avoid forcing a glibc dependency 
whenever possible - and that might as well be the right thing to do in 
this particular case.

Also, what makes this a bit different for me is that this is a security 
feature which always has a "should the fire-door be default-open or 
default-closed" type of question, and that's why i'm reluctant to give 
up - and at least have compat-vdso code working that triggers most of 
the randomization codepaths too.

	Ingo
