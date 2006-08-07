Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWHGIEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWHGIEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 04:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWHGIEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 04:04:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:60838 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751148AbWHGIEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 04:04:53 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [patch] i386: fix one case of stuck dwarf2 unwinder II
Date: Mon, 7 Aug 2006 10:04:37 +0200
User-Agent: KMail/1.9.3
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>,
       "Jesper Juhl" <jesper.juhl@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       "Dave Jones" <davej@redhat.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
References: <200608061212_MC3-1-C747-C2AD@compuserve.com> <44D70F42.76E4.0078.0@novell.com>
In-Reply-To: <44D70F42.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608071004.37849.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 10:00, Jan Beulich wrote:
> >> Yes that's the problem. If you check for <= stext/_stext then the unwinder
> >> won't catch the L6 (which is above it) and report a "stuck" again
> >
> >Maybe I'm being dense here, but:
> >
> >c0100210 t L6
> >c0100212 t check_x87
> >c010023a t setup_idt
> >c0100257 t rp_sidt
> >c0100264 t ignore_int
> >c0100298 T stext
> >c0100298 T _stext
> >
> >It looks like L6 is before _stext to me.
> 
> So it would seem to me. Nevertheless, in my opinion the proper fix is to annotate the call site
> (in head.S) to specify a zero EIP as return address (which denotes the bottom of a frame).

Can you please send a patch to do that?

That seems to be missing in some other places too, e.g. i386 sysenter path, x86-64 kernel_thread,
more?

-Andi

 
