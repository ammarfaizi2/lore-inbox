Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWGYDOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWGYDOT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 23:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWGYDOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 23:14:19 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:35735 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932420AbWGYDOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 23:14:18 -0400
Date: Tue, 25 Jul 2006 12:16:40 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: akpm@osdl.org, pj@sgi.com, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: Re: [RFC] ps command race fix
Message-Id: <20060725121640.246a3720.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060725115004.a6c668ca.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
	<20060724184847.3ff6be7d.pj@sgi.com>
	<20060725110835.59c13576.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724193318.d57983c1.akpm@osdl.org>
	<20060725115004.a6c668ca.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006 11:50:04 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> BTW, how large pids and how many proccess in a (heavy and big) system ?
> 
I found
/*
 * A maximum of 4 million PIDs should be enough for a while.
 * [NOTE: PID/TIDs are limited to 2^29 ~= 500+ million, see futex.h.]
 */
#define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
        (sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))

...we have to manage 4 millions tids.

I'll try to make use of pidmap array which is already maintained in pid.c
and to avoid using extra memory.

Thanks,
-Kame

