Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267444AbUHPFl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267444AbUHPFl2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 01:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267445AbUHPFl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 01:41:28 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:32956 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267444AbUHPFlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 01:41:21 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816043302.GA14979@elte.hu>
References: <1092622121.867.109.camel@krustophenia.net>
	 <20040816023655.GA8746@elte.hu> <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092630122.810.25.camel@krustophenia.net>
	 <20040816043302.GA14979@elte.hu>
Content-Type: text/plain
Message-Id: <1092634931.793.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 01:42:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 00:33, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > > Anyway, the change to sched.c fixes the mlockall bug, it works
> > > > perfectly now.  Thanks!
> > > 
> > > great! This fix also means that we've got one more lock-break in the
> > > ext3 journalling code and one more lock-break in dcache.c. I've released
> > > -P1 with the fix included:
> > > 
> > >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P1
> > > 
> > 
> > The highest latency I am seeing now is the rhine_check_duplex problem. 
> > Should I try making mdio_delay an NOOP?
> 
> there's no mdio_delay() in via-rhine.c AFAICS. Could you add a pair of
> touch-latency calls to around this code in mdio_read():
> 

Adding this code causes the rhine-related latency reports to go away. 
Should I try removing the second pair, to verify it's the first chunk
that's responsible?

With this, and the extract_entropy hack, the biggest common latency I am
now seeing (the copy_page_one is bigger but rarer) is the XFree86
unmap_vmas issue.  This one actually occurs so often that I can't tell
what #2 is.

Lee

