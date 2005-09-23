Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVIWKFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVIWKFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 06:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbVIWKFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 06:05:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20098 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750872AbVIWKFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 06:05:49 -0400
Date: Fri, 23 Sep 2005 11:05:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: wensong@linux-vs.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ja@ssi.bg
Subject: Re: [PATCH] reduce sizeof(struct file)
Message-ID: <20050923100541.GA18447@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Eric Dumazet <dada1@cosmosbay.com>, wensong@linux-vs.org,
	linux-kernel@vger.kernel.org, akpm@osdl.org, ja@ssi.bg
References: <17AB476A04B7C842887E0EB1F268111E026FC5@xpserver.intra.lexbox.org> <4333CF4C.2000306@anagramm.de> <4333D2AA.6020009@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4333D2AA.6020009@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 12:02:18PM +0200, Eric Dumazet wrote:
> Hi all
> 
> Now that RCU applied on 'struct file' seems stable, we can place f_rcuhead 
> in a memory location that is not anymore used at call_rcu(&f->f_rcuhead, 
> file_free_rcu) time, to reduce the size of this critical kernel object.
> 
> The trick I used is to move f_rcuhead and f_list in an union and defining 
> macros to access f_list and f_rcuhead
> 
> Unfortunatly f_list was also used in IPVS so I had to change 
> include/net/ip_vs.h and net/ipv4/ipvs/ip_vs_ctl.c, changing their f_list to 
> ipvs_f_list to avoid name clash.
> 
> (This is why I send this mail to IPVS maintainers)

Please just change all callers to use the union, there's not very many
of them.

