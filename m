Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVAGTkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVAGTkn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVAGTgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:36:17 -0500
Received: from [213.146.154.40] ([213.146.154.40]:37827 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261566AbVAGTcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:32:47 -0500
Date: Fri, 7 Jan 2005 19:32:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Vladimir Saveliev <vs@namesys.com>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] per thread page reservation patch
Message-ID: <20050107193240.GA14465@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paulo Marques <pmarques@grupopie.com>,
	Vladimir Saveliev <vs@namesys.com>, linux-mm <linux-mm@kvack.org>,
	Andrew Morton <akpm@osdl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com> <1105019521.7074.79.camel@tribesman.namesys.com> <20050107144644.GA9606@infradead.org> <1105118217.3616.171.camel@tribesman.namesys.com> <41DEDF87.8080809@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DEDF87.8080809@grupopie.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 07:14:15PM +0000, Paulo Marques wrote:
> This seems like a very asymmetrical behavior. If the code explicitly 
> reserves pages, it should explicitly use them, or it will become 
> impossible to track down who is using what (not to mention that this 
> will slow down every regular user of __alloc_pages, even if it is just 
> for a quick test).
> 
> Why are there specialized functions to reserve the pages, but then they 
> are used through the standard __alloc_pages interface?

That seems to be the whole point of the patch, as that way it'll serve
all sub-allocators or kernel function called by the user.  Without this
behaviour the caller could have simply used a mempool.

