Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbTJCVIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 17:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbTJCVIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 17:08:17 -0400
Received: from ns.suse.de ([195.135.220.2]:34696 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261162AbTJCVIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 17:08:16 -0400
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: backport AMD K7 MCE changes.
References: <20031003205408.GA17829@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Oct 2003 23:08:12 +0200
In-Reply-To: <20031003205408.GA17829@redhat.com.suse.lists.linux.kernel>
Message-ID: <p73pthexc5f.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:
>  			 */
> -			if(c->x86 == 6 || c->x86 == 15)
> +			
> +			if(c->x86 == 6 || c->x86 == 15) {
> +				startbank = 1;

Can you please add comments to such magic changes ?

I still think we should not do anything without an official errata.

The K7 actually has two MCE enable registers: a mask that is only
supposed to be programmed by the BIOS and works around bugs and the
standardized IA32 register controlled by the OS. I suspect your case
only happens with some buggy BIOS that doesn't program the shadow mask
correctly. This would imply that it would make more sense to test it
and program it correctly based on a known good value.

-Andi
