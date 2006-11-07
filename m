Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753762AbWKGBUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbWKGBUn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 20:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753850AbWKGBUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 20:20:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:34691 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1753762AbWKGBUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 20:20:42 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,393,1157353200"; 
   d="scan'208"; a="159048753:sNHT19273961"
Subject: Re: [patch] Regression in 2.6.19-rc microcode driver
From: Shaohua Li <shaohua.li@intel.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, bunk@stusta.de
In-Reply-To: <1162822538.3138.28.camel@laptopd505.fenrus.org>
References: <1162822538.3138.28.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 09:20:27 +0800
Message-Id: <1162862427.22565.4.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 15:15 +0100, Arjan van de Ven wrote:
> Hi,
> 
> if the microcode driver is built in (rather than module) there are some,
> ehm, interesting effects happening due to the new "call out to
> userspace" behavior that is introduced.. and which runs too early. The
> result is a boot hang; which is really nasty.
> 
> The patch below is a minimally safe patch to fix this regression for
> 2.6.19 by just not requesting actual microcode updates during early
> boot. (That is a good idea in general anyway)
> 
> The "real" fix is a lot more complex given the entire cpu hotplug
> scenario (during cpu hotplug you normally need to load the microcode as
> well); but the interactions for that are just really messy at this
> point; this fix at least makes it work and avoids a full detangle of
> hotplug.
Yes, this is an issue which I documented in my patch. It's not a hang,
but a long delay if you have many cpus. Other drivers with firmware
request have the same issue if they are built-in. Maybe we should fix
the firmware request mechanism itself. I hope no distribution has
microcode driver built-in.

Thanks,
Shaohua
