Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291354AbSBGWMh>; Thu, 7 Feb 2002 17:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288153AbSBGWM2>; Thu, 7 Feb 2002 17:12:28 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:13830 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291354AbSBGWMT>;
	Thu, 7 Feb 2002 17:12:19 -0500
Date: Thu, 7 Feb 2002 20:12:13 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problem with rmap-12c
In-Reply-To: <1013114437.1619.22.camel@tiger>
Message-ID: <Pine.LNX.4.33L.0202072006010.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Feb 2002, Louis Garcia wrote:

> I tried rmap-12c and had lots of swap usage. I when back to 12a and
> everything calmed down. Is their a known problem with 12c?

Nope, but the RSS limit enforcing stuff is a possible
suspect.

It turns out I used a "struct pte_t" in over_rss_limit(),
which turned into a compiler warning, for which I didn't
spot the cause ;)

A fix for the bug was sent by Roger Larsson, who spotted
the fact that "pte_t" already has a "struct" inside it.

Maybe page aging isn't working in rmap-12c because of this
stupid mistake ... but it's a long shot.  Maybe I should
release rmap 12d tonight ? ;)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

