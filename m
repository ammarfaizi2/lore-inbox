Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWCHTfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWCHTfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWCHTfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:35:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:10376 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932159AbWCHTft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:35:49 -0500
X-Authenticated: #30760622
Subject: dynsched bug
From: Gunter Fritz <gunter_fritz@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 08 Mar 2006 21:14:19 +0100
Message-Id: <1141848859.4446.12.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey

there is a bug in the dynsched patch.
(http://sourceforge.net/projects/dynsched) the recalculation of the nice
prio must be done before the new scheduler activate the running tasks. 
if you had download it, change scheduler_switch in sched.c like
following:

//add the running processes to the new rq
for_each_process(p){
        nice = sched_drvp->prio_to_nice(p);
        p->static_prio = data->new_scheduler->nice_to_prio(nice);
        p->prio = p->static_prio;
        if(p->state == TASK_RUNNING){
               data->new_scheduler->activate_task(p,rq, 1);
               count_rq_processes++;
        }
}



