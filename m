Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268650AbTGIWaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268737AbTGIWaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:30:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16902 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S268650AbTGIWaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:30:15 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: modutils-2.3.15 'insmod'
Date: 9 Jul 2003 15:44:42 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bei5sq$9ba$1@cesium.transmeta.com>
References: <Pine.LNX.4.53.0307091119450.470@chaos> <jer84zln59.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <jer84zln59.fsf@sykes.suse.de>
By author:    Andreas Schwab <schwab@suse.de>
In newsgroup: linux.dev.kernel
>
> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> |> It is likely that malloc(0) returning a valid pointer is a bug
> |> that has prevented this problem from being observed.
> 
> It's not a bug, it's a behaviour explicitly allowed by the C standard.
> 

The bug is in xmalloc, meaning that it assumes that returning NULL is
always an error.  Presumably xmalloc should look *either* like:

void *xmalloc(size_t s)
{
	void *p = malloc(s);
	
	if ( !p && s )
		barf();
	else
		return p;
}

... or ...

void *xmalloc(size_t s)
{
	void *p;

	/* Always return a valid allocation */
	if ( s == 0 ) s = 1;
	p = malloc(s);
	
	if ( !p )
		barf();
	else
		return p;
}
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
