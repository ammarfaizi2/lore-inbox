Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbWHIICM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbWHIICM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbWHIICL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:02:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33504 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965043AbWHIICJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:02:09 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, haveblue@us.ibm.com, serue@us.ibm.com,
       clg@fr.ibm.com, lxc-devel@lists.sourceforge.net
Subject: Re: [RFC] [PATCH] pidspace: is_init()
References: <20060804224105.GA19866@us.ibm.com>
Date: Wed, 09 Aug 2006 02:01:47 -0600
In-Reply-To: <20060804224105.GA19866@us.ibm.com> (Sukadev Bhattiprolu's
	message of "Fri, 4 Aug 2006 15:41:05 -0700")
Message-ID: <m14pwm5od0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sukadev Bhattiprolu <sukadev@us.ibm.com> writes:

> This is an updated version of Eric Biederman's is_init() patch.
> (http://lkml.org/lkml/2006/2/6/280). It applies cleanly to 2.6.18-rc2
> and replaces a few more instances of ->pid == 1 with is_init().
>
> Further, is_init() checks pid and thus removes dependency on Eric's
> other patches for now.

Sorry for the delay.  I've been catching up on other things before
I dived back in.

> Couple of questions:
>
> 	Are there cases where child_reaper is not pid = 1. Should the
> 	"tsk == child_reaper" check in do_exit() be replaced with is_init() ? 

There are cases where there are multiple child_reapers.
So is_init() is not the right test there.

There is a really weird case when you have a threaded init and the primary
thread exits where things get weird.  As I recall there wind up being two
tasks with tgid == 1 and pid == 1.  So simply testing the pid is not
sufficient.

> 	Looks like, we would need a similar, is_idle() wrapper for "pid==0"
> 	checks - although the name is_idle_task() maybe more intuitive. If
> 	so, should we rename is_init() to is_init_task() ? 

Whatever works.  I'm not too particular as long as the important bits happen.
However pid == 0 only ever lives in the root pspace and never shows up in
the pid hash tables so we can get away without a special check.

Eric
