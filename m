Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbWHFQRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbWHFQRi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 12:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbWHFQRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 12:17:38 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:48332 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932608AbWHFQRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 12:17:38 -0400
Date: Sun, 6 Aug 2006 12:09:47 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: fix one case of stuck dwarf2 unwinder II
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Dave Jones <davej@redhat.com>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608061212_MC3-1-C747-C2AD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200608061604.40452.ak@suse.de>

On Sun, 6 Aug 2006 16:04:40 +0200, Andi Kleen wrote:

> > And the backtraces I saw ended up at L6:
> > 
> > | DWARF2 unwinder stuck at 0xc0100210
> > 
> > System.map on i386 SMP says:
> > 
> > | c0100210 t L6
> 
> 
> Yes that's the problem. If you check for <= stext/_stext then the unwinder
> won't catch the L6 (which is above it) and report a "stuck" again

Maybe I'm being dense here, but:

c0100210 t L6
c0100212 t check_x87
c010023a t setup_idt
c0100257 t rp_sidt
c0100264 t ignore_int
c0100298 T stext
c0100298 T _stext

It looks like L6 is before _stext to me.

-- 
Chuck

