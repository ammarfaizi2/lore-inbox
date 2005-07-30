Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbVG3DY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVG3DY5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 23:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVG3DY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 23:24:56 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:28356 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262758AbVG3DY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 23:24:56 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: george@mvista.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watch dog notify patch 
In-reply-to: Your message of "Fri, 29 Jul 2005 13:55:23 MST."
             <42EA97BB.8020001@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 30 Jul 2005 13:24:51 +1000
Message-ID: <12270.1122693891@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005 13:55:23 -0700, 
George Anzinger <george@mvista.com> wrote:
>	This patch adds a notify to the die_nmi notify that the system
>	is about to be taken down.  If the notify is handled with a
>	NOTIFY_STOP return, the system is given a new lease on life.
> 
> void die_nmi (struct pt_regs *regs, const char *msg)
> {
>+	if (notify_die(DIE_NMIWATCHDOG, "nmi_watchdog", regs, 
>+		       0, 0, SIGINT) == NOTIFY_STOP)
>+		return;
>+
> 	spin_lock(&nmi_print_lock);
> 	/*
> 	* We are in trouble anyway, lets at least try

Minor nitpick.  die_nmi() already gets a message passed in to
distinguish between different types of nmi.  Pass that message to
notify_die(), on the off chance that the notified routines can use that
difference.

Also your patch adds a trailing whitespace on the call to notify_die().

