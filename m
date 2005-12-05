Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVLEL7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVLEL7V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 06:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVLEL7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 06:59:20 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:37461 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932293AbVLEL7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 06:59:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=AGn5rU2gCemopqsSnsYtZyjm6UqGumV02lyn4llWhTVhLnLpfNckFm7RdQ8MVu62vG2coqQgouxfWqfgxTxpLp1MpEUWvUIE8NRtmtvUL8OZxA7YBezAtXF+lT0PkRFB/nbIMmLEfTULlaTRXL4MAltQS0Zctr1EdFLM2esqTeU=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051205115901.3480.60596.sendpatchset@didi.local0.net>
Subject: [patch 0/4] mm: optimisations
Date: Mon, 5 Dec 2005 06:59:20 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset (against 2.6.15-rc5ish) uses the new atomic ops to
do away with the offset page refcounting, and simplify the race that it
was designed to cover.

This allows some nice optimisations, and we end up saving 2 atomic ops
including a spin_lock_irqsave in the !PageLRU case, and 2 or 3 atomic ops
in the PageLRU case in the page-release path.

It also happens to be a requirement for my lockless pagecache work, but
they stand on their own as good patches.

Nick

-- 
SUSE Labs, Novell Inc.


Send instant messages to your online friends http://au.messenger.yahoo.com 
