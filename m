Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVKAF2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVKAF2B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbVKAF2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:28:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932345AbVKAF2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:28:00 -0500
Date: Mon, 31 Oct 2005 21:27:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: torvalds@osdl.org, marcelo.tosatti@cyclades.com, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, lee.schermerhorn@hp.com,
       linux-kernel@vger.kernel.org, clameter@sgi.com, magnus.damm@gmail.com,
       pj@sgi.com, haveblue@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 5/5] Swap Migration V5: sys_migrate_pages interface
Message-Id: <20051031212742.3e43c829.akpm@osdl.org>
In-Reply-To: <20051101031305.12488.1224.sendpatchset@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
	<20051101031305.12488.1224.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> ...
> Changes V3->V4:
> - Add Ray's permissions check based on check_kill_permission().
> 
> ...
> +	/*
> +	 * Permissions check like for signals.
> +	 * See check_kill_permission()
> +	 */
> +	if ((current->euid ^ task->suid) && (current->euid ^ task->uid) &&
> +	    (current->uid ^ task->suid) && (current->uid ^ task->uid) &&
> +	    !capable(CAP_SYS_ADMIN)) {
> +		err = -EPERM;
> +		goto out;
> +	}

Obscure.  Can you please explain the thinking behind putting this check in
here?  Preferably via a comment...
