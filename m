Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbTEMSmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbTEMSmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:42:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46350 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263023AbTEMSli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:41:38 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: hammer: MAP_32BIT
Date: 13 May 2003 11:54:02 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b9rf0a$qo7$1@cesium.transmeta.com>
References: <3EBB5A44.7070704@redhat.com> <3EBBE7E2.1070500@redhat.com> <20030510014803.GA16407@averell> <1052597418.1881.2.camel@lapdancer.baythorne.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1052597418.1881.2.camel@lapdancer.baythorne.internal>
By author:    David Woodhouse <dwmw2@infradead.org>
In newsgroup: linux.dev.kernel
>
> On Sat, 2003-05-10 at 02:48, Andi Kleen wrote:
> > > Oh, and please rename MAP_32BIT to MAP_31BIT.  This will save nerves on
> > > all sides.
> > 
> > I bet changing it will cost more nerves in supporting all these people
> > whose software doesn't compile anymore. And it's not really a lie. 2GB 
> > is 32bit too.
> 
> If that's _really_ an issue, then also provide MAP_32BIT which does what
> its name implies. 
> 
> Anyone who was using MAP_32BIT in the knowledge that it really limits to
> 31 bits gets the breakage they deserve for not reporting and fixing the
> problem at the time.
> 

Agreed.

That being said, I think a more flexible scheme is called for; I still
would like to suggest the MAP_MAXADDR and MAP_MAXADDR_ADVISORY flags
that I mentioned earlier.

If people really want to retain the (rarely used) suggestion address,
I'd suggest making the address argument a pointer to a structure:

struct map_maxaddr {
	void *search;	/* Suggestion address */
	void *min;	/* Lowest acceptable address */
	void *max;	/* Maximum acceptable address */
};

... however, it seems like overkill to me.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
