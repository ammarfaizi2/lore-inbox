Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWJWGRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWJWGRZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWJWGRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:17:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:26078 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751577AbWJWGRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:17:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RyL3NsfgTz5mUeutx+sosxzSJEcIKcKPsMYNIv76TV7UkAkIaK2MfBXw4mF7ccXegK4W39jpQfuCEeCD6ppga0nR+EAus/CqxD8tvg59p23qaApFVMuqKjzSlyQHGEkmgs8PPHN/fVhAoLKF0TPZ22aLPDSIZ3U9lg7S6oNb1TU=
Message-ID: <86802c440610222317l1867ab38v4c33231b96237b7f@mail.gmail.com>
Date: Sun, 22 Oct 2006 23:17:23 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 2/2] x86_64 irq: Only look at per_cpu data for online cpus.
Cc: "Andi Kleen" <ak@suse.de>, "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <m1k62ry7hl.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610212100.k9LL0GtC018787@hera.kernel.org>
	 <20061022035109.GM5211@rhun.haifa.ibm.com>
	 <m1psck21fc.fsf@ebiederm.dsl.xmission.com>
	 <20061022085216.GQ5211@rhun.haifa.ibm.com>
	 <m1ods3y7nc.fsf_-_@ebiederm.dsl.xmission.com>
	 <m1k62ry7hl.fsf_-_@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> When I generalized __assign_irq_vector I failed to pay attention
> to what happens when you access a per cpu data structure for
> a cpu that is not online.   It is an undefined case making any
> code that does it have undefined behavior as well.
>
> The code still needs to be able to allocate a vector across cpus
> that are not online to properly handle combinations like lowest
> priority interrupt delivery and cpu_hotplug.  Not that we can do
> that today but the infrastructure shouldn't prevent it.
>
> So this patch updates the places where we touch per cpu data
> to only touch online cpus, it makes cpu vector allocation
> an atomic operation with respect to cpu hotplug, and it updates
> the cpu start code to properly initialize vector_irq so we
> don't have inconsistencies.
>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Acked-by: Yinghai Lu <yinghai.lu@amd.com>
