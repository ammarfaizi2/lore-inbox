Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272074AbRI0IUn>; Thu, 27 Sep 2001 04:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272062AbRI0IUd>; Thu, 27 Sep 2001 04:20:33 -0400
Received: from chiara.elte.hu ([157.181.150.200]:11789 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S272020AbRI0IUV>;
	Thu, 27 Sep 2001 04:20:21 -0400
Date: Thu, 27 Sep 2001 10:18:24 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Kiril Vidimce <vkire@pixar.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: max arguments for exec 
In-Reply-To: <Pine.SGI.4.21.0109262017410.36450-100000@eclipse>
Message-ID: <Pine.LNX.4.33.0109271014250.2745-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Sep 2001, Kiril Vidimce wrote:

> Yeah, I know, but we would like to avoid building a custom kernel. If
> we do end up going this route, I wonder if there is a limit for
> MAX_ARG_PAGES. Any idea? I think 128 pages (512K) would be sufficient
> for our needs.

be careful with MAX_ARG_PAGES, because struct binprm is allocated on the
kernel stack, so if it's too big, the kernel stack will overflow in
unexpected places. A realistic limit is 1-2 MB, that causes a 1-2 KB
kernel stack footprint.

(ob'plug: or use the patch i posted, the size of struct binprm is constant
and small there :-)

	Ingo

