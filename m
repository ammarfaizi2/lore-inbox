Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUG1VgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUG1VgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbUG1VgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:36:05 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:2760 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S264658AbUG1VgB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:36:01 -0400
Date: Wed, 28 Jul 2004 17:35:57 -0400
To: Bill Huey <bhuey@lnxw.com>
Cc: Ingo Molnar <mingo@elte.hu>, Scott Wood <scott@timesys.com>,
       linux-kernel@vger.kernel.org,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>
Subject: Re: [patch] IRQ threads
Message-ID: <20040728213557.GD6685@yoda.timesys>
References: <20040727225040.GA4370@yoda.timesys> <20040728062722.GA15283@elte.hu> <20040728212314.GB7167@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728212314.GB7167@nietzsche.lynx.com>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 02:23:14PM -0700, Bill Huey wrote:
> That way I picture the problem permits those threads to migration across
> CPUs and therefore kill interrupt performance from cache thrashing. Do
> you have a solution for that ? I like the way you're doing it now with
> irqd() in that it's CPU-local, but as you know it's not priority sensitive.

Wouldn't the IRQ threads be subject to the same heuristics that the
scheduler uses with ordinary threads, in order to avoid unnecessary
CPU migration?  Plus, IRQs ordinarily get distributed across CPUs,
and in most cases shouldn't have a very large cache footprint
(especially data; the code can be in multiple CPU caches at once), so
I don't think this is a susbtantial degradation from the way things
already are.

If desired by the user, an IRQ thread could be bound to a specific
CPU to avoid such problems (in which case, they'd probably want to
set the smp_affinity of the hard IRQ stub to the same CPU).

-Scott
