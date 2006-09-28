Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWI1Umd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWI1Umd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWI1Umc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:42:32 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:23225 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1750784AbWI1Uma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:42:30 -0400
Date: Thu, 28 Sep 2006 22:42:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, mj@atrey.karlin.mff.cuni.cz,
       davej@redhat.com
Subject: Re: [PATCH] x86: update vmlinux.lds.S to place .data section on a page boundary
Message-ID: <20060928204220.GA31096@uranus.ravnborg.org>
References: <20060928201249.GA10037@hmsreliant.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928201249.GA10037@hmsreliant.homelinux.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 04:12:49PM -0400, Neil Horman wrote:
> Patch to update vmlinux linker script so that .data section is on a page
> boundary.  without this change the kernel's .data section is on a non-4k
> boundary, and this prevents kexec from loading a new kernel.  Tested
> successfully by me.
NAK

> +  . = ALIGN(4096);

Do not use magic numbers like this.
Please replace 4096 with PAGE_SIZE - page.h is already included so it is
available.
This servers two purposes:
1) This make it more self documenting
2) It makes it more portable should we decide to do this in a general
way for all arch's.

And then maybe a comment why it is desireable to waste a lot of RAM
in some cases. For the embedded people wasting up to 4088 bytes
of RAM is not desireable.


	Sam
