Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUJEWPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUJEWPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUJEWPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:15:49 -0400
Received: from zero.aec.at ([193.170.194.10]:11535 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266115AbUJEWPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:15:39 -0400
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: question about MTRR areas on x86_64
References: <2M5w2-y8-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 06 Oct 2004 00:15:35 +0200
In-Reply-To: <2M5w2-y8-3@gated-at.bofh.it> (Markus Lidel's message of "Wed,
 06 Oct 2004 00:00:22 +0200")
Message-ID: <m3vfdox14o.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Lidel <Markus.Lidel@shadowconnect.com> writes:
>
> Could it be because the machine has too much memory, or is there a bug in the I2O driver?

The problem comes from the BIOS who set up reg00 to be overlapping
over other areas. The Linux MTRR driver cannot deal with overlapping
MTRRs, in fact it is sometimes impossible because it could run
out of registers or violate some of the MTRR restrictions.

It's a long standing problem, eventual fix will be to get rid
of MTRRs completely and only use PAT. But it needs a bit more work.

-Andi

