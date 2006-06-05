Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750850AbWFEJN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWFEJN1 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 05:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWFEJN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 05:13:27 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:19159 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750827AbWFEJN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 05:13:26 -0400
Date: Mon, 5 Jun 2006 11:12:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@ono.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
Message-ID: <20060605091251.GA1145@elte.hu>
References: <20060603232004.68c4e1e3.akpm@osdl.org> <20060605012842.3d58095f@werewolf.auna.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060605012842.3d58095f@werewolf.auna.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.5 required=5.9 tests=AWL,BAYES_60 autolearn=no SpamAssassin version=3.0.3
	1.0 BAYES_60               BODY: Bayesian spam probability is 60 to 80%
	[score: 0.6440]
	-0.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* J.A. Magallón <jamagallon@ono.com> wrote:

> I got this with -mm2, is it supposed to be cured in -mm3 ? I still 
> have to try with mm3:

> (all tests failed like this...)
> 
> Jun  2 14:34:39 annwn kernel: --------------------------------------------------------
> Jun  2 14:34:39 annwn kernel: 141 out of 206 testcases failed, as expected. |
> Jun  2 14:34:39 annwn kernel: ----------------------------------------------------
> 
> Expected ? Uh ?

to have lock validation you should have these options enabled:

 CONFIG_PROVE_SPIN_LOCKING=y
 CONFIG_PROVE_RW_LOCKING=y
 CONFIG_PROVE_MUTEX_LOCKING=y
 CONFIG_PROVE_RWSEM_LOCKING=y

otherwise the tests are still run, but the deadlocks are not detected. 
That's why those 141 testcases are 'expected' failures.

and definitely try -mm3 plus the current combo patch:

  http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm3.patch

	Ingo
