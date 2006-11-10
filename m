Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946684AbWKJONI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946684AbWKJONI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 09:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946685AbWKJONI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 09:13:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43395 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946684AbWKJONF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 09:13:05 -0500
Subject: Re: [RFC] [PATCH] Fix misrouted interrupts deadlocks
From: Ingo Molnar <mingo@redhat.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       Kirill Korotaev <dev@openvz.org>
In-Reply-To: <455484E4.1020100@openvz.org>
References: <455484E4.1020100@openvz.org>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 15:12:30 +0100
Message-Id: <1163167950.1980.4.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 16:55 +0300, Pavel Emelianov wrote:
> -                       int ok = misrouted_irq(irq);
> +                       int ok;
> +
> +                       spin_unlock(&desc->lock);
> +                       ok = misrouted_irq(irq);
> +                       spin_lock(&desc->lock); 

your fix looks reasonable to me - it's a thinko to call misrouted_irq()
with the descriptor lock still held. (btw., how did you find it -
lockdep spinlock debugging or NMI watchdog?)

Acked-by: Ingo Molnar <mingo@redhat.com>

	Ingo

