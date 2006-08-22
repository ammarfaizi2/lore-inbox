Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWHVJBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWHVJBL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 05:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWHVJBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 05:01:11 -0400
Received: from ns.suse.de ([195.135.220.2]:26021 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932149AbWHVJBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 05:01:09 -0400
Date: Tue, 22 Aug 2006 11:01:06 +0200
From: Andi Kleen <ak@suse.de>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Magnus Damm <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: Reload CS when startup_64 is used.
Message-Id: <20060822110106.7582fcb9.ak@suse.de>
In-Reply-To: <m1y7thqi7b.fsf_-_@ebiederm.dsl.xmission.com>
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
	<1156208306.21411.85.camel@localhost>
	<m1u045sagu.fsf@ebiederm.dsl.xmission.com>
	<200608221003.12608.ak@suse.de>
	<m1y7thqi7b.fsf_-_@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 02:37:44 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> 
> In long mode the %cs is largely a relic.  However there are a few cases
> like lret 

You mean iret?


> +	 * jump.  In addition we need to ensure %cs is set so we make this
> +	 * a far return.	
>  	 */
>  	movq	initial_code(%rip),%rax
> -	jmp	*%rax
> +	pushq	$__KERNEL_CS
> +	pushq	%rax
> +	lretq

Ok merged thanks

-Andi
