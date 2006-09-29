Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWI2WFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWI2WFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 18:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWI2WFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 18:05:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932162AbWI2WFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 18:05:35 -0400
Date: Fri, 29 Sep 2006 15:05:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Fix up a multitude of ACPI compiler warnings on x86_64
Message-Id: <20060929150526.38eec941.akpm@osdl.org>
In-Reply-To: <451D9236.6040902@google.com>
References: <451D9236.6040902@google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 14:37:58 -0700
Martin Bligh <mbligh@google.com> wrote:

> 32bit vs 64 bit issues. sizeof(sizeof) and sizeof(pointer) is variable,
> but we're trying to shove it into unsigned int or u32.
>
> ...
>
> -	"RSDT/XSDT length (%X) is smaller than minimum (%X)",
> +	"RSDT/XSDT length (%X) is smaller than minimum (%lX)",
>  	table_ptr->length,
> -	sizeof(struct acpi_table_header)));
> +	(unsigned long) sizeof(struct acpi_table_header)));
> 

These two sizeof()s have already been fixed by Randy in -mm's
acpi-fix-printk-format-warnings.patch.

Randy's fix is the preferred one: sizeof() returns size_t and size_t's are
printed with %z - there's no need to use a typecast.

(Actually Randy used %Z which avoids the warning which old gcc emitted with
%z, but is old-fashioned.  I'll switch that to %z).


acpi-fix-printk-format-warnings.patch was submitted to the ACPI developers
on August 14 and on September 25 but remains unmerged.
