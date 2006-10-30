Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWJ3Ulg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWJ3Ulg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWJ3Ulg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:41:36 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:33173 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S932467AbWJ3Ulg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:41:36 -0500
Date: Mon, 30 Oct 2006 23:41:25 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xacct_add_tsk: fix pure theoretical ->mm use-after-free
Message-ID: <20061030204125.GB677@oleg>
References: <20061029185826.GA1619@oleg> <454649CE.80804@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454649CE.80804@engr.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30, Jay Lan wrote:
>
> Oleg Nesterov wrote:
> > Paranoid fix. The task can free its ->mm after the 'if (p->mm)' check.
> 
> Why this change is necessary? This routine is indirectly invoked by
> taskstats_exit_send() routine called inside do_exit():

Not only, please note

	taskstats_user_cmd(TASKSTATS_CMD_ATTR_PID)->fill_pid()->xacct_add_tsk()

path. This tsk is not 'current', it was found by find_task_by_pid(), and
it may exit at any time.

Oleg.

