Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272206AbRHWDnB>; Wed, 22 Aug 2001 23:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272207AbRHWDmv>; Wed, 22 Aug 2001 23:42:51 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:11280 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272206AbRHWDmm>; Wed, 22 Aug 2001 23:42:42 -0400
Date: Thu, 23 Aug 2001 00:42:45 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Andi Kleen <ak@suse.de>
Cc: "Jens Hoffrichter" <HOFFRICH@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Allocation of sk_buffs in the kernel
Message-ID: <20010823004245.O5062@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Andi Kleen <ak@suse.de>, "Jens Hoffrichter" <HOFFRICH@de.ibm.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <OF55D2E221.5E62CB41-ONC1256AB0.0052D2D3@de.ibm.com.suse.lists.linux.kernel> <oupd75no4b3.fsf@pigdrop.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <oupd75no4b3.fsf@pigdrop.muc.suse.de>; from ak@suse.de on Thu, Aug 23, 2001 at 05:14:56AM +0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 23, 2001 at 05:14:56AM +0200, Andi Kleen escreveu:
> [1] There may be a few unnormal ones that do; e.g. vendor driver
> writers seem to frequently try to reuse skbuffs privately because they're
> used to that from other OS. It is discouraged and somewhat tricky, but
> possible.

The original 802.2 stack from procom, used frame_t all over the core stack,
with only the entry/exit points manipulating skb's. On entry from the core
networking stack and from upper protocols (NetBEUI in procom case) they
allocated a frame_t from a pool and initialited pointers to the mac and llc
headers and stored the skb type in another frame_t member, pointing to the
skb memory and used those pointers instead of skb->h and skb->nh.  That
way, I think, they could use the core for several OSes.

Maybe Jens should use something like WAITQUEUE_DEBUG if he want to know
where alloc_skb and friends were called, see include/linux/wait.h 8)

- Arnaldo

