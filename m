Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbTDAK62>; Tue, 1 Apr 2003 05:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262292AbTDAK62>; Tue, 1 Apr 2003 05:58:28 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:32273 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S262276AbTDAK61>; Tue, 1 Apr 2003 05:58:27 -0500
Date: Tue, 1 Apr 2003 12:11:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Xavier Bestel <xavier.bestel@free.fr>
cc: CaT <cat@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
In-Reply-To: <1049194788.22942.9.camel@bip.localdomain.fake>
Message-ID: <Pine.LNX.4.44.0304011207500.9723-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Apr 2003, Xavier Bestel wrote:
>                         size = memparse(value,&rest);
> +                       if (*rest == '%') {
> +                               struct sysinfo si;
> +                               si_meminfo(&si);
> +                               size = (si.totalram << PAGE_CACHE_SHIFT) / 100 * size;
> 
> (si.totalram << PAGE_CACHE_SHIFT) * size / 100;
> would have been better precision-wise.

Hardly, it'll overflow in even more cases
than CaT's (si.totalram << PAGE_CACHE_SHIFT).
I'll take a look at this later, not right now.

Hugh

