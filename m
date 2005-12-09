Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbVLILSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbVLILSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 06:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVLILSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 06:18:50 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:18378 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751311AbVLILSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 06:18:49 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: 2.6.15-rc5-mm1 (x86_64-hpet-overflow.patch breaks resume from disk)
Date: Fri, 9 Dec 2005 12:20:05 +0100
User-Agent: KMail/1.9
Cc: discuss@x86-64.org, "Andrew Morton" <akpm@osdl.org>,
       "Andi Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20051204232153.258cd554.akpm@osdl.org> <200512082335.50417.rjw@sisk.pl> <43995957.76F0.0078.0@novell.com>
In-Reply-To: <43995957.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512091220.06060.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 9 December 2005 10:15, Jan Beulich wrote:
> It's a possible way to address this, but I'd rather just set a flag
> indicating that the last-whatever values should not be considered (to
> get into a state just like after initial boot). Jan

OK, but what is the interrupt handler supposed to do if the
vxtime.last* values are invalid?  I guess assume delta = 0?

BTW, in the interrupt handler there is:

		__asm__("mulq %1\n\t"
		        "shrdq $32, %%rdx, %0"
		        : "+a" (delta)
		        : "rm" (vxtime.tsc_quot)
		        : "rdx");

Is the "+a" a typo?

Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
