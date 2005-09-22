Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbVIVFEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbVIVFEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 01:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVIVFEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 01:04:45 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:14754 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030217AbVIVFEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 01:04:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=FCOIOoLjev6CrdzWL2FPXi6OTHBovoE0gieZN7mjqkkRCUz33yixh0NB6xRkFAA+GBjX+cg8yZldod5c6UYlaTyWhP4j6Hzc1PQf7DpnKLdR0E20nEZmhNd+WRA16EJPmdPa2Skrr5QrYcDpPXleVBHa7eYWxVCmSel7Q8uH0ac=  ;
Message-ID: <43323BA1.6000100@yahoo.com.au>
Date: Thu, 22 Sep 2005 15:05:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: Checks for cmpxchg in get_task_struct_rcu()
References: <1127345874.19506.43.camel@dhcp153.mvista.com>	 <433201FC.8040004@yahoo.com.au>	 <1127355538.8950.1.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1127364629.8950.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
In-Reply-To: <1127364629.8950.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:

> +#else
> +	raw_local_irq_disable();
> +	oldusage = atomic_read(&t->usage);
> +	if (oldusage == 0) {
> +		raw_local_irq_enable();
> +		return 0;
> +	}

Isn't this still racy if another cpu drops the last reference
to task struct here? Or can't that happen?

When you said "disable preempt", I had some silly idea that this
function was only used in PREEMPT_RT mode, and that you would
simply disallow architectures without cmpxchg from configuring
PREEMPT_RT.

> +	atomic_inc(&t->usage);
> +	raw_local_irq_enable();
> +#endif

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
