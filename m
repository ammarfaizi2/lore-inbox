Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264483AbTE1DHC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 23:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264486AbTE1DHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 23:07:02 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:29571
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264483AbTE1DHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 23:07:01 -0400
Date: Tue, 27 May 2003 23:10:03 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Slack Ware <slack_ware@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Printing IDT on Linux 2.4.20
In-Reply-To: <20030528030639.38916.qmail@web13607.mail.yahoo.com>
Message-ID: <Pine.LNX.4.50.0305272306140.15323-100000@montezuma.mastecende.com>
References: <20030528030639.38916.qmail@web13607.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003, Slack Ware wrote:

> Hi everybody!
> I've a problem with the checkidt utility provided by
> Phrack Issue #59, I think.
> The checkidt utility is for 2.4.x kernels, supposedly,
> but I compiled it under 2.4.20 and it couldn't read
> /dev/kmem.
> Anyway, I would like to print the IDT on kernel 2.4.20
> with checkidt or not.
> Any suggestions are welcome.
> Regards,

*shrug* I don't know why they would want to check /dev/kmem just for the 
IDT.

#include <stdio.h>

struct dt {
        unsigned short limit;
        unsigned long address __attribute__((packed));
        unsigned short padding;
} __attribute__((packed));

int main()
{
        struct dt foo;

        __asm__ __volatile__ ("sidt %0":"=m"(foo));
        printf("limit=%d address=%lx\n", foo.limit, foo.address);
        return 0;
}

	Zwane
-- 
function.linuxpower.ca
