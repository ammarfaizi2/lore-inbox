Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291551AbSBHLia>; Fri, 8 Feb 2002 06:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291553AbSBHLiU>; Fri, 8 Feb 2002 06:38:20 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:36876 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291551AbSBHLiH>;
	Fri, 8 Feb 2002 06:38:07 -0500
Date: Fri, 8 Feb 2002 09:37:43 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
In-Reply-To: <3C639060.A68A42CA@zip.com.au>
Message-ID: <Pine.LNX.4.33L.0202080935190.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Andrew Morton wrote:

> + *   This all assumes that the rate of taking requests is much, much higher
> + *   than the rate of releasing them.  Which is very true.

This is not necessarily true for read requests.

If each read request is synchronous and the process will
generate the next read request after the current one
has finished, then it's quite possible to clog up the
queue with read requests which are generated at exactly
the same rate as they're processed.

Couldn't this still cause starvation, even with your patch?

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

