Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbUBTOAQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 09:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbUBTOAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 09:00:13 -0500
Received: from mx2.elte.hu ([157.181.151.9]:10450 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261237AbUBTN7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 08:59:21 -0500
Date: Fri, 20 Feb 2004 15:00:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040220140025.GA13381@elte.hu>
References: <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <20040220131932.GB8994@mail.shareable.org> <20040220133707.GA11773@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220133707.GA11773@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


for Samba, the use of sys_mark_dir_clean() & O_CLEAN would be that it
could fully cache all namespace data in user-space (as it already does),
and could assume that the userspace cache is uptodate and ensure that a
particular name does not exist - under whatever namespace rules it wants
to use.

create(O_CLEAN) will return with -EFLUSH if this assumption is not true
anymore - in which case it can re-read that directory.

this way the fastpath would not involve any readdir() calls at all -
even in a mixed environment.

	Ingo
