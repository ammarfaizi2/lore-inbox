Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272851AbTHKRBZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272840AbTHKQ7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:59:08 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:18630 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S272738AbTHKQ5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:57:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16183.51974.508883.472043@gargle.gargle.HOWL>
Date: Mon, 11 Aug 2003 18:57:42 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: torvalds@transmeta.com, fxkuehl@gmx.de, linux-kernel@vger.kernel.org,
       willy@w.ods.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] Disable APIC on reboot.
In-Reply-To: <20030811163834.GA21568@redhat.com>
References: <E19mCuO-0003dI-00@tetrachloride>
	<16183.50273.723650.136532@gargle.gargle.HOWL>
	<20030811163834.GA21568@redhat.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes:
 > On Mon, Aug 11, 2003 at 06:29:21PM +0200, Mikael Pettersson wrote:
 >  > I agree we should probably disable the local APIC at reboot if we
 >  > enabled it previously, but this patch is broken. CONFIG_X86_LOCAL_APIC
 >  > doesn't imply that the CPU actually has one, and even if it does, the
 >  > access method may be different (e.g. P5 vs P6/K7/P4, and who knows how
 >  > the future C3 with local APIC will do it).
 > 
 > Ok. The original poster mentioned that disable_local_apic() didn't
 > do the right thing there, hence the duplication, so making that DTRT
 > may make sense ?

I'd have to check what callers expect from disable_local_APIC(), but
having it or a new function do a complete disable seems reasonable.

detect_init_APIC() needs to record whether it did a hard enable via
APIC_BASE or not, and the complete-disable code needs to check this
before accessing APIC_BASE. That + a cpu_has_apic check should do it.

I'll do a patch this evening if no-one else beats me to it.

/Mikael
