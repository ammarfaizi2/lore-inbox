Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030520AbVLWMwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbVLWMwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 07:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbVLWMwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 07:52:00 -0500
Received: from pat.uio.no ([129.240.130.16]:58349 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030520AbVLWMv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 07:51:59 -0500
Subject: Re: [PATCH] sched:
	Fix	adverse	effects	of	NFS	client	on	interactive response
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43ABD639.2060200@bigpond.net.au>
References: <43A8EF87.1080108@bigpond.net.au>
	 <1135145341.7910.17.camel@lade.trondhjem.org>
	 <43A8F714.4020406@bigpond.net.au>
	 <1135171280.7958.16.camel@lade.trondhjem.org>
	 <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com>
	 <1135172453.7958.26.camel@lade.trondhjem.org>
	 <43AA0EEA.8070205@bigpond.net.au>
	 <1135289282.9769.2.camel@lade.trondhjem.org>
	 <43AB29B8.7050204@bigpond.net.au>
	 <1135292364.9769.58.camel@lade.trondhjem.org>
	 <AAF94E06-ACB9-4ABE-AC15-49C6B3BE21A0@mac.com>
	 <1135297525.3685.57.camel@lade.trondhjem.org>
	 <43AB69B8.4080707@bigpond.net.au>
	 <1135330757.8167.44.camel@lade.trondhjem.org>
	 <43ABD639.2060200@bigpond.net.au>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 13:51:02 +0100
Message-Id: <1135342262.8167.143.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.282, required 12,
	autolearn=disabled, AWL 1.67, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 21:49 +1100, Peter Williams wrote:
> No.  It is asking whether the NORMAL interruption of this interruptible 
> sleep will be caused by a human user action such as a keystroke or mouse 
> action.  For the NFS client the answer to that question is unequivically 
> no.  It's not a matter of policy it's a matter of fact.

        /*
         * Tasks that have marked their sleep as noninteractive get
         * woken up without updating their sleep average. (i.e. their
         * sleep is handled in a priority-neutral manner, no priority
         * boost and no penalty.)
         */

This appears to be the only documentation for the TASK_NONINTERACTIVE
flag, and I see no mention of human user actions in that comment. The
comment rather appears to states that this particular flag is designed
to switch between two different scheduling policies.

If the flag really is only about identifying sleeps that will involve
human user actions, then surely it would be easy to set up a short set
of guidelines in Documentation, say, that spell out exactly what the
purpose is, and when it should be used.
That should be done _before_ one starts charging round converting every
instance of TASK_INTERRUPTIBLE.

  Trond

