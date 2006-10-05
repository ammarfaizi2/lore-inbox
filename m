Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWJEW05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWJEW05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWJEW05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:26:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2233 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932377AbWJEW04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:26:56 -0400
Date: Thu, 5 Oct 2006 15:26:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, "Len Brown" <lenb@kernel.org>,
       "Brown, Len" <len.brown@intel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "ACPI List" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] Cast removal
Message-Id: <20061005152608.b6a7fb27.akpm@osdl.org>
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A40114A6CB@orsmsx415.amr.corp.intel.com>
References: <B28E9812BAF6E2498B7EC5C427F293A40114A6CB@orsmsx415.amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006 15:14:02 -0700
"Moore, Robert" <robert.moore@intel.com> wrote:

> If you're discussing this type of thing, I agree wholeheartedly:
> 
> static void acpi_processor_notify(acpi_handle handle, u32 event, void
> *data)  {
> -	struct acpi_processor *pr = (struct acpi_processor *)data;
> +	struct acpi_processor *pr = data;
> 

OK, thanks.  I would expect all compilers to be happy with that.  However a
bit of googling I did indicated that lint (or some flavour thereof)
complains about the missing cast.  Which is dumb of it.

> I find this one interesting, as we've put a number of them into the
> ACPICA core:
> 
> -	(void) kmem_cache_destroy(cache);
> +	kmem_cache_destroy(cache);
> 
> I believe that the point of the (void) is to prevent lint from
> squawking, and perhaps some picky ANSI-C compilers. What is the overall
> Linux policy on this?

policy = not;

But there's quite a lot of it in the tree.

Actually..  kmem_cache_destroy() returns void, so any checker which complains
about the missing cast needs a stern talking to.
