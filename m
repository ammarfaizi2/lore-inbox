Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSIDVkN>; Wed, 4 Sep 2002 17:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSIDVkN>; Wed, 4 Sep 2002 17:40:13 -0400
Received: from p50886EA2.dip.t-dialin.net ([80.136.110.162]:38794 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315503AbSIDVkM>; Wed, 4 Sep 2002 17:40:12 -0400
Date: Wed, 4 Sep 2002 15:44:26 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Tomas Szepe <szepe@pinerecords.com>
cc: Hans Reiser <reiser@namesys.com>, Dave Kleikamp <shaggy@austin.ibm.com>,
       "David S. Miller" <davem@redhat.com>, <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>, <aurora-sparc-devel@linuxpower.org>,
       <reiserfs-dev@namesys.com>, <linuxjfs@us.ibm.com>,
       Oleg Drokin <green@namesys.com>
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
In-Reply-To: <20020904211803.GD24323@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0209041542030.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 4 Sep 2002, Tomas Szepe wrote:
> typedef unsigned long long u64;
> 
> /* usable for char, short int, and int */
> #define set_to_max(a) \
> { \
> 	u64 max = ((u64) 2 << (sizeof(a) * 8 - 1)) - 1; \
> 	a = max; if ((u64) a != max) a = max / 2; \
> }

To make it more secure, we should consider the following version:

typedef unsigned long long u64;

/* usable for char, short int, and int */
#define set_to_max(a) { \
        u64 __val_max = ((u64) 1 << (sizeof(a) * 8)) - 1; \
        a = __val_max; \
        if ((u64) a != __val_max) \
                a = __val_max / 2; \
}

So it's basically naming.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

