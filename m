Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWAEOBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWAEOBM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWAEOBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:01:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27308 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751302AbWAEOBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:01:11 -0500
Date: Thu, 5 Jan 2006 06:00:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce sizeof(percpu_data) and removes dependance
 against NR_CPUS
Message-Id: <20060105060050.37ec91d3.akpm@osdl.org>
In-Reply-To: <43BD2406.2040007@cosmosbay.com>
References: <1135251766.3557.13.camel@pmac.infradead.org>
	<20060105021929.498f45ef.akpm@osdl.org>
	<43BD2406.2040007@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> Current sizeof(percpu_data) is NR_CPUS*sizeof(void *)
> 
>  This trivial patch makes percpu_data real size depends on 
>  highest_possible_processor_id() instead of NR_CPUS
> 
>  percpu_data allocations are not performance critical, we can spend few CPU 
>  cycles and save some ram.

hm, highest_possible_processor_id() isn't very efficient.  And it's quite
dopey that it's a macro.  We should turn it into a real function which
caches its return result and goes BUG if it's called before
cpu_possible_map is initialised.
