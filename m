Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWHHXgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWHHXgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 19:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbWHHXgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 19:36:50 -0400
Received: from ns1.suse.de ([195.135.220.2]:14232 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030319AbWHHXgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 19:36:49 -0400
To: Don Zickus <dzickus@redhat.com>
Cc: fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <20060710233219.GF16215@in.ibm.com>
	<20060711010815.GB1021@host0.dyn.jankratochvil.net>
	<m1d5c92yv4.fsf@ebiederm.dsl.xmission.com>
	<m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
	<20060804210826.GE16231@redhat.com>
	<m164h8p50c.fsf@ebiederm.dsl.xmission.com>
	<20060804234327.GF16231@redhat.com>
	<m1hd0rmaje.fsf@ebiederm.dsl.xmission.com>
	<20060807174439.GJ16231@redhat.com>
	<m17j1kctb8.fsf@ebiederm.dsl.xmission.com>
	<20060807235727.GM16231@redhat.com>
From: Andi Kleen <ak@suse.de>
Date: 09 Aug 2006 01:36:33 +0200
In-Reply-To: <20060807235727.GM16231@redhat.com>
Message-ID: <p73psfaol4u.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Zickus <dzickus@redhat.com> writes:
> > 
> > Odd.  I wonder if I'm missing a serializing instruction somewhere,
> > to ensure the effects of ``self modifying code'' aren't a problem.
> > As I read Intels Documentation if you have a jump before you get
> > to the code there shouldn't be a problem.
> > 
> > Still that doesn't really explain bytes_out.
> > 

Sounds nasty.

> 
> So I narrowed down the problem but it isn't obvious to me why this problem
> exists.  Basically, even though bytes_out is supposed to be initialized to
> 0, it becomes -1 before entering decompress_kernel().  Of course, the
> fallout is in flush_window() bytes_out wounds up being one less than
> outcnt and hence my original problem.
> 
> Any thoughts on how to debug where this could be getting corrupted?  

Use a simulator (hopefully you can reproduce it in there) like qemu
or AMD SimNow and set a watch point on the address?

Or try to find someone who has a Intel target probe to help you out.

-Andi
