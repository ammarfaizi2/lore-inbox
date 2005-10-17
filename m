Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVJQShe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVJQShe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVJQShe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:37:34 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:50817 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932205AbVJQShd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:37:33 -0400
Date: Tue, 18 Oct 2005 00:01:24 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
Message-ID: <20051017183124.GF13665@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com> <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com> <4353E6F1.8030206@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4353E6F1.8030206@cosmosbay.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 08:01:21PM +0200, Eric Dumazet wrote:
> Dipankar Sarma a écrit :
> >On Mon, Oct 17, 2005 at 09:16:25AM -0700, Linus Torvalds wrote:
> >
> 
> <lazy_mode=ON>
> Do we really need a TIF_RCUUPDATE flag, or could we just ask for a resched ?
> </lazy_mode>

I think the theory was that we have to process the callbacks,
not just force the grace period by setting need_resched.
That is what TIF_RCUUPDATE indicates - rcus to process.

> This patch only take care of call_rcu(), I'm unsure of what can be done 
> inside call_rcu_bh()
> 
> The two stress program dont hit OOM anymore with this patch applied (even 
> with maxbatch=10)

Hmm.. I am supprised that maxbatch=10 still allowed you keep up
with a continuously queueing cpu. OK, I will look at this.

Thanks
Dipankar
