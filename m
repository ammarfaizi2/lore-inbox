Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264886AbUEUX57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264886AbUEUX57 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbUEUXvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:51:08 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28347 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265146AbUEUXdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:33:08 -0400
Subject: Re: IPsec/crypto kernel panic in 2.6.[456]
From: Christophe Saout <christophe@saout.de>
To: Tobias =?ISO-8859-1?Q?Ringstr=F6m?= <tobias@ringstrom.mine.nu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <40ABBA0F.5050805@ringstrom.mine.nu>
References: <40ABBA0F.5050805@ringstrom.mine.nu>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1085048328.25149.8.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Thu, 20 May 2004 12:18:49 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi, den 19.05.2004 um 21:48 Uhr +0200 schrieb Tobias Ringström:

> I have not analyzed the code closely, so I cannot say for certain that 
> there is a problem with that specific changeset, and I'm certainly not 
> out to blame anyone, but reverting it at least seems to fix the problem. 
> The panic occurs when I receive more than a little TCP data in an 
> IPsec ESP tunnel.  I'm of course willing to test patches or provide 
> further info if required.

I've been using linux 2.6. IPSec myself for quite some time and never
seen this. Hmm. What kind of tunnel is this? How large are the packets
involved?

Can you send me your .config and tell me what compiler was used, and
perhaps the object files in your kernel crypto/ directory?

> eax: 0030f000   ebx: 00030f00   ecx: 1b24b797   edx: ba4d7f77
> esi: dcf91438   edi: 77d89bb3   ebp: c040fbb0   esp: c040fb5c
                       ^^^^^^^^

What kind of address is this? Something random? The ESP code uses
in-place decryption, so this should point on the stack.

> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c040e000 task=c0386a40)
> Stack:
> 77d89bb3 dcf91330 da6e4458 e38c28ed dcf91438 77d89bb3 c040fbf0 77d89bb3
  ^^^^^^^^                                     ^^^^^^^^          ^^^^^^^

Here it is again.


