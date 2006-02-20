Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWBTPnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWBTPnU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWBTPnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:43:20 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:36561 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S964938AbWBTPnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:43:18 -0500
To: Dmitry Mishin <dim@openvz.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, rusty@rustcorp.com.au,
       devel@openvz.org
Subject: Re: [NET][IA64] Unaligned access in sk_run_filter
References: <200602201828.29098.dim@openvz.org>
From: Jes Sorensen <jes@sgi.com>
Date: 20 Feb 2006 10:43:16 -0500
In-Reply-To: <200602201828.29098.dim@openvz.org>
Message-ID: <yq0u0auqbmz.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dmitry" == Dmitry Mishin <dim@openvz.org> writes:

Dmitry> Hello, We have an issue on ia64 box. It is easy triggerable
Dmitry> 'kernel unaligned access' in sk_run_filter:

Dmitry>         ptr = load_pointer(skb, k, 4, &tmp);
Dmitry>         if (ptr != NULL) {
Dmitry>                  A = ntohl(*(u32 *)ptr); << here

Change the above line to something like this:

                        A = ntohl(get_unaligned((u32*)ptr));

And add an #include <asm/unaligned.h>

Cheers,
Jes
