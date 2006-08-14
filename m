Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751946AbWHNIdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbWHNIdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 04:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbWHNIdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 04:33:13 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:57306 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751882AbWHNIdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 04:33:12 -0400
Date: Mon, 14 Aug 2006 12:25:55 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@osdl.org>, Daniel Phillips <phillips@google.com>,
       David Miller <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
Message-ID: <20060814082555.GA27999@2ka.mipt.ru>
References: <20060813.165540.56347790.davem@davemloft.net> <44DFD262.5060106@google.com> <20060813185309.928472f9.akpm@osdl.org> <1155530453.5696.98.camel@twins> <20060813215853.0ed0e973.akpm@osdl.org> <1155531835.5696.103.camel@twins> <20060813222208.7e8583ac.akpm@osdl.org> <1155537940.5696.117.camel@twins> <20060814000736.80e652bb.akpm@osdl.org> <1155543352.5696.137.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1155543352.5696.137.camel@twins>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 14 Aug 2006 12:26:04 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 10:15:52AM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > If this refers to the socket buffers, they're mostly allocated with
> > at least __GFP_WAIT, aren't they?
> 
> Wherever it is that packets go if the local end is tied up and cannot
> accept them instantly. The simple but prob wrong calculation I made for
> evgeniy is: suppose we have 64k sockets, each socket can buffer up to
> 128 packets, and each packet can be up to 16k (roundup for jumboframes)
> large, that makes for 128G of memory. This calculation is wrong on
> several points (we can have >64k sockets, and I have no idea on the 128)
> but the order of things doesn't get better.

TCP memory is limited for all sockets - it is tcp_*mem parameters.
tcp_mem max on my amd64 with 1gb of ram is 768 kb for _all_ sockets.

-- 
	Evgeniy Polyakov
