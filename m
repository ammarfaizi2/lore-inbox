Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUGQSrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUGQSrY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 14:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUGQSrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 14:47:23 -0400
Received: from ozlabs.org ([203.10.76.45]:10921 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261252AbUGQSrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 14:47:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16633.20057.434313.475775@cargo.ozlabs.ibm.com>
Date: Sun, 18 Jul 2004 02:05:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [PATCH] 2.6 PPC64: EEH notifier call chain
In-Reply-To: <20040707152412.F21634@forte.austin.ibm.com>
References: <20040707152412.F21634@forte.austin.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas,

> Please review and forward upstream as appropriate.  

Sorry for the delay; have been on vacation.

> This patch implements a notifier call chain for EEH, as per pervious emails.
> When an EEH slot freeze is detected, it is placed on a workqueue, from
> whence it is dispatched to any regiistered notify callbacks.   The goal 
> of the qorkqueue is to pull the slot-freeze detection out of an interrupt 
> context.    As before, this patch only handles events for ethernet controllers;
> I'll try to broaden the scope in future revisions.

I don't like the way we are making a policy decision here that
ethernet devices can be recovered but other devices can't.  I would
much rather call the notifier for all EEH events and have the notify
callback(s) make the decision.  That could be either the hotplug
driver or the device driver itself.  We get a return value from
notifier_call_chain that could be used to communicate that back to
eeh.c, if that is useful.

Regards,
Paul.
