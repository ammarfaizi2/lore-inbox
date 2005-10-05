Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbVJELXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbVJELXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 07:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbVJELX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 07:23:26 -0400
Received: from ozlabs.org ([203.10.76.45]:11401 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932624AbVJELXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 07:23:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17219.46514.903283.21680@cargo.ozlabs.ibm.com>
Date: Wed, 5 Oct 2005 21:14:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas <linas@austin.ibm.com>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] ppc64: EEH Add event/internal state statistics
In-Reply-To: <20050930005451.GC6173@austin.ibm.com>
References: <20050930004800.GL29826@austin.ibm.com>
	<20050930005451.GC6173@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas writes:

> 03-eeh-statistics.patch

> +	if (!dn) {
> +		__get_cpu_var(no_dn)++;

We have to make sure we are not preemptible when we use
__get_cpu_var, since it uses smp_processor_id().  It's not clear to me
that we have ensured that in every case where we use __get_cpu_var.
Are you sure that we hold a spinlock, or are at interrupt level, or
have explicitly disabled preemption at every point where we use
__get_cpu_var?

Regards,
Paul.
