Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWGLQpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWGLQpS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWGLQpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:45:18 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:29359 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751353AbWGLQpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:45:16 -0400
Subject: Re: [Patch] statistics infrastructure - update 10
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060712091024.c5bd19c7.akpm@osdl.org>
References: <1152707259.3028.7.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	 <20060712091024.c5bd19c7.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 18:45:08 +0200
Message-Id: <1152722709.3028.28.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 09:10 -0700, Andrew Morton wrote:
> On Wed, 12 Jul 2006 14:27:39 +0200
> Martin Peschke <mp3@de.ibm.com> wrote:
> 
> > +#define statistic_ptr(stat, cpu) \
> > +	((struct percpu_data*)((stat)->data))->ptrs[(cpu)]
> 
> This would be the only part of the kernel which uses percpu_data directly -
> everything else uses the APIs (ie: per_cpu_ptr()).  How come?

The API, i.e. per_cpu_ptr(), doesn't allow to assign a value to any of
the pointers in struct percpu_data. I need that capability because I
make use of cpu hotplug notifications to fix per-cpu data at run time.
With regard to memory footprint this is much more efficient than using
alloc_percpu().

Is it be preferable to add something like set_per_cpu_ptr() to the API?

