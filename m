Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWGVEM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWGVEM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 00:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWGVEM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 00:12:29 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:46866 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751291AbWGVEM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 00:12:28 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/6] cpuid neatening.
Date: Fri, 21 Jul 2006 21:12:07 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOENJNEAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1153527194.13699.34.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 21 Jul 2006 21:07:18 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 21 Jul 2006 21:07:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
> +			   unsigned int *ecx, unsigned int *edx)
> +{
> +	/* ecx is often an input as well as an output. */
> +	__asm__("cpuid"
> +		: "=a" (*eax),
> +		  "=b" (*ebx),
> +		  "=c" (*ecx),
> +		  "=d" (*edx)
> +		: "0" (*eax), "2" (*ecx));
> +}
> +

	Shouldn't that be:

__asm__("cpuid"
: "+a" (*eax),
  "=b" (*ebx),
  "+c" (*ecx),
  "=d" (*edx)
);

	DS


