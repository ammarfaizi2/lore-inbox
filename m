Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVFOFEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVFOFEv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 01:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVFOFEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 01:04:51 -0400
Received: from [210.76.114.20] ([210.76.114.20]:6028 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S261490AbVFOFEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 01:04:49 -0400
Subject: one question about LRU mechanism
From: "liyu@WAN" <liyu@ccoss.com.cn>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 15 Jun 2005 13:12:56 +0800
Message-Id: <1118812376.32766.4.camel@liyu.ccoss.com.cn>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-CoCreate.36) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody:

	I am a linux kernel newbie. 

	I am reading memory managment code of kernel 2.6.11.11.
I found LRU is implement as linked-stack in linux, include two important
data structure linked-list :
zone->active_list and zone->inactive_list. when kernel need reclaim some
pages, it will call function refiil_inactive_list() ultimately to move
some page from active_list to inactive_list.

	It's OK, but I have one question in my mind:
I found all function that append page to active_list, it just append
page to head of active_list (use inline function list_add() ), but
refill_inactive_list() also start scanning from head of active_list, I
think the better way scan active_list is start from rear of active_list
and scan though prev member of list_head at reclaim pages. Scanning
start from head of active_list may make thrashing more possibly, I
think. and, in my view, "head of active_list" is zone->active_list,
"rear of active_list" is zone->active_list.prev .

	May be, I am failed understand mm? or what's wrong?

	Thanks in advanced.

	Alas, my english so bad.

						liyu

