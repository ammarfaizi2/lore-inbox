Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267576AbUJOKno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbUJOKno (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 06:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUJOKno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 06:43:44 -0400
Received: from holomorphy.com ([207.189.100.168]:46728 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267576AbUJOKnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 06:43:43 -0400
Date: Fri, 15 Oct 2004 03:43:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, John Hawkes <hawkes@sgi.com>,
       Ray Bryant <raybry@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [profile] fix timer interrupt livelock on 512x Altix
Message-ID: <20041015104311.GD5607@holomorphy.com>
References: <20040920213020.GX9106@holomorphy.com> <1097804782.22673.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097804782.22673.56.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 07:30, William Lee Irwin III wrote:
>> +static void __profile_flip_buffers(void *unused)
>> +{
>> +	int cpu = smp_processor_id();
>> +
>> +	per_cpu(cpu_profile_flip, cpu) = !per_cpu(cpu_profile_flip, cpu);
>> +}

On Fri, Oct 15, 2004 at 11:46:22AM +1000, Rusty Russell wrote:
> Please: one point of per-cpu vars is that archs can choose to hold the
> per-cpu offset in a reg, and derive smp_processor_id() from that.  By
> doing the reverse, manually, you defeat this.  How about:
> 	int *flip = __get_cpu_var(cpu_profile_flip);
> 	*flip = !*flip;

Proof once more that sustained and repeated exposure to shitty
architectures degrades intelligence. I'll send in a correction shortly.


-- wli
