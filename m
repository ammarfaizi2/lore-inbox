Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWB0MSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWB0MSv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 07:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWB0MSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 07:18:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21944 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751027AbWB0MSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 07:18:50 -0500
Subject: Re: [Lse-tech] Re: [Patch 2/7] Add sysctl for schedstats
From: Arjan van de Ven <arjan@infradead.org>
To: balbir@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <20060227104634.GB22492@in.ibm.com>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141027367.5785.42.camel@elinux04.optonline.net>
	 <1141027923.5785.50.camel@elinux04.optonline.net>
	 <20060227085203.GB3241@elte.hu>  <20060227104634.GB22492@in.ibm.com>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 13:18:44 +0100
Message-Id: <1141042725.2992.96.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 16:16 +0530, Balbir Singh wrote:
> <snip>
> > why not just introduce a schedstats_lock mutex, and acquire it for both 
> > the 'if (schedstats_sysctl)' line and the schedstats_set() line. That 
> > will make the locking meaningful: two parallel sysctl ops will be atomic 
> > to each other. [right now they wont be and they can clear schedstat data 
> > in parallel -> not a big problem but it makes schedstats_lock rather 
> > meaningless]
> >
> 
> Ingo,
> 
> Can sysctl's run in parallel? sys_sysctl() is protects the call
> to do_sysctl() with BKL (lock_kernel/unlock_kernel).
> 
> Am I missing something?


your sysctl functions sleep. the BKL is useless in the light of sleeping
code...


