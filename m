Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWF3Jvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWF3Jvo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 05:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWF3Jvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 05:51:44 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6556 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932243AbWF3Jvn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 05:51:43 -0400
Subject: Re: 2.6.17-mm4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave Jones <davej@redhat.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060629230517.GA18838@elte.hu>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	 <6bffcb0e0606291339s69a16bc5ie108c0b8d4e29ed6@mail.gmail.com>
	 <20060629204330.GC13619@redhat.com> <20060629210950.GA300@elte.hu>
	 <20060629230517.GA18838@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Jun 2006 11:07:53 +0100
Message-Id: <1151662073.31392.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-30 am 01:05 +0200, ysgrifennodd Ingo Molnar:
> it does things like:
> 
>         static const unsigned long qd_port[2] = { 0x30, 0xB0 };
>         static const unsigned long ide_port[2] = { 0x170, 0x1F0 };
> 
>         [...]
>                 unsigned long port = qd_port[i];
>         [...]
>                         r = inb_p(port);
>                         outb_p(0x19, port);
>                         res = inb_p(port);
>                         outb_p(r, port);
> 
> so it reads/writes port 0x30 and 0xb0. Are those used by something else 
> on modern hardware?

Not especially. Perhaps the best thing to do here would be to make qdi
compiled into the kernel (as opposed to modular) only do so if
"probe_qdi=1" or similar is set.

Will sort that out if nobody beats me to it.

Alan

