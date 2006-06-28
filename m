Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWF1XKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWF1XKS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWF1XKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:10:18 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:52096 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751761AbWF1XKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:10:16 -0400
Subject: Re: the creation of boot_cpu_init() is wrong and accessing
	uninitialised data
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: stsp@aknet.ru, linux-kernel@vger.kernel.org
In-Reply-To: <20060627195743.ce18afe3.akpm@osdl.org>
References: <1151376313.3443.12.camel@mulgrave.il.steeleye.com>
	 <20060626200433.bf0292af.akpm@osdl.org>
	 <1151379392.3443.20.camel@mulgrave.il.steeleye.com>
	 <20060626220337.06014184.akpm@osdl.org>
	 <1151419746.3340.13.camel@mulgrave.il.steeleye.com>
	 <20060627170446.30392b00.akpm@osdl.org>
	 <1151462735.5793.2.camel@mulgrave.il.steeleye.com>
	 <20060627195743.ce18afe3.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 19:10:04 -0400
Message-Id: <1151536204.3377.51.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 19:57 -0700, Andrew Morton wrote:
> I didn't mark it inline.
> 
> If the compiler chose to inline it then that would be rather dumb of
> it,
> given that it had the weak attribute.  But yes, paranoia says we
> should be
> tagging this noinline too.

Sorry, I was thinking static means "I may inline". And indeed, my
compiler says this:

init/main.c: In function 'smp_init':
init/main.c: At top level:
init/main.c:457: error: weak declaration of 'smp_setup_processor_id' must be public
init/main.c:457: error: static declaration of 'smp_setup_processor_id' follows non-static declaration
include/linux/smp.h:128: error: previous declaration of 'smp_setup_processor_id' was here

Making it non-static in init/main.c fixes this

I'm still compiling, so might have the results later this evening.

James



