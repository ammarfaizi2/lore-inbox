Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbVKOXIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbVKOXIS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbVKOXIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:08:18 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:15812 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S965073AbVKOXIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:08:17 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC] [PATCH 12/13] Change pid accesses: ia64 and mips 
In-reply-to: Your message of "Mon, 14 Nov 2005 15:23:53 MDT."
             <20051114212530.486945000@sergelap> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 Nov 2005 10:08:12 +1100
Message-ID: <22645.1132096092@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2005 15:23:53 -0600, 
"Serge E. Hallyn" <serue@us.ibm.com> wrote:
>Index: linux-2.6.15-rc1/arch/ia64/kernel/mca.c
>===================================================================
>--- linux-2.6.15-rc1.orig/arch/ia64/kernel/mca.c
>+++ linux-2.6.15-rc1/arch/ia64/kernel/mca.c
>@@ -755,9 +755,9 @@ ia64_mca_modify_original_stack(struct pt
> 	 * (swapper or nested MCA/INIT) then use the start of the previous comm
> 	 * field suffixed with its cpu.
> 	 */
>-	if (previous_current->pid)
>+	if (previous_task_pid(current))
> 		snprintf(comm, sizeof(comm), "%s %d",
>-			current->comm, previous_current->pid);
>+			current->comm, previous_task_pid(current));
> 	else {
> 		int l;
> 		if ((p = strchr(previous_current->comm, ' ')))

That makes no sense, previous_task_pid() is not defined anywhere.
Looks like a global edit error and should probably be
task_pid(previous_current).

