Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132463AbRAQFNw>; Wed, 17 Jan 2001 00:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132450AbRAQFNm>; Wed, 17 Jan 2001 00:13:42 -0500
Received: from linuxcare.com.au ([203.29.91.49]:46863 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S132402AbRAQFNe>; Wed, 17 Jan 2001 00:13:34 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Wed, 17 Jan 2001 15:43:01 +1100
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-kernel@vger.kernel.org,
        linux-mm@frodo.biederman.org
Subject: Re: Caches, page coloring, virtual indexed caches, and more
Message-ID: <20010117154301.B7525@linuxcare.com>
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu> <20010111005657.B2243@khan.acc.umu.se> <20010112035620.B1254@bacchus.dhis.org> <m17l40hhtd.fsf@frodo.biederman.org> <20010115005315.D1656@bacchus.dhis.org> <m1snmlfbrx.fsf_-_@frodo.biederman.org> <20010115095432.A14351@bacchus.dhis.org> <20010115235340.B31461@linuxcare.com> <m1itnfg7rk.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <m1itnfg7rk.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Tue, Jan 16, 2001 at 02:34:39AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 
> Where do you do this?  And how do you handle the case of aliases with kseg,
> the giant kernel mapping.

Aliases between user and kernel mappings of a page are handled by
flush_page_to_ram the old interface) or {copy,clear}_user_page,
flush_dcache_page and update_mmu_cache (new interface). Sparc64 already
uses the new interface and there are patches for ppc and ia64 to use it.

The new interface allows flushes to be avoided, leading to rather nice
performance increases.

See Documentation/cachetlb.txt for more info.

Cheers,
Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
