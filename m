Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVADXdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVADXdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVADXMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:12:54 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28342 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262381AbVADXI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:08:29 -0500
Subject: Re: [PATCH] properly split capset_check+capset_set
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050104162745.GA400@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20050104162745.GA400@IBM-BWN8ZTBWA01.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104857632.17166.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 04 Jan 2005 22:03:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-04 at 16:27, Serge E. Hallyn wrote:
> The attached patch removes checks from kernel/capability.c which are
> redundant with cap_capset_check() code, and moves the capset_check()
> calls to immediately before the capset_set() calls.  This allows
> capset_check() to accurately check the setter's permission to set caps
> on the target.  Please apply.

Why does this help ?

A partial failure now returns no error ?


);
> +		while_each_thread(g, target) {
> +			if (!security_capset_check(target, effective,
> +							inheritable,
> +							permitted)) {
> +				security_capset_set(target, effective,
> +							inheritable,
> +							permitted);
> +				ret = 0;
> +			}
> +			found = 1;

