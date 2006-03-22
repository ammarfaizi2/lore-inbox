Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWCVKW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWCVKW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 05:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWCVKW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 05:22:29 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:36049 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751195AbWCVKW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 05:22:28 -0500
In-Reply-To: <1143016837.2955.20.camel@laptopd505.fenrus.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063801.949835000@sorel.sous-sol.org> <1143016837.2955.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1992b724e8540f8e532806076d07eb9e@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 26/35] Add Xen subarch reboot support
Date: Wed, 22 Mar 2006 10:22:46 +0000
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Mar 2006, at 08:40, Arjan van de Ven wrote:

>> +static int shutdown_process(void *__unused)
>> +{
>> +	static char *envp[] = { "HOME=/", "TERM=linux",
>> +				"PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
>> +	static char *restart_argv[]  = { "/sbin/reboot", NULL };
>> +	static char *poweroff_argv[] = { "/sbin/poweroff", NULL };
>
> how is this function different from the generic one? If not, why aren't
> you using the generic one?

The intent is to allow remote management tools to trigger a clean 
shutdown of the virtual machine. That requires us to notify to 
userspace, and this function does that by exec'ing one of the standard 
userspace programs. Given the trigger is received by the kernel in the 
first instance I don't know a better way of doing this. And if this is 
the best way, I don't think there is generic code in the kernel which 
does the same thing.

  -- Keir

