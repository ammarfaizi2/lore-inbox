Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVCYS4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVCYS4k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVCYS4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:56:39 -0500
Received: from natpreptil.rzone.de ([81.169.145.163]:48312 "EHLO
	natpreptil.rzone.de") by vger.kernel.org with ESMTP id S261175AbVCYS4g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:56:36 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.12-rc1 breaks dosemu
Date: Fri, 25 Mar 2005 19:52:31 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, linux-msdos@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
References: <20050320021141.GA4449@stusta.de>
In-Reply-To: <20050320021141.GA4449@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503251952.33558.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünndag 20 März 2005 03:11, Adrian Bunk wrote:
> xdosemu 1.2.2 runs fine under 2.6.11.5, but fails under 2.6.12-rc1 with 
> the following error:
> 
> <--  snip  -->
> 
> $ xdosemu 
> ERROR: cpu exception in dosemu code outside of VM86()!
> trapno: 0x0e  errorcode: 0x00000005  cr2: 0xffffff8e
> eip: 0x000069ee  esp: 0xbfdbffcc  eflags: 0x00010246
> cs: 0x0073  ds: 0x007b  es: 0x007b  ss: 0x007b
> Page fault: read instruction to linear address: 0xffffff8e
> CPU was in user mode
> Exception was caused by insufficient privilege

I had the same problem and found out that disabling
address space randomization (echo 0 > 
/proc/sys/kernel/randomize_va_space) solves this
reliably. With randomization enabled, I can start up
dosemu maybe 1 out of 100 times.

I guess the randomization patches changed the mapping
in a way that dosemu did not expect.

 Arnd <><
