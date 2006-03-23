Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbWCWRER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbWCWRER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbWCWREQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:04:16 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:63177 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932661AbWCWREO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:04:14 -0500
Date: Thu, 23 Mar 2006 18:04:13 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Con Kolivas <kernel@kolivas.org>, john stultz <johnstul@us.ibm.com>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PM-Timer: doesn't use workaround if chipset is not buggy
Message-ID: <20060323170413.GA20234@rhlx01.fht-esslingen.de>
References: <20060320122449.GA29718@outpost.ds9a.nl> <1142968999.4281.4.camel@leatherman> <8764m7xzqg.fsf@duaron.myhome.or.jp> <200603221121.16168.kernel@kolivas.org> <87hd5qmi1d.fsf_-_@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hd5qmi1d.fsf_-_@duaron.myhome.or.jp>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 23, 2006 at 03:49:18AM +0900, OGAWA Hirofumi wrote:
> This patch adds blacklist of buggy chip, and if chip is not buggy,
> this uses fast normal version instead of slow workaround version.

Nice!
Testing on ICH5 (P4HT) hasn't shown any problems so far.

> If chip is buggy, warnings "pmtmr is slow". But sounds like there is
> gray zone. I found the PIIX4 errata, but I couldn't find the ICH4
> errata.  But some motherboard seems to have problem.

Same here, the ICH4 trace is nowhere to be found.

Should I do a public request for chipset testing?
(I wrote a small test app here that would hopefully identify a buggy
chipset).

Data that I have collected from internet snippets (mostly Intel errata
documents):
Affected (PCI ID / rev):
  - ICH4???
  - PIIX4 A0 (0x7113 / 00?), A1 (0x7113 / 00?), B0 (0x7113 / 01?)
  - PIIX4E A0 (0x7113 / 02?)
Probably fixed (PCI ID / rev):
  - PIIX4M A0 (0x7113 / 03?)

My Toshiba Satellite 4280 seems to have non-buggy PIIX4M
(since it's PCI rev. 03), haven't had time to test reliability yet, though.

> So, if found a ICH4, also warnings, and uses a workaround version.  If
> user's ICH4 is good actually, user can specify the "pmtmr_good" boot
> parameter to use fast version.

Good, that's how it should be done as long as it's not entirely known which
chipsets (both Intel and possibly also non-Intel!) are buggy.

Also, I think that since triple-reading wastes 3% of system time, it would
be very nice to be able to eventually write a software workaround for buggy
systems, too.
This could perhaps be done by keeping the *old* value in a global yet
thread-safe variable and checking whether the new value is safely related
to it if within short jiffies distance (but since jiffies are probably
calculated from pmtmr readings... :-P).

Andreas Mohr
