Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751813AbWJaCuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWJaCuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 21:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWJaCuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 21:50:09 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:65251 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751813AbWJaCuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 21:50:07 -0500
Message-ID: <4546B9BC.6020109@in.ibm.com>
Date: Tue, 31 Oct 2006 08:19:32 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] taskstats_tgid_free: fix usage
References: <20061026232128.GA526@oleg>
In-Reply-To: <20061026232128.GA526@oleg>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> taskstats_tgid_free() is called on copy_process's error path. This is wrong.
> 
> 	IF (clone_flags & CLONE_THREAD)
> 		We should not clear ->signal->taskstats, current uses it,
> 		it probably has a valid accumulated info.
> 	ELSE
> 		taskstats_tgid_init() set ->signal->taskstats = NULL,
> 		there is nothing to free.
> 
> Move the callsite to __exit_signal(). We don't need any locking, entire
> thread group is exiting, nobody should have a reference to soon to be
> released ->signal.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Looks good!
Acked-by: Balbir Singh <balbir@in.ibm.com>

---

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
