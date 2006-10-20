Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992609AbWJTMWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992609AbWJTMWB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992611AbWJTMWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:22:00 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13014 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S2992609AbWJTMWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:22:00 -0400
From: Andi Kleen <ak@suse.de>
To: Vasily Tarasov <vtaras@openvz.org>
Subject: Re: [PATCH] diskquota: 32bit quota tools on 64bit architectures
Date: Fri, 20 Oct 2006 14:21:43 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jan Kara <jack@suse.cz>,
       Dmitry Mishin <dim@openvz.org>, Vasily Averin <vvs@sw.ru>,
       Kirill Korotaev <dev@openvz.org>,
       OpenVZ Developers List <devel@openvz.org>
References: <200610191232.k9JCW7CF015486@vass.7ka.mipt.ru> <p73hcy0b83k.fsf@verdi.suse.de> <200610200630.k9K6U4RU031798@vass.7ka.mipt.ru>
In-Reply-To: <200610200630.k9K6U4RU031798@vass.7ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610201421.43611.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 October 2006 08:30, Vasily Tarasov wrote:
> Andi Kleen wrote:
> 
> <snip>
> > Thanks. But the code should be probably common somewhere in fs/*, not
> > duplicated.
> <snip>
> 
> Thank you for the comment!
> I'm not sure we should do it. If we move the code in fs/quota.c for example,
> than this code will be compiled for _all_ arhitectures, not only for x86_64 and ia64.
> Of course, we can surround this code by #ifdefs <ARCH>, but I thought this is 
> a bad style... Moreover looking through current kernel code, I found out that
> usually code is duplicated in such cases.

Well it doesn't hurt them even if not strictly needed and it's better to have common code for 
this. BTW you have to convert over to compat_alloc_* for this as Christoph stated
because set_fs doesn't work on all architectures. Best you use the compat_* types too.

-Andi
