Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTEOPRf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTEOPRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:17:35 -0400
Received: from 136.231.118.64.mia-ftl.netrox.net ([64.118.231.136]:427 "EHLO
	smtp.netrox.net") by vger.kernel.org with ESMTP id S264088AbTEOPRb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:17:31 -0400
Subject: Re: 2.6 must-fix list, v2
From: Robert Love <rml@tech9.net>
To: "Shaheed R. Haque" <srhaque@iee.org>
Cc: Felipe Alfaro Solana <yo@felipe-alfaro.com>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1052990397.3ec35bbd5e008@netmail.pipex.net>
References: <1050146434.3e97f68300fff@netmail.pipex.net>
	 <1052910149.586.3.camel@teapot.felipe-alfaro.com>
	 <1052927975.883.9.camel@icbm>  <200305142201.59912.srhaque@iee.org>
	 <1052946917.883.25.camel@icbm> <1052990397.3ec35bbd5e008@netmail.pipex.net>
Content-Type: text/plain
Message-Id: <1053012743.899.5.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (1.3.3-2) (Preview Release)
Date: 15 May 2003 11:32:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 05:19, Shaheed R. Haque wrote:

> These are the distros I am interested in too. I knew it was in RH AS/ES, but 
> are you saying it is in RH9.0? That would be good news.

No, I am saying with luck it will be in the next RH release.

> On the technical point, I tried out taskset in rc.sysinit, and as you said, it 
> works just fine.

Good :)

> On reflection, I feel that editing rc.sysinit is not the right 
> answer given the confidence/competence level of our customers' typical 
> sysadmins: but I can see that a carefully crafted rc5.d/S00aaaaa script could 
> set the affinity of the executing shell, and its parent(s) upto init to fix all 
> subsequent rcN.d children in the desired manner.
> 
> I do suspect that other commercial users will also baulk at editing rc.sysint, 
> and so have to brew the same rcN.d solution. Now, the rcN.d script hackery 
> would be greatly simplified if taskset had a mode of "set the affinity of the 
> identified process, and all its parent processes upto init". Would you accept a 
> patch to taskset along those lines?

It is racey to do this, so its something that should remain a hack and
not part of taskset, I think.

If you do it in rc.d, you don't need to set all the parents. rc.d is the
first thing run, so if you do it at the top of the script, nothing else
is running. Just put:

	taskset <mask> 1
	taskset <mask> $$

at the top of rc.d.

Another consideration is modifying init (and hopefully having said
changes merged back). Init could call sched_setaffinity() when it is
first created, based on a setting in /etc/inittab or a command line
parameter passed during boot.

My reservation is against doing it in the kernel. I do not particularly
care _how_ its done in user-space.

	Robert Love

