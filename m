Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWG0Jwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWG0Jwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 05:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWG0Jwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 05:52:55 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:44714 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932553AbWG0Jwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 05:52:54 -0400
Date: Thu, 27 Jul 2006 11:46:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       eike-kernel@sf-tec.de, linux-kernel@vger.kernel.org, aia21@cantab.net,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [BUG?] possible recursive locking detected
Message-ID: <20060727094617.GA5955@elte.hu>
References: <200607261805.26711.eike-kernel@sf-tec.de> <20060726225311.f51cee6d.akpm@osdl.org> <44C86271.9030603@yahoo.com.au> <1153984527.21849.2.camel@imp.csi.cam.ac.uk> <20060727003806.def43f26.akpm@osdl.org> <1153988398.21849.16.camel@imp.csi.cam.ac.uk> <20060727015356.f01b5644.akpm@osdl.org> <1153992484.21849.36.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153992484.21849.36.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> An example is the potential deadlock in generic buffered file write 
> where we fault in a page via fault_in_pages_readable() but there is 
> nothing to guarantee that page will not go away between us doing this 
> and us using the page.

isnt this solved by:

 commit 6527c2bdf1f833cc18e8f42bd97973d583e4aa83
 Author: Vladimir V. Saveliev <vs@namesys.com>
 Date:   Tue Jun 27 02:53:57 2006 -0700

     [PATCH] generic_file_buffered_write(): deadlock on vectored write

?

if not, do you have any description of the problem or a link to previous 
discussion[s] outlining the problem? To me it appears this is a kernel 
bug where we simply dropped the ball to fix it. I personally dont find 
it acceptable to have deadlocks in the kernel, where all that is needed 
to trigger it is "high i/o loads", no matter how hard it is to fix the 
deadlock.

	Ingo
