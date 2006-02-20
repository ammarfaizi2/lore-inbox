Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWBTOqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWBTOqS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBTOqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:46:18 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:40146 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932501AbWBTOqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:46:17 -0500
Message-ID: <43F9E83C.34226D70@tv-sign.ru>
Date: Mon, 20 Feb 2006 19:03:08 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Roland McGrath <roland@redhat.com>
Subject: [PATCH 0/4] prepare for ->siglock safe threads traversal
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The main problem is that copy_process's error path and
release_task() share __exit_signal() which locks ->sighand
and destroys it, but we need to do __unhash_process() under
->sighand.

This patch series tries to solves this. It also tries to
simplify and cleanup the code a bit.

Oleg.
