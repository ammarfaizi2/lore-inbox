Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268502AbUHYGKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268502AbUHYGKj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 02:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268397AbUHYGKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 02:10:39 -0400
Received: from smtp9.wanadoo.fr ([193.252.22.22]:56615 "EHLO
	mwinf0906.wanadoo.fr") by vger.kernel.org with ESMTP
	id S268502AbUHYGIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 02:08:46 -0400
Date: Wed, 25 Aug 2004 08:12:48 +0200
From: Philippe Elie <phil.el@wanadoo.fr>
To: Zarakin <zarakin@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nmi_watchdog=2 - Oops with 2.6.8
Message-ID: <20040825061248.GB556@zaniah>
References: <021101c48a44$c8f846e0$6401a8c0@novustelecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021101c48a44$c8f846e0$6401a8c0@novustelecom.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 at 18:42 +0000, Zarakin wrote:

> Hi,
> 
> My Gentoo machine will not boot with nmi_watchdog=2 parameter - I get an
> oops at clear_msr_range.
> 
> Handwritten oops Info:
> CPU 0
> EIP:  0060: [<0xc0110d4b>] Not tainted
> EIP is at clear_msr_range+0x18/0x25
> eax: 0  ebx:1f  ecx: 3ba  edx: 0
> esi: 3a0  edi: 1a  ebp:0 esp: d7d83f74
> ds: 7b es: 7b ss: 68
> 
> Dump of assembler code for function clear_msr_range:
> 0xc0110d33 <clear_msr_range+0>: push   %edi
> 0xc0110d34 <clear_msr_range+1>: xor    %edi,%edi
> 0xc0110d36 <clear_msr_range+3>: push   %esi
> 0xc0110d37 <clear_msr_range+4>: push   %ebx
> 0xc0110d38 <clear_msr_range+5>: mov    0x14(%esp,1),%ebx
> 0xc0110d3c <clear_msr_range+9>: mov    0x10(%esp,1),%esi
> 0xc0110d40 <clear_msr_range+13>:        cmp    %ebx,%edi
> 0xc0110d42 <clear_msr_range+15>:        jae    0xc0110d54
> 0xc0110d44 <clear_msr_range+17>:        xor    %eax,%eax
> 0xc0110d46 <clear_msr_range+19>:        lea    (%edi,%esi,1),%ecx
> 0xc0110d49 <clear_msr_range+22>:        mov    %eax,%edx
> 0xc0110d4b <clear_msr_range+24>:        wrmsr

Intel removed MSR 0x3ba/0x3bb (MSR_IQ_ESCR0 and 1) in prescott processor
(family 15 model 3). I'm going to sleep, if nobody beat me I'll try to
provide a patch, see nmi.c:setup_p4_watchdog() --> clear_msr_range(0x3A0, 31);

This probably break oprofile too, patch will be a bit less obvious

regards,
phe
