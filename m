Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbTEBR5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 13:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbTEBR5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 13:57:45 -0400
Received: from oker.escape.de ([194.120.234.254]:7126 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id S263038AbTEBR5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 13:57:42 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] settimeofday(2) succeeds for microsecond value more than USEC_PER_SEC and for negative value
References: <94F20261551DC141B6B559DC491086723E1028@blr-m3-msg.wipro.com>
	<3E973546.70809@mvista.com>
From: Urs Thuermann <urs@isnogud.escape.de>
Date: 02 May 2003 20:06:13 +0200
In-Reply-To: <3E973546.70809@mvista.com>; from george anzinger on Fri, 11 Apr 2003 14:36:06 -0700
Message-ID: <m265otw7e2.fsf@isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> writes:

> Uh, sure.  This is the test I prefer:
> 
> 	if( (unsigned long)tv->usec > USEC_PER_SEC)
> 		return EINVAL;
> 
> Note that the unsigned picks up the negative value as well as the >
> (and it does it in only one machine code test/jmp :)

No, don't do the compilers job.  Just write

        if (tv->usec < 0 || tv->usec >= USEC_PER_SEC) { ... }

This is easier to read, portable, and generates the same machine code
as your C code, at least in all gcc versions since gcc-2.7.2.3 (I
don't have older gcc versions here on my machine to test).


urs
