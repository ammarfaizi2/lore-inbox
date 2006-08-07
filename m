Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWHGIAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWHGIAA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 04:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWHGIAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 04:00:00 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:46538
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751145AbWHGH77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 03:59:59 -0400
Message-Id: <44D70F42.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 07 Aug 2006 09:00:34 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>, "Andi Kleen" <ak@suse.de>
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       "Dave Jones" <davej@redhat.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: fix one case of stuck dwarf2 unwinder II
References: <200608061212_MC3-1-C747-C2AD@compuserve.com>
In-Reply-To: <200608061212_MC3-1-C747-C2AD@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Yes that's the problem. If you check for <= stext/_stext then the unwinder
>> won't catch the L6 (which is above it) and report a "stuck" again
>
>Maybe I'm being dense here, but:
>
>c0100210 t L6
>c0100212 t check_x87
>c010023a t setup_idt
>c0100257 t rp_sidt
>c0100264 t ignore_int
>c0100298 T stext
>c0100298 T _stext
>
>It looks like L6 is before _stext to me.

So it would seem to me. Nevertheless, in my opinion the proper fix is to annotate the call site
(in head.S) to specify a zero EIP as return address (which denotes the bottom of a frame).

Jan
