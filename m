Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVERAqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVERAqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 20:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVERAqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 20:46:10 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:6353 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262000AbVERAqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 20:46:04 -0400
Date: Tue, 17 May 2005 18:03:37 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, shai@scalex86.org
Subject: Re: [PATCH] Optimize sys_times for a single thread process
Message-ID: <20050518010337.GB44089@gaz.sfgoth.com>
References: <Pine.LNX.4.62.0505171536080.15653@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505171536080.15653@graphe.net>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Tue, 17 May 2005 18:03:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> +		if (current == next_thread(current)) {
> +			/*
> +			 * Single thread case. We do not need to scan the tasklist
> +			 * and thus can avoid the read_lock(&task_list_lock). We
> +			 * also do not need to take the siglock since we
> +			 * are the only thread in this process
> +			 */
> +			utime = cputime_add(current->signal->utime, current->utime);
> +			stime = cputime_add(current->signal->utime, current->stime);
> +			cutime = current->signal->cutime;
> +			cstime = current->signal->cstime;
> +		} else

Maybe #ifdef CONFIG_SMP around this?  On uniproc you're still saving the
sti/cli around reading the tsk->signal stuff but that's probably not
enough to warrant the code bloat.

Or maybe this is a small enough amount of code not to matter... just a
suggestion.

-Mitch
