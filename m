Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVHQSTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVHQSTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 14:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVHQSTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 14:19:14 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:58896 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S1751194AbVHQSTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 14:19:14 -0400
Date: Wed, 17 Aug 2005 19:18:35 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Joshua Wise <Joshua.Wise@sicortex.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
       Aaron Brooks <aaron.brooks@sicortex.com>
Subject: Re: NAPI poll routine happens in interrupt context?
Message-ID: <20050817181835.GE2667@linux-mips.org>
References: <200508170932.10441.Joshua.Wise@sicortex.com> <20050817094317.3437607e@dxpl.pdx.osdl.net> <200508171321.20094.Joshua.Wise@sicortex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508171321.20094.Joshua.Wise@sicortex.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 01:21:18PM -0400, Joshua Wise wrote:

> > The bug is that ipv6 is doing an operation to handle MIB statistics and
> > the MIPS architecture math routines seem to need to sleep.

Except nothing in the network stack is using fp - the use of FP inside the
MIPS kernel is not supported in any way.  What happend is probably the
fetching of the opcode of the instruction in the branch delay slot of
the unaligned instruction emulator blew up because it uses a get_user which
again calls might_sleep and that won't exactly work if not called from
process context.

  Ralf
