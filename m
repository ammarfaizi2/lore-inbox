Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbULPBVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbULPBVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbULPBTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:19:51 -0500
Received: from gprs215-43.eurotel.cz ([160.218.215.43]:42370 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262594AbULPA6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:58:39 -0500
Date: Thu, 16 Dec 2004 01:58:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: USB making time drift [was Re: dynamic-hz]
Message-ID: <20041216005814.GA6285@elf.ucw.cz>
References: <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <20041214023651.GT16322@dualathlon.random> <20041214095939.GC1063@elf.ucw.cz> <20041214152558.GB16322@dualathlon.random> <20041214220239.GA19221@elf.ucw.cz> <20041214231649.GR16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214231649.GR16322@dualathlon.random>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > How much drift do you see?
> 
> huge drift, minutes per hour or similar.

Okay, for your amusement, here's the evil
"do-few-msec-interrupt-latency" program.

Andrea, could you verify that it causes clock to drift for you? I'll
leave it running here overnight, and will see what happens.

								Pavel
void
main(void)
{
        int i;
        iopl(3);
        while (1) {
                asm volatile("cli");
                for (i=0; i<20000000; i++)
                        asm volatile("");
                asm volatile("sti");
                sleep(1);
        }
}


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
