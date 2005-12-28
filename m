Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVL1Sds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVL1Sds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 13:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVL1Sds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 13:33:48 -0500
Received: from ns1.siteground.net ([207.218.208.2]:30338 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964866AbVL1Sds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 13:33:48 -0500
Date: Wed, 28 Dec 2005 10:33:45 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threadedprocess at getrusage()
Message-ID: <20051228183345.GA3755@localhost.localdomain>
References: <43AD8AF6.387B357A@tv-sign.ru> <Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com> <43B2874F.F41A9299@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B2874F.F41A9299@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 03:38:39PM +0300, Oleg Nesterov wrote:
> Christoph Lameter wrote:
> > 
> > On Sat, 24 Dec 2005, Oleg Nesterov wrote:
> > 
> > > I can't understand this. 'p' can do clone(CLONE_THREAD) immediately
> > > after 'if (!thread_group_empty(p))' check.
> > 
> > Only if p != current. As discussed later the lockless approach is
> > intened to only be used if p == current.
> 
> Unless I missed something this function (getrusage_both) is called
> from wait_noreap_copyout,

Hi Oleg,
Yes, this patch needs to be reworked.  I am on it.  I'd also missed that
p->signal was protected by the tasklist_lock.  Thanks for pointing it out.
I will put out the modified version soon.

Thanks,
Kiran
