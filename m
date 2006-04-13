Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWDMQca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWDMQca (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWDMQca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:32:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54420 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750736AbWDMQca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:32:30 -0400
Date: Thu, 13 Apr 2006 17:32:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] pids: simplify do_each_task_pid/while_each_task_pid
Message-ID: <20060413163205.GA7492@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@infradead.org>
References: <20060413163727.GA1365@oleg> <20060413133814.GA29914@infradead.org> <20060413175431.GA108@oleg> <20060413150722.GA5217@infradead.org> <20060413202104.GA125@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413202104.GA125@oleg>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 12:21:04AM +0400, Oleg Nesterov wrote:
> #define NEW_IMPROVED_HLIST_FOR_EACH_ENTRY_RCU_WHICH_DOESNT_NEED_EXTRA_PARM(pos, head, member)	\
> 	for (pos = hlist_entry((head)->first, typeof(*(pos)), member);			\
> 		rcu_dereference(pos) != hlist_entry(NULL, typeof(*(pos)), member)	\
> 			&& ({ prefetch((pos)->member.next); 1; });			\
> 		(pos) = hlist_entry((pos)->member.next, typeof(*(pos)), member))
> 
> What do you think? What should be the name for it?

Justy kill the superflous argument from all hlist_for_each_entry variants
without a name change.
