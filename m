Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbTELMtd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 08:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTELMtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 08:49:33 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:28737 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261399AbTELMtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 08:49:32 -0400
Date: Mon, 12 May 2003 06:02:10 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MPPE in kernel?
Message-ID: <20030512060210.C29881@google.com>
References: <20030512045929.C29781@google.com> <16063.38221.73659.403481@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16063.38221.73659.403481@argo.ozlabs.ibm.com>; from paulus@samba.org on Mon, May 12, 2003 at 10:36:29PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 10:36:29PM +1000, Paul Mackerras wrote:
> Frank Cusack writes:
> 
> > What are the chances of getting MPPE (PPP encryption) into the 2.4.21
> > and/or 2.5.x kernels?
> 
> First, are there any patent issues that you are aware of?

There are none for MPPE.  It's just MPPC that has patent problems.

> The fundamental problem is that MPPE is misusing CCP (compression
> control protocol) for something for which it was never intended.  The
> specific place where this is a problem is that the compression code in
> ppp_generic doesn't guarantee that it will never send a packet out
> uncompressed, but MPPE requires that.  How do you get around that
> problem?

I have the compressor return a 3-valued return code (<0, 0, >0) instead of
two-valued (>0, other).  A negative value tells ppp_generic to drop the
packet.  0 means the same as it does now--the compressor failed for some
reason.  (All current compressors always return 0 or >0, so the negative
return is compatible.)

0 could also mean that CCP isn't up yet, but pppd userland doesn't allow
NCP's to come up until CCP completes (iff trying to negotiate MPPE).

Note that ECP would have this same problem, it's addressed the same way.

/fc
