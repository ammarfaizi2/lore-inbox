Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292617AbSBZCzE>; Mon, 25 Feb 2002 21:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292312AbSBZCyz>; Mon, 25 Feb 2002 21:54:55 -0500
Received: from holomorphy.com ([216.36.33.161]:45755 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S293486AbSBZCyr>;
	Mon, 25 Feb 2002 21:54:47 -0500
Date: Mon, 25 Feb 2002 18:54:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: riel@conectiva.com.br, marcelo@conectiva.com.br, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct page shrinkage
Message-ID: <20020226025412.GP3511@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
	marcelo@conectiva.com.br, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020225.174911.82037594.davem@redhat.com> <Pine.LNX.4.33L.0202252254380.7820-100000@imladris.surriel.com> <20020225.180122.120462472.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020225.180122.120462472.davem@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 06:01:22PM -0800, David S. Miller wrote:
> Rik, not every architecture has a "counter" member of
> atomic_t, that is the problem.  This is a hard bug, please
> fix it.  It is an opaque type, accessing its' implementation
> directly is therefore illegal in the strongest way possible.

> From: Rik van Riel <riel@conectiva.com.br>
> This exact same code has been in -rmap for a few months
> and went into 2.5 just over a week ago.  It doesn't seem
> to give any problems ...

On Mon, Feb 25, 2002 at 06:01:22PM -0800, David S. Miller wrote:
> Because I haven't pushed my sparc64 changesets yet, I'm doing
> that tonight.

I think I'm to blame for init_page_count(). My bad.

A small bit of analysis seemed to reveal that atomicity wasn't needed
in free_area_init_core(). Apparently the solution I suggested here was
non-portable. Perhaps a better way will crop up later.

Cheers,
Bill
