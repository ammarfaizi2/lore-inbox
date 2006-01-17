Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWAQP4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWAQP4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWAQP4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:56:04 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:29644 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750814AbWAQP4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 10:56:02 -0500
Date: Tue, 17 Jan 2006 09:56:00 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Serge Hallyn <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
Message-ID: <20060117155600.GF20632@sergelap.austin.ibm.com>
References: <20060117143258.150807000@sergelap> <20060117143326.283450000@sergelap> <1137511972.3005.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137511972.3005.33.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arjan van de Ven (arjan@infradead.org):
> On Tue, 2006-01-17 at 08:33 -0600, Serge Hallyn wrote:
> > plain text document attachment (BC-define-pid-handlers)
> > Actually define the task_pid() and task_tgid() functions.  Also
> > replace pid with __pid so as to make sure any missed accessors are
> > caught.
> 
> This question was asked a few times before without satisfactory answer:
> *WHY* this abstraction.
> There is *NO* point. Really. 
> 
> (And if the answer is "but we want to play tricks later", just make a
> current->realpid or whatever, but leave current->pid be the virtual pid.
> Your abstraction helps NOTHING there. Zero Nada Noppes).

The virtual pid is different depending on who is asking.  So simply
storing current->realpid and current->pid isn't helpful, as we would
still need to call a function when a pid crosses user->kernel boundary.

However we could make the patch far less invasive by skipping the
task_pid() macro altogether.  Switching current->pid to current->__pid
was to make sure we catch any ->pid accesses which we may have missed,
during compilation.

Is that approach (keeping task->pid as the real pid and dropping the
task_pid() macro) preferred by all?

-serge

