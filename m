Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUGIG20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUGIG20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 02:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbUGIG2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 02:28:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:45215 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264401AbUGIG2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 02:28:24 -0400
Date: Fri, 9 Jul 2004 08:29:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
Message-ID: <20040709062910.GA2201@elte.hu>
References: <20040705023120.34f7772b.akpm@osdl.org> <20040706125438.GS21066@holomorphy.com> <20040706233618.GW21066@holomorphy.com> <20040706170247.5bca760c.davem@redhat.com> <20040707073510.GA27609@elte.hu> <20040707140249.2bfe0a4b.davem@redhat.com> <40EE06B1.1090202@yahoo.com.au> <20040709025151.GV21066@holomorphy.com> <40EE288F.20301@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EE288F.20301@yahoo.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >Please present a self-contained fixed-up init_idle() cleanup for me to
> >testboot. Even the one in -mm is not so, as it depends on later patches
> >to even compile.
> 
> The patch I just sent (which is on top of -mm6) should hopefully
> work... if you feel like testing a solution that may still get
> vetoed by Ingo.

looks fine to me. It somewhat reduces the utility of copy_process()
[which we primarily introduced to enable wakeup-less SMP bootstrapping],
but i cannot see any good solution besides moving copy_thread() out of
copy_process(), which is unsafe. (ptrace could potentially access the
new task before copy_thread() is done, etc.) So i'd go for the simple
solution of CLONE_IDLETASK not doing a wakeup.

	Ingo
