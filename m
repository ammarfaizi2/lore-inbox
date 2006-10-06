Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWJFOgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWJFOgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWJFOgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:36:00 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:8677 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932364AbWJFOf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:35:59 -0400
Date: Fri, 6 Oct 2006 16:35:55 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>,
       Len Brown <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] Cast removal
Message-ID: <20061006143555.GC14186@rhun.haifa.ibm.com>
References: <B28E9812BAF6E2498B7EC5C427F293A40114A6CB@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A40114A6CB@orsmsx415.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 03:14:02PM -0700, Moore, Robert wrote:
> If you're discussing this type of thing, I agree wholeheartedly:
> 
> static void acpi_processor_notify(acpi_handle handle, u32 event, void
> *data)  {
> -	struct acpi_processor *pr = (struct acpi_processor *)data;
> +	struct acpi_processor *pr = data;
> 
> 
> I find this one interesting, as we've put a number of them into the
> ACPICA core:
> 
> -	(void) kmem_cache_destroy(cache);
> +	kmem_cache_destroy(cache);
> 
> I believe that the point of the (void) is to prevent lint from
> squawking, and perhaps some picky ANSI-C compilers. What is the overall
> Linux policy on this?

IMHO there's another reason to do this which is much more relevant: it
tells the reader that whoever wrote it knows that it returns a value
and ignores it on purpose.

Cheers,
Muli
