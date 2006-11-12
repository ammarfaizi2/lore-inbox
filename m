Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755065AbWKLLuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065AbWKLLuu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 06:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755060AbWKLLuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 06:50:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13189 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754189AbWKLLut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 06:50:49 -0500
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru
In-Reply-To: <20061111101942.5f3f2537.akpm@osdl.org>
References: <200611111129.kABBTWgp014081@fire-2.osdl.org>
	 <20061111100038.6277efd4.akpm@osdl.org>
	 <1163268603.3293.45.camel@laptopd505.fenrus.org>
	 <20061111101942.5f3f2537.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 12 Nov 2006 12:50:37 +0100
Message-Id: <1163332237.3293.100.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't know.  In fact I forget how I worked out that it worsened in
> 2.6.early.
> 
> google(noapic) gets 232,000 hits.

is there a way to ask google "only stuff in the last year"?
Asking because "noapic" in 2.4 was the standard "try this" answer when
people had a bios that had busted MPS (but good ACPI)...


> I don't think it really matters when or why it happened. 

well to some degree it does; if it's one patch causing it narrowing it
down at least somewhat in time would help ;)

>  If we take the
> approach of fixing one machine at a time, we'll only need to fix a few
> individual machines to improve the situation for a lot of people.

alternative is that more new machines showed up that need it somehow, eg
not really a regression just something else. Different approach is
needed for hunting that down. But to be realistic we need to narrow
things down a bit, which means

1) Only care about SMP machines. APIC on true UP (no
Hyperthreading/Dualcore) is a thing no hardware vendor tests (Microsoft
doesn't use it) and is just too likely to trip up SMM and other bad BIOS
stuff. 
 * exception is probably people who don't WANT to use apic but where it
somehow gets used anyway; if that happens we probably have the magic
bullet that causes the regression :)
2) Only care about ACPI using kernels. Non-ACPI uses MPS tables for
this, but most vendors hardly maintain those anymore at all and they are
generally just /dev/random nowadays
3) Ignore overclocking; if you overclock using the FSB the apic busses
run out of spec as well; can be a huge timewaster in debug time.



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

