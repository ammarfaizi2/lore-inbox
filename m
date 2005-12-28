Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVL1TYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVL1TYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 14:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVL1TYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 14:24:04 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:4506 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S964877AbVL1TYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 14:24:01 -0500
X-IronPort-AV: i="3.99,304,1131350400"; 
   d="scan'208"; a="384711189:sNHT59663224"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, akpm@osdl.org,
       hch@infradead.org
Subject: Re: [PATCH 1 of 3] Introduce __memcpy_toio32
X-Message-Flag: Warning: May contain useful information
References: <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com>
	<adazmmmc9hl.fsf@cisco.com>
	<1135780804.1527.82.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 28 Dec 2005 11:23:56 -0800
In-Reply-To: <1135780804.1527.82.camel@serpentine.pathscale.com> (Bryan
 O'Sullivan's message of "Wed, 28 Dec 2005 06:40:03 -0800")
Message-ID: <adavex9auur.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 28 Dec 2005 19:23:58.0153 (UTC) FILETIME=[400AB390:01C60BE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > You're adding this symbol and exporting it even if the arch will
 > > supply its own version.  So this is pure kernel .text bloat...

 > I don't know what you'd prefer, so let me enumerate a few alternatives,
 > and you can either tell me which you'd prefer, or point out something
 > I've missed that would be even better.  I'm entirely flexible on this.
 > 
 >       * Use the __HAVE_ARCH_* mechanism that include/asm-*/string.h
 >         uses.  Caveat: Linus has lately come out as hating this style.
 >         It makes for the smallest patch, though.
 >       * Define the generic code in lib/, and have each arch that really
 >         uses it export it.
 >       * Put generic code in include/asm-generic/algo-memcpy_toio32.h,
 >         and have each arch that needs it #include it somewhere and use
 >         it.

The middle alternative seems the cleanest, although I'm not sure where
the export really belongs.

I don't think I could really say the right way to do this without
thinking some more -- but I am positive that exporting a function that
will never ever be called is something we should work hard to avoid.

 - R.
