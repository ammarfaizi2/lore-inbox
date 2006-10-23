Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbWJWGPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWJWGPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWJWGPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:15:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:52184 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751583AbWJWGPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:15:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=quwtIGvu9O9lCx0dMoUC4bnnNUrUZ2XIa3h04P56ZTNuCOpF54MvpnWsdznljxZk40ySr+NIwfRV/Ud7brJ4iU0Fx7pYv00INkPBZ9zuHRtyY32e3Y6KzowmTbsnTWVwBrI/DY/CHxUE/Xhrjem+DwR/JISgiqFdYtXaC28buW8=
Message-ID: <86802c440610222315y252bfc03qb4700d82c2a04d3b@mail.gmail.com>
Date: Sun, 22 Oct 2006 23:15:15 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] x86_64 irq: Simplify the vector allocator.
Cc: "Andi Kleen" <ak@suse.de>, "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <m1ods3y7nc.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610212100.k9LL0GtC018787@hera.kernel.org>
	 <20061022035109.GM5211@rhun.haifa.ibm.com>
	 <m1psck21fc.fsf@ebiederm.dsl.xmission.com>
	 <20061022085216.GQ5211@rhun.haifa.ibm.com>
	 <m1ods3y7nc.fsf_-_@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> There is no reason to remember a per cpu position of which vector
> to try.  Keeping a global position is simpler and more likely to
> result in a global vector allocation even if I don't need or require
> it.  For level triggered interrupts this means we are less likely to
> acknowledge another cpus irq, and cause the level triggered irq to
> harmlessly refire.
>
> This simplification makes it easier to only access data structures
> of  online cpus, by having fewer special cases to deal with.
>
>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Good, It will keep increase vector, and only try to use same vector for
different cpu when vector is used up.

Acked-by: Yinghai Lu <yinghai.lu@amd.com>
