Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbTJWJbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 05:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbTJWJbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 05:31:04 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:13453 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263517AbTJWJa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 05:30:59 -0400
Message-ID: <3F97A009.1C12F466@nospam.org>
Date: Thu, 23 Oct 2003 11:31:53 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
References: <200310171610.36569.bjorn.helgaas@hp.com> <20031017155028.2e98b307.akpm@osdl.org> <20031019181756.GP1659@openzaurus.ucw.cz> <20031023083316.GB5272@sourcefrog.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some machines may require special memory zones, e.g. for ia64
architectures you need to keep the "minimal state save" area
for the Processor Abstraction Layer in un-cached memory.
If you read the memory "in the usual way" then you access the
memory through the HW caches.
The ia64 architecture forbids to have both cached and un-cached
access to the same memory location (by any of the CPUs, DMAs),
otherwise you create a cache paradox => machine check.
Think twice before even trying a "dd if=/dev/mem"...

Zoltan Menyhart
