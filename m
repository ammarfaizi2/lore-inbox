Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTHZQFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbTHZQFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:05:10 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:39581 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262763AbTHZQFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:05:04 -0400
Subject: Re: Doubt: core not dumped when binary give up root privileges.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexandre Pereira Nunes <alex@PolesApart.wox.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F466E2A.8040905@PolesApart.wox.org>
References: <3F466E2A.8040905@PolesApart.wox.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061913848.20910.55.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 26 Aug 2003 17:04:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-22 at 20:25, Alexandre Pereira Nunes wrote:
> The program explicitly sets RLIMIT_CORE to RLIM_INFINITY when still 
> running with uid 0.

The kernel assumes a core image from something that was priviledged may
be unsafe.

> If instead of calling the program as root, I call it from the non-priv 
> uid in question, if it crashes, it dumps core on the mentioned dir. 
> That's the desired behaviour, since I can then take the core and debug. 
> But if I run it as root (in fact, I would have to), and it crashes (or 
> is forced to ,by means of kill -SEGV), after it gives up root 
> credentials, it won't leave a core dump file, which in turn means I 
> cannot debug it later.
> 
> Any ideas?

2.4-ac has support for enabling setuid core dumps and setting the dump
path, so you can write such dumps to /root/dumps and the kernel will
make them root accessible only.

The 2.6 test tree and Marcelo 2.4 don't currently support this

