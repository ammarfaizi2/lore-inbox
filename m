Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVD0O0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVD0O0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVD0OYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:24:44 -0400
Received: from ns2.suse.de ([195.135.220.15]:27350 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261635AbVD0OXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:23:53 -0400
Date: Wed, 27 Apr 2005 16:23:44 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Chris Wright <chrisw@osdl.org>, Andi Kleen <ak@suse.de>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: New debugging patch was Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050427142343.GN13305@wotan.suse.de>
References: <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com> <20050414170117.GD22573@wotan.suse.de> <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com> <20050414181015.GH22573@wotan.suse.de> <20050414181133.GA18221@wotan.suse.de> <20050414182712.GG493@shell0.pdx.osdl.net> <20050415172408.GB8511@wotan.suse.de> <20050415172816.GU493@shell0.pdx.osdl.net> <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com> <20050415180703.GA26289@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050415180703.GA26289@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could someone who reproduces this problem apply the following
patch and see if the WARN_ON triggers?


diff -u linux-2.6.11/mm/memory.c-o linux-2.6.11/mm/memory.c
--- linux-2.6.11/mm/memory.c-o	2005-03-02 08:38:08.000000000 +0100
+++ linux-2.6.11/mm/memory.c	2005-04-27 15:48:19.777104735 +0200
@@ -94,6 +94,7 @@
 	if (pmd_none(*pmd))
 		return;
 	if (unlikely(pmd_bad(*pmd))) {
+		printk("%s:%d: ", current->comm, current->pid);
 		pmd_ERROR(*pmd);
 		pmd_clear(pmd);
 		return;
@@ -113,6 +114,7 @@
 	unsigned long addr = start, next;
 	pmd_t *pmd, *__pmd;
 
+	WARN_ON(start == end);
 	if (pud_none(*pud))
 		return;
 	if (unlikely(pud_bad(*pud))) {
