Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267587AbUHEH32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267587AbUHEH32 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 03:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267588AbUHEH32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 03:29:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37053 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267587AbUHEH30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 03:29:26 -0400
Date: Thu, 5 Aug 2004 03:28:38 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [sparc32] [12/13] gcc-3.3 macro parenthesization fix for memcpy.S
Message-ID: <20040805072838.GS8296@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040805044130.GU2334@holomorphy.com> <20040805044427.GV2334@holomorphy.com> <20040805044627.GW2334@holomorphy.com> <20040805044736.GX2334@holomorphy.com> <20040805044839.GY2334@holomorphy.com> <20040805044950.GZ2334@holomorphy.com> <20040805045417.GA2334@holomorphy.com> <20040805045528.GB2334@holomorphy.com> <20040805045643.GC2334@holomorphy.com> <20040805050141.GD2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805050141.GD2334@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 10:01:41PM -0700, William Lee Irwin III wrote:
> On Wed, Aug 04, 2004 at 09:56:43PM -0700, William Lee Irwin III wrote:
> > SMP support is in need of a great deal of work to port it from 2.2 and
> > 2.4. Add a dependency on BROKEN in the Kconfig to warn the unwary.
> 
> From: Art Haas <ahaas@airmail.net>
> 
> The 1.3->1.4 changes to the arch/sparc/lib/copy_user.S file added
> parenthesis to a number of macros within that file. The BK changlog
> associated with this change indicate the change was to make the
> file work with gcc-3.3.
> 
> When looking at the changes made, I see that similar macros exist in
> memcpy.S as well, so would a patch adding parens to that file be
> worthwhile? Also, just what was the problem with gcc-3.3 that was
> resolved by adding the parenthesis? Macro mis-expansion I'm guessing.

The problem was an (already fixed) gas bug, which for a short time treated
%reg - -0x02
as if there was a -- operator in between.
arch/arch/lib/memcpy.S never passes -0xNN offsets to any of these macros,
so the parenthesis is unnecessary there IMHO.

	Jakub
