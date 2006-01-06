Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWAFAMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWAFAMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWAFAMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:12:48 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:29577 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932308AbWAFAMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:12:47 -0500
Subject: Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jay Lan <jlan@engr.sgi.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, elsa-devel@lists.sourceforge.net,
       lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>,
       John Hesterberg <jh@sgi.com>
In-Reply-To: <20060105151016.732612fd.akpm@osdl.org>
References: <43BB05D8.6070101@watson.ibm.com>
	 <43BB09D4.2060209@watson.ibm.com> <43BC1C43.9020101@engr.sgi.com>
	 <1136414431.22868.115.camel@stark> <20060104151730.77df5bf6.akpm@osdl.org>
	 <1136486566.22868.127.camel@stark> <1136488842.22868.142.camel@stark>
	 <20060105151016.732612fd.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 16:06:13 -0800
Message-Id: <1136505973.22868.192.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 15:10 -0800, Andrew Morton wrote:
> Matt Helsley <matthltc@us.ibm.com> wrote:
> >
> >  	This patch moves both the process exit event and per-process stats
> >  connectors above exit_mm() since the latter needs values from the
> >  mm_struct which will be lost after exit_mm().
> > 
> >  Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> > 
> >  --
> > 
> >  Index: linux-2.6.15/kernel/exit.c
> >  ===================================================================
> >  --- linux-2.6.15.orig/kernel/exit.c
> >  +++ linux-2.6.15/kernel/exit.c
> >  @@ -845,10 +845,14 @@ fastcall NORET_TYPE void do_exit(long co
> >   	if (group_dead) {
> >    		del_timer_sync(&tsk->signal->real_timer);
> >   		exit_itimers(tsk->signal);
> >   		acct_process(code);
> >   	}
> >  +
> >  +	tsk->exit_code = code;
> >  +	proc_exit_connector(tsk);
> >  +	cnstats_exit_connector(tsk);
> 
> cnstats_exit_connector() doesn't exist yet...

	Right. I forgot to repeat what I mentioned in the parent email -- that
this patch is intended to be applied on top of Shailabh's patches.

	The first patch I posted (01/01) is intended for plain 2.6.15. Before
proposing 01/01 for -mm I've been trying to see if there are any
problems with the value of tsk->exit_signal before exit_mm() -- hence
the "[RFC]" in the subject line of that one.

Thanks,
	-Matt Helsley

