Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWGENmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWGENmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 09:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWGENmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 09:42:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49880 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964843AbWGENmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 09:42:12 -0400
Subject: Re: possible recursive locking in ATM layer
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@argo.co.il>
Cc: Duncan Sands <duncan.sands@math.u-psud.fr>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       chas@cmf.nrl.navy.mil
In-Reply-To: <44ABBF97.3070709@argo.co.il>
References: <1152029582.3109.70.camel@laptopd505.fenrus.org>
	 <44ABBF97.3070709@argo.co.il>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 15:42:08 +0200
Message-Id: <1152106928.3201.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 16:33 +0300, Avi Kivity wrote:
> Arjan van de Ven wrote:
> >
> > From: Arjan van de Ven <arjan@linux.intel.com>
> >
> > > Linux version 2.6.17-git22 (duncan@baldrick) (gcc version 4.0.3 
> > (Ubuntu 4.0.3-1ubuntu5)) #20 PREEMPT Tue Jul 4 10:35:04 CEST 2006
> >
> > >
> > > [ 2381.598609] =============================================
> > > [ 2381.619314] [ INFO: possible recursive locking detected ]
> > > [ 2381.635497] ---------------------------------------------
> > > [ 2381.651706] atmarpd/2696 is trying to acquire lock:
> > > [ 2381.666354]  (&skb_queue_lock_key){-+..}, at: [<c028c540>] 
> > skb_migrate+0x24/0x6c
> > > [ 2381.688848]
> >
> >
> > ok this is a real potential deadlock in a way, it takes two locks of 2
> > skbuffs without doing any kind of lock ordering; I think the following
> > patch should fix it. Just sort the lock taking order by address of the
> > skb.. it's not pretty but it's the best this can do in a minimally
> > invasive way.
> >
> 
> Isn't it a deadlock only if skb_migrate(a, b) and skb_migrate(b, a) can 
> be called concurrently?

yes, well, and if there are no  other double-takers...
> 

