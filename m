Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264993AbUE2Oo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264993AbUE2Oo0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 10:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264962AbUE2OoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 10:44:25 -0400
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:59128 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S265042AbUE2Onz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 10:43:55 -0400
Date: Sat, 29 May 2004 16:42:56 +0200
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: linux-kernel@vger.kernel.org
Cc: Henrik Persson <nix@syndicalist.net>,
       Sebastian <sebastian@expires0604.datenknoten.de>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: Strange DMA-errors and system hang with Promise 20268
Message-ID: <20040529144256.GA399@darkside.22.kls.lan>
Mail-Followup-To: Mario 'BitKoenig' Holbe <Mario.Holbe@RZ.TU-Ilmenau.DE>,
	linux-kernel@vger.kernel.org, Henrik Persson <nix@syndicalist.net>,
	Sebastian <sebastian@expires0604.datenknoten.de>,
	Bruce Allen <ballen@gravity.phys.uwm.edu>
References: <1078602426.16591.8.camel@vega> <c2dsha$psd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2dsha$psd$1@sea.gmane.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 07, 2004 at 02:05:46AM +0100, Mario 'BitKoenig' Holbe wrote:
> Mar  4 01:01:06 darkside kernel: hde: dma_timer_expiry: dma status == 0x21

hmmm, it seems I solved the issue in my case.

I did just connect the two disks on the Promise to a second separate
power supply and everything works rock-stable and survives all things
that went wrong before (parallel fsck, parallel hdparm -t as well as
'normal operation' over days).
Things remain stable even with the WDC disk connected back to the
Promise, which was heavy unstable before.

Moreover, when I connect the disks back to the machines internal power
supply, the problems arise again - immediately.

IMHO, this does also explain, why the problems happen while heavy I/O
(parallel over all disks) and/or while S.M.A.R.T selftests are running
(also: parallel over all disks).

Well, I thought, a 300W power supply would be enough for 1GHz P-III
and 4 disks. And it definitely was enough for a long time.

Most likely, the power supply just aged and its capacity decreased.

Perhaps, the disks consume more power with newer kernels, but while
crawling the lkm archives I found similar reports also for 2.4.19.

I have no idea, why always the disks connected to the Promise
controller did fail. Perhaps, the Promise is more sensitive regarding
signal quality on the IDE wire.

I have no idea, why my WDC disk failed when connected to the Promise,
while others did work far more stable. Perhaps, the WDC disks signal
quality under low-power is more bad than the one of other disks.

I have no idea, why the WDC disk did work well when it was connected
to the onboard controller. Perhaps, the lower signal quality of the
WDC (if so) and the sensitivity of the Promise (if so) added together
was too much at all.


Henrik, Sebastian: if you still have problems, this is probably
something to test for you.

Sebastian: if you experience more instability after exchanging your
drive with a newer (bigger? faster?) one, your chance is high to get
it solved with a bigger power supply, I'd guess :)

Bruce: this is probably something to hint for at the smartmontools
warning page.


regards,
   Mario
-- 
It is practically impossible to teach good programming style to students
that have had prior exposure to BASIC: as potential programmers they are
mentally mutilated beyond hope of regeneration.  -- Dijkstra
