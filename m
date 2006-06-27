Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWF0Dgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWF0Dgn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 23:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933343AbWF0Dgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 23:36:43 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:27025 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S933296AbWF0Dgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 23:36:42 -0400
Subject: Re: the creation of boot_cpu_init() is wrong and accessing
	uninitialised data
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: stsp@aknet.ru, linux-kernel@vger.kernel.org
In-Reply-To: <20060626200433.bf0292af.akpm@osdl.org>
References: <1151376313.3443.12.camel@mulgrave.il.steeleye.com>
	 <20060626200433.bf0292af.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 22:36:32 -0500
Message-Id: <1151379392.3443.20.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 20:04 -0700, Andrew Morton wrote:
> I think arch code should do it before calling start_kernel(), really.
> It's
> just such a basic part of the kernel framework.

Hmm ... well, getting at current_thread_info()->cpu is possible, but
nasty to audit, I would have thought (given that we're in assembler
before start_kernel is called).

> A less wholesome but perhaps simpler solution would be to call the new
> setup_smp_processor_id() on entry to start_kernel().

I was wondering about simply replacing boot_cpu_init() with
smp_prepare_boot_cpu().  By and large they do the same thing on most
archs, and mostly they don't seem to depend on setup_arch() having been
called.

However, introducing setup_smp_processor_id() will also work ... I'll
see if I can do it in an easy way.

James


