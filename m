Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262650AbRE3VeT>; Wed, 30 May 2001 17:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262656AbRE3Vd7>; Wed, 30 May 2001 17:33:59 -0400
Received: from t2.redhat.com ([199.183.24.243]:39925 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262650AbRE3Vd6>; Wed, 30 May 2001 17:33:58 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200105302008.NAA07710@csl.Stanford.EDU> 
In-Reply-To: <200105302008.NAA07710@csl.Stanford.EDU> 
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 2.4.5-ac4 non-init functions calling init functions 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 May 2001 22:33:23 +0100
Message-ID: <26484.991258403@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


engler@csl.Stanford.EDU said:
> drivers/mtd/docprobe.c:195:DoC_Probe: ERROR:INIT: non-init fn
> 'DoC_Probe' calling init fn 'doccheck'

Strictly speaking, not actually a bug. DoC_Probe() itself is only ever 
called from __init code. But it's probably not worth trying to make the 
checker notice that situation - I've fixed it anyway by making DoC_Probe() 
__init too, which saves a bit more memory. Thanks.

parse_mem_cmdline() in arch/i386/kernel/setup.c is a similar false (or at
least questionable) positive. Note that it's an inline function, only used
inside setup_arch(), which _is_ marked __init.

--
dwmw2


