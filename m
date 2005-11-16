Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbVKPNwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbVKPNwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbVKPNwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:52:49 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:54459 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030333AbVKPNws
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:52:48 -0500
Date: Wed, 16 Nov 2005 07:53:01 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org, Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC] [PATCH 12/13] Change pid accesses: ia64 and mips
Message-ID: <20051116135301.GB3960@IBM-BWN8ZTBWAO1>
References: <20051114212530.486945000@sergelap> <22645.1132096092@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22645.1132096092@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Keith Owens (kaos@sgi.com):
> On Mon, 14 Nov 2005 15:23:53 -0600, 
> "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> >Index: linux-2.6.15-rc1/arch/ia64/kernel/mca.c
> >===================================================================
> >--- linux-2.6.15-rc1.orig/arch/ia64/kernel/mca.c
> >+++ linux-2.6.15-rc1/arch/ia64/kernel/mca.c
> >@@ -755,9 +755,9 @@ ia64_mca_modify_original_stack(struct pt
> > 	 * (swapper or nested MCA/INIT) then use the start of the previous comm
> > 	 * field suffixed with its cpu.
> > 	 */
> >-	if (previous_current->pid)
> >+	if (previous_task_pid(current))
> > 		snprintf(comm, sizeof(comm), "%s %d",
> >-			current->comm, previous_current->pid);
> >+			current->comm, previous_task_pid(current));
> > 	else {
> > 		int l;
> > 		if ((p = strchr(previous_current->comm, ' ')))
> 
> That makes no sense, previous_task_pid() is not defined anywhere.
> Looks like a global edit error and should probably be
> task_pid(previous_current).

Note there are a few more ia64 errors - working on a test compile
now and will send out a new patch, though i don't have the hw to
boot-test.

thanks,
-serge

