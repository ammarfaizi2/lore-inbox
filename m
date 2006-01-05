Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWAEXKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWAEXKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWAEXKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:10:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2268 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932260AbWAEXKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:10:41 -0500
Date: Thu, 5 Jan 2006 15:10:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: jlan@engr.sgi.com, nagar@watson.ibm.com, linux-kernel@vger.kernel.org,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       ckrm-tech@lists.sourceforge.net, pj@sgi.com, erikj@sgi.com,
       steiner@sgi.com, jh@sgi.com
Subject: Re: [PATCH 00/01] Move Exit Connectors
Message-Id: <20060105151016.732612fd.akpm@osdl.org>
In-Reply-To: <1136488842.22868.142.camel@stark>
References: <43BB05D8.6070101@watson.ibm.com>
	<43BB09D4.2060209@watson.ibm.com>
	<43BC1C43.9020101@engr.sgi.com>
	<1136414431.22868.115.camel@stark>
	<20060104151730.77df5bf6.akpm@osdl.org>
	<1136486566.22868.127.camel@stark>
	<1136488842.22868.142.camel@stark>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley <matthltc@us.ibm.com> wrote:
>
>  	This patch moves both the process exit event and per-process stats
>  connectors above exit_mm() since the latter needs values from the
>  mm_struct which will be lost after exit_mm().
> 
>  Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> 
>  --
> 
>  Index: linux-2.6.15/kernel/exit.c
>  ===================================================================
>  --- linux-2.6.15.orig/kernel/exit.c
>  +++ linux-2.6.15/kernel/exit.c
>  @@ -845,10 +845,14 @@ fastcall NORET_TYPE void do_exit(long co
>   	if (group_dead) {
>    		del_timer_sync(&tsk->signal->real_timer);
>   		exit_itimers(tsk->signal);
>   		acct_process(code);
>   	}
>  +
>  +	tsk->exit_code = code;
>  +	proc_exit_connector(tsk);
>  +	cnstats_exit_connector(tsk);

cnstats_exit_connector() doesn't exist yet...


