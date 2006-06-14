Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWFNATz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWFNATz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWFNATz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:19:55 -0400
Received: from relay01.pair.com ([209.68.5.15]:46600 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S932371AbWFNATy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:19:54 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH 01/11] Task watchers:  Task Watchers
Date: Tue, 13 Jun 2006 19:19:30 -0500
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Christoph Hellwig <hch@lst.de>
References: <20060613235122.130021000@localhost.localdomain> <1150242810.21787.140.camel@stark>
In-Reply-To: <1150242810.21787.140.camel@stark>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606131919.52364.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 18:53, Matt Helsley wrote:

> @@ -847,12 +848,15 @@ static void exit_notify(struct task_stru
>  fastcall NORET_TYPE void do_exit(long code)
>  {
>  	struct task_struct *tsk = current;
>  	struct taskstats *tidstats, *tgidstats;
>  	int group_dead;
> +	int notify_result;
>
>  	profile_task_exit(tsk);
> +	tsk->exit_code = code;
> +	notify_result = notify_watchers(WATCH_TASK_EXIT, tsk);

Are you using this specific return value?

> +int notify_watchers(unsigned long val, void *v)
> +{
> +	return atomic_notifier_call_chain(&task_watchers, val, v);
> +}

Might this be called notify_task_watchers()?

Thanks,
Chase
