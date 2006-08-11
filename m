Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWHKGwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWHKGwG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWHKGwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:52:05 -0400
Received: from ns2.suse.de ([195.135.220.15]:2770 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932334AbWHKGwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:52:04 -0400
From: Andi Kleen <ak@suse.de>
To: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH for review] [13/145] x86_64: Add abilty to enable/disable nmi watchdog with sysctl
Date: Fri, 11 Aug 2006 08:44:32 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060810 935.775038000@suse.de> <20060810193525.B5A4813B90@wotan.suse.de> <44DB8D72.9040800@flower.upol.cz>
In-Reply-To: <44DB8D72.9040800@flower.upol.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608110844.32032.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Files 'nmi.c' from both archs don't match, obviously. But lets see, how.

nmi.c for x86-64 only aims to support new hardware and is thus a somewhat
cleaner version of the i386 version. Also there are some differences how
it interfaces with the rest of the port.


> -+	if (nmi_watchdog == NMI_DEFAULT) {
> -+		if (nmi_known_cpu() > 0)
> -+			nmi_watchdog = NMI_LOCAL_APIC;
> -+		else
> -+			nmi_watchdog = NMI_IO_APIC;
> -+	}
> ++	/* if nmi_watchdog is not set yet, then set it */
> ++	nmi_watchdog_default();
> 
> i don't know about nmi, but please drop a word why this is different in both files;

They've involving independently and not all changes are added to both.
In this case it was a x86-64 specific cleanup.

> Maybe this must be one file for both archs ?

No.

-Andi
