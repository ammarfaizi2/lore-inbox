Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVK1Sjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVK1Sjx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 13:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVK1Sjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 13:39:53 -0500
Received: from cantor.suse.de ([195.135.220.2]:32653 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932136AbVK1Sjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 13:39:52 -0500
To: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH 1/4] stack overflow safe kdump (i386) - safe_smp_processor_id
References: <1133200833.2425.100.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 28 Nov 2005 16:07:40 -0700
In-Reply-To: <1133200833.2425.100.camel@localhost.localdomain>
Message-ID: <p738xv8id6r.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> writes:
> 
> To circumvent this problem I suggest implementing
> "safe_smp_processor_id()" (it already exists on x86_64) for i386 and
> IA64 and use it as a replacement to smp_processor_id in the reboot path
> to the dump capture kernel. This is a possible implementation for i386.

It's not fully safe, because a SMP kernel might run on a 32bit
system without APIC. Then hard_smp_processor_id() would fault. 
(this cannot happen on x86-64)

You probably need to check one of the globals set by apic.c
when its disabled.

-Andi
