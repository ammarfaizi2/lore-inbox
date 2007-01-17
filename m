Return-Path: <linux-kernel-owner+w=401wt.eu-S932647AbXAQTJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbXAQTJI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 14:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbXAQTJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 14:09:07 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51399 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932648AbXAQTJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 14:09:04 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Benjamin Romer <benjamin.romer@unisys.com>
Cc: linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: PATCH: Update disable_IO_APIC to use 8-bit destination field (X86_64)
References: <1169052407.3082.43.camel@ustr-romerbm-2.na.uis.unisys.com>
Date: Wed, 17 Jan 2007 12:08:48 -0700
In-Reply-To: <1169052407.3082.43.camel@ustr-romerbm-2.na.uis.unisys.com>
	(Benjamin Romer's message of "Wed, 17 Jan 2007 11:46:46 -0500")
Message-ID: <m1tzyp8o8v.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Romer <benjamin.romer@unisys.com> writes:

> On the Unisys ES7000/ONE system, we encountered a problem where
> performing a kexec reboot or dump on any cell other than cell 0 causes
> the system timer to stop working, resulting in a hang during timer
> calibration in the new kernel. 
>
> We traced the problem to one line of code in disable_IO_APIC(), which
> needs to restore the timer's IO-APIC configuration before rebooting. The
> code is currently using the 4-bit physical destination field, rather
> than using the 8-bit logical destination field, and it cuts off the
> upper 4 bits of the timer's APIC ID. If we change this to use the
> logical destination field, the timer works and we can kexec on the upper
> cells. This was tested on two different cells (0 and 2) in an ES7000/ONE
> system.
>
> For reference, the relevant Intel xAPIC spec is kept at
> ftp://download.intel.com/design/chipsets/e8501/datashts/30962001.pdf,
> specifically on page 334.

Looks like good bug hunting.  I will have to look but it might
make more sense to simply fix: struct IO_APIC_route_entry,
or use whatever technique we normally use to generate the io_apic
vectors.

I don't recall enough off of the top of my head to recall what
the discrimination rule between logical and physical is but
I think setting the system in physical mode is a good clue :)

Eric
