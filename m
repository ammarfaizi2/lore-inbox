Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264312AbUFQKfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbUFQKfe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 06:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266447AbUFQKfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 06:35:34 -0400
Received: from colin2.muc.de ([193.149.48.15]:60687 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264312AbUFQKfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 06:35:32 -0400
Date: 17 Jun 2004 12:35:29 +0200
Date: Thu, 17 Jun 2004 12:35:29 +0200
From: Andi Kleen <ak@muc.de>
To: eliot@cincom.com
Cc: ak@muc.de, linux-kernel@vger.kernel.org, tgriggs@key.net
Subject: Re: PROBLEM: 2.6 kernels on x86 do not preserve FPU flags across context switches
Message-ID: <20040617103529.GA73341@colin2.muc.de>
References: <200406162302.QAA01806@central.parcplace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406162302.QAA01806@central.parcplace.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 04:01:46PM -0700, eliot@cincom.com wrote:
> Hi Andi,
> 
> 	you asked:
> | On what CPUs does the failure occur? Linux uses different paths
> | depending on if the CPU supports SSE or not.
> 
> Travis responded:
> 
> | We run on both AMDs (Durons and Athlons) as well as PII, PIII, and
> | PIV's. Our kernels are all compiled as generic 586+. Though when we were

And you saw it on all of them?  (in particular both on PII and on PIV?)

I actually doubt the problem happens on a context switch - the kernel
just uses FXSAVE/FNSAVE for this and this is extremly hard to get wrong.
Either you have no FPU state saved at all or you have all, since the
CPU handles it completely in microcode.

Most likely candidate would be signal context saving. When a signal happens 
and the process used floating point then the i386 kernel converts
the internal FXSAVE/FNSAVE image to another image derived from 
iBCS on the signal stack (and then later back). If any problems
with subtle corruptions happen I would expect them in this process.

This would be more likely on SSE enabled CPUs though, on pre SSE
CPUs this code is much simpler.

Do you know which status bit gets corrupted exactly?

-Andi

