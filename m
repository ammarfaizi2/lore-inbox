Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVFAVea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVFAVea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVFAUof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:44:35 -0400
Received: from pat.uio.no ([129.240.130.16]:7366 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261191AbVFAUVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:21:14 -0400
Subject: Re: RT and Cascade interrupts
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: john cooper <john.cooper@timesys.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>
In-Reply-To: <429E0A86.7000507@timesys.com>
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>
	 <42983135.C521F1C8@tv-sign.ru> <4298AED8.8000408@timesys.com>
	 <1117312557.10746.6.camel@lade.trondhjem.org>
	 <4299332F.6090900@timesys.com>
	 <1117352410.10788.29.camel@lade.trondhjem.org>
	 <429B8678.1000706@timesys.com> <429DC4A8.BFF69FB3@tv-sign.ru>
	 <429DF8DE.7060008@timesys.com>
	 <1117650718.10733.65.camel@lade.trondhjem.org>
	 <429E0A86.7000507@timesys.com>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 16:21:07 -0400
Message-Id: <1117657267.10733.106.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.636, required 12,
	autolearn=disabled, AWL 1.36, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 01.06.2005 Klokka 15:20 (-0400) skreiv john cooper:
> You might have missed in my earlier mail as
> this is a not an MP kernel ie: !CONFIG_SMP
> The synchronous timer delete primitives don't
> exist in this configuration:

This probably explains your trouble. It makes no sense to allow
__run_timer to be preemptible without having the synchronous timer
delete primitives. Synchronisation is impossible without them.

Which version of the RT patches are you using? The one I'm looking at
(2.6.12-rc5-rt-V0.7.47-15) certainly defines both del_timer_sync() and
del_singleshot_timer_sync() to be the same as the SMP versions if you
are running an RT kernel with preemptible softirqs.

Cheers,
  Trond

