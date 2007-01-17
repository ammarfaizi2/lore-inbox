Return-Path: <linux-kernel-owner+w=401wt.eu-S1751966AbXAQAYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbXAQAYP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 19:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbXAQAYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 19:24:15 -0500
Received: from bill.weihenstephan.org ([82.135.35.21]:58797 "EHLO
	bill.weihenstephan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbXAQAYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 19:24:14 -0500
From: Juergen Beisert <juergen127@kreuzholzen.de>
Organization: Privat
To: linux-kernel@vger.kernel.org
Subject: Re: fix typo in geode_configre()@cyrix.c
Date: Wed, 17 Jan 2007 01:24:11 +0100
User-Agent: KMail/1.9.4
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       takada <takada@mbf.nifty.com>
References: <20070109.184156.260789378.takada@mbf.nifty.com> <20070109173348.GF17269@csclub.uwaterloo.ca>
In-Reply-To: <20070109173348.GF17269@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701170124.11928.juergen127@kreuzholzen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 January 2007 18:33, Lennart Sorensen wrote:
> Then for the next one it does:
> ccr3 = GetCx86(CX86_CCR3);
> setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);
>
> Couldn't that have been:
> setCx86(CX86_CCR3, (getCx86(CX86_CCR3) & 0x0f) | 0x10);
>
> No temp variable, and again it clearly does not intend to restore the
> value again later (even though the bug actually did cause the value to
> be restored by accident).

No, ccr3 should be restored to protect some registers (or at least bit 4 
should be cleared in ccr3).

BTW:
In function set_cx86_inc()
[...]
	/* PCR1 -- Performance Control */
	/* Incrementor on, whatever that is */
	setCx86(CX86_PCR1, getCx86(CX86_PCR1) | 0x02);
	/* PCR0 -- Performance Control */
	/* Incrementor Margin 10 */
	setCx86(CX86_PCR0, getCx86(CX86_PCR0) | 0x04);
[...]

This setting is only valid for 200MHz...266MHz CPUs, for 300MHz and 333MHz 
CPUs the Incrementor Margin should be 1-1.

There is an AppNote about this setting:
AMD Geode GX1 Processor Memory Timings for Maximum Performance.

Juergen
