Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWEDFJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWEDFJv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 01:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWEDFJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 01:09:51 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:28603 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1751091AbWEDFJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 01:09:51 -0400
Date: Wed, 3 May 2006 22:09:50 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpufreq oddness on 2.6.16-rc1-mm4
Message-ID: <20060504050950.GR11943@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501135927.261d4c53.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 01:59:27PM -0700, Andrew Morton wrote:
> Andy Isaacson <adi@hexapodia.org> wrote:
> > On Sun, Jan 29, 2006 at 02:45:33PM -0800, Andrew Morton wrote:
> > >  git-cpufreq.patch
> > 
> > I haven't had time to debug it further, but cpufreq seems broken on my
> > Thinkpad X40 with 2.6.16-rc1-mm4.  It was working fine with
> > 2.6.15-rc5-mm3.  Automatic scaling doesn't function any more - my
> > PentiumM 1.4 GHz is fixed at 598 MHz.  And the relevant knobs in
> > /sys/devices/system/cpu/cpu0 seem to be missing.  Admittedly, I don't
>
> If this bug is still present in 2.6.17-rc3, could you please raise a report
> at bugzilla.kernel.org so we can track it?

It turned out to be a configuration issue (as expected).  My routine of
"cp ../`uname -r`/.config .config; make oldconfig" did not do the right
thing when doing that upgrade - I ended up with

# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y

which resulted in speedstep being disabled with no obvious clues what to
do to turn it on.  After some poking, I'm now running 2.6.17-rc1-mm3
with

CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y

and everything is working fine.

-andy
