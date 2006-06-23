Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932752AbWFWB0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbWFWB0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932753AbWFWB0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:26:44 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:18157 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932752AbWFWB0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:26:43 -0400
Date: Thu, 22 Jun 2006 19:24:03 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: make PROT_WRITE imply PROT_READ
In-reply-to: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no>
To: Jason Baron <jbaron@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <449B42B3.6010908@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Baron wrote:
> Currently, if i mmap() a file PROT_WRITE only and then first read from it 
> and then write to it, i get a SEGV. However, if i write to it first and 
> then read from it, i get no SEGV. This seems rather inconsistent.
> 
> The current implementation seems to be to make PROT_WRITE imply PROT_READ, 
> however it does not quite work correctly. The patch below resolves this 
> issue, by explicitly setting the PROT_READ flag when PROT_WRITE is 
> requested.

I would disagree.. the kernel is enforcing the permissions specified 
where the CPU architecture allows it. There is no sense in breaking this 
everywhere just because we can't always enforce it. By that logic we 
should be making PROT_READ imply PROT_EXEC because not all CPUs can 
enforce them separately, which makes no sense at all.

> 
> This might appear at first as a possible permissions subversion, as i 
> could get PROT_READ on a file that i only have write permission 
> to...however, the mmap implementation requires that the file be opened 
> with at least read access already. Thus, i don't believe there is any 
> issue with regards to permissions.
> 
> Another consequenece of this patch is that it forces PROT_READ even for 
> architectures that might be able to support it, (I know that x86, x86_64 
> and ia64 do not) but i think this is best for portability.

That makes little sense to me.. if you want portability, and you're 
reading from the file, you better request PROT_READ. Any app that 
doesn't do that is inherently broken and non-portable regardless of what 
you do to the kernel.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

