Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266177AbTGDUvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 16:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266180AbTGDUvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 16:51:55 -0400
Received: from holomorphy.com ([66.224.33.161]:61569 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266177AbTGDUvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 16:51:47 -0400
Date: Fri, 4 Jul 2003 14:07:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: anton@samba.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030704210737.GI955@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, anton@samba.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703023714.55d13934.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 02:37:14AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.74/2.5.74-mm1/

anton saw the OOM killer try to kill pdflush, causing tons of spurious
wakeups. This should avoid picking kernel threads in select_bad_process().


-- wli


===== mm/oom_kill.c 1.23 vs edited =====
--- 1.23/mm/oom_kill.c	Wed Apr 23 03:15:53 2003
+++ edited/mm/oom_kill.c	Fri Jul  4 14:03:32 2003
@@ -123,7 +123,7 @@
 	struct task_struct *chosen = NULL;
 
 	do_each_thread(g, p)
-		if (p->pid) {
+		if (p->pid && p->mm) {
 			int points = badness(p);
 			if (points > maxpoints) {
 				chosen = p;
