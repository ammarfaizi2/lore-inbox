Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTFFOUm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTFFOUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:20:41 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:58267 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S261773AbTFFOUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:20:38 -0400
Date: Fri, 6 Jun 2003 16:33:35 +0200
From: Jasper Spaans <jasper@vs19.net>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] fix location of zap_low_mappings
Message-ID: <20030606143335.GA25574@spaans.vs19.net>
References: <20030606095749.GA13037@spaans.vs19.net> <20030606113443.GD8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20030606113443.GD8978@holomorphy.com>
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
X-message-flag: Warning! The sender of this mail thinks you should use a more secure email client!
Keywords: terrorist Marxist Project Monarch strategic Area 51 Cocaine Roswell 
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 04:34:43AM -0700, William Lee Irwin III wrote:
> On Fri, Jun 06, 2003 at 11:57:49AM +0200, Jasper Spaans wrote:
> > When compiling current BK 2.5, I get a warning about zap_low_mappings not
> > being declared. Moving it from smp.h to pgtable.h fixes this (and doesn't
> > break my setup). 
> > Does anyone object to this fix?

> It's basically not supposed to be visible on UP. Perhaps a better
> approach would be declare it in pgtable.h as you did, stub out the UP
> case with an empty function, and un-#ifdef it from mem_init().

That wouldn't seem right to me:

* in the UP-case, it is explicitly called in mem_init() [mm/init.c]:

void __init mem_init(void)
{
[...]
#ifndef CONFIG_SMP
        zap_low_mappings();
#endif
}

* in the SMP-case, this call is delayed until 
  smp_cpus_done() [kernel/smpboot.c]

These two cases are fine however, as the UP-case defines it in mm/init.c,
and the SMP-case has CONFIG_SMP enabled and includes <smp.h>; the warning
comes from this function being called from acpi_restore_state_mem()
[kernel/acpi/sleep.c]) in the UP-case, in which case it isn't declared in
<smp.h>.

Bye,

Jasper
-- 
Jasper Spaans
http://jsp.vs19.net/contact/

``Got no clue? Too bad for you.''
