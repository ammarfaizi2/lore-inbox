Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWJXBFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWJXBFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 21:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWJXBFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 21:05:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:54443 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964885AbWJXBFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 21:05:12 -0400
Message-ID: <453D66C6.5080008@us.ibm.com>
Date: Mon, 23 Oct 2006 20:05:10 -0500
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/13] KVM: define exit handlers
References: <453CC390.9080508@qumranet.com> <20061023133106.C19DB250143@cleopatra.q>
In-Reply-To: <20061023133106.C19DB250143@cleopatra.q>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> +static int handle_external_interrupt(struct kvm_vcpu *vcpu,
> +				     struct kvm_run *kvm_run)
> +{
> +	++kvm_stat.irq_exits;
> +	return 1;
> +}
>   

Don't you need to propagate the interrupt here?  In Xen, we inject the 
interrupt using the IDT.  As a module, you don't have access to that.  
However, you could use a software interrupt to reraise it.

I got your code running this afternoon (it's quite cool) but I noticed a 
ton of "rtc: lost some interrupts at 1024Hz." messages which leads me to 
believe.. you're dropping interrupts :-)  Things seem to hang trying to 
bring up eth0 in the guest.

BTW, have you setup a mailing list yet?

Regards,

Anthony Liguori
