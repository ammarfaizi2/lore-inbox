Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVLMGsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVLMGsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 01:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVLMGsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 01:48:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60575 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932387AbVLMGsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 01:48:18 -0500
Date: Tue, 13 Dec 2005 01:48:00 -0500
From: Dave Jones <davej@redhat.com>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add mem_nmi_panic enable system to panic on hard error
Message-ID: <20051213064800.GB7401@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <439E6C58.6050301@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439E6C58.6050301@jp.fujitsu.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 03:38:16PM +0900, Hidetoshi Seto wrote:
 > Some x86 server fires NMI with reason 0x80 up if a parity error
 > occurs on its PCI-bus system or DIMM module.

Hmm, are you sure this isn't a bios error misconfiguring
some northbridge register perhaps ?  Some chipsets offer
such reporting as a feature. Could be your server has this
on by default.

(I believe the EDAC code has also triggered similar cases
 on certain cards which is why it too disables this checking
 by default).

 > However, such NMI cannot stop the system and data pollution,
 > because the NMI is _not_ "unknown", through unknown_nmi_panic
 > can panic the system on NMI which has no reason bits.
 > 
 > This patch adds "mem_nmi_panic" sysctl parameter that enable
 > system to switch its action on such NMI originated in a hard error.
 > Also it seems that x86_86 has same situation and problem,
 > so this is a couple of patch for 2 archs, i386 and x86_64.

Why not make this automatic based on dmi strings, instead of
making the user guess that he needs to pass obscure command
line options?

The sysctl seems pointless too. If this is needed at all,
why would you ever want to turn it off ?

		Dave

