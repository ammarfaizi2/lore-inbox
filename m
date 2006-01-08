Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWAHFXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWAHFXI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 00:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWAHFXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 00:23:08 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:38004 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751121AbWAHFXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 00:23:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=n63nKGpnlyk01w76cJhxypYwXiXu/AEP4CYm+H5wud2btQxwtJjQCEZYojDh2cgQquyarGIdgPeSvWNIROp8N3bhonwjkyt9NBQHchpZrlIDAg3XvmA0P+HhC0oSrhywiN139fd+OihiaiGPRH8DNur1gUCzssliTVXlc9U3ajw=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20060108052307.2996.39444.sendpatchset@didi.local0.net>
Subject: [patch 0/4] mm: de-skew page_count
Date: Sun, 8 Jan 2006 00:23:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset (against 2.6.15-rc5ish) uses the new atomic ops to
do away with the offset page refcounting, and simplify the race that it
was designed to cover.

This allows some nice optimisations, and we end up saving 2 atomic ops
including a spin_lock_irqsave in the !PageLRU case, and 1 or 2 atomic ops
in the PageLRU case in the page-release path.

It also happens to be a requirement for my lockless pagecache work, but
stands on its own as good patches.

Nick

-- 
SUSE Labs, Novell Inc.


Send instant messages to your online friends http://au.messenger.yahoo.com 
