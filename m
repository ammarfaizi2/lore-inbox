Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVIXPHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVIXPHz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 11:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVIXPHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 11:07:54 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:14316 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932188AbVIXPHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 11:07:54 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: thomas.mey3r@arcor.de
Subject: Re: Aw: Re: 2.6.14-rc2-ge484585e: kexec into same kernel: irq 11 nobody cared; but ehci_hcd should
Date: Sat, 24 Sep 2005 18:07:11 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200509241530.42284.vda@ilport.com.ua> <32750612.1127563007089.JavaMail.ngmail@webmail-09.arcor-online.net> <23431147.1127571157771.JavaMail.ngmail@webmail-05.arcor-online.net>
In-Reply-To: <23431147.1127571157771.JavaMail.ngmail@webmail-05.arcor-online.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509241807.11479.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 September 2005 17:12, thomas.mey3r@arcor.de wrote:
> Correct.
> The interrupt happens before the interrupt is enabled by the ehci driver. the question is why is the interrupt already enabled? or: who forgot to disable the interrupt?

Correct question is "who forgot to set ehci->regs->intr_enable before request_irq'ing?"

IOW: writel (INTR_MASK, &ehci->regs->intr_enable); /* Turn On Interrupts */
needs to be moved so that it happens before request_irq. 
--
vda
