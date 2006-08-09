Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWHIQA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWHIQA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWHIQA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:00:28 -0400
Received: from aun.it.uu.se ([130.238.12.36]:26297 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751041AbWHIQA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:00:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17626.1619.653854.241578@alkaid.it.uu.se>
Date: Wed, 9 Aug 2006 17:59:15 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: albertl@mail.com
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, alan@redhat.com,
       Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@enoyolf.org>
Subject: Re: libata pata_pdc2027x success on sparc64
In-Reply-To: <44C841B5.40806@tw.ibm.com>
References: <200607172358.k6HNwYhF002052@harpo.it.uu.se>
	<44BD2370.8090506@ru.mvista.com>
	<44C841B5.40806@tw.ibm.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Lee writes:
 > Sergei Shtylyov wrote:
 > > Hello.
 > > 
 > > Mikael Pettersson wrote:
 > > 
 > >> In contrast, the old IDE pdc202xx_new driver had lots
 > >> of problems with CRC errors causing it to disable DMA.
 > > 
 > > 
 > >    Hm, from my experience it usually falls back to UltraDMA/44 and then
 > > the thing startrt working...
 > > 
 > >> I wasn't able to manually tune it above udma3 without
 > >> getting more errors. This isn't sparc64-specific: I've
 > >> had similar negative experience with the old IDE Promise
 > >> drivers in a PowerMac.
 > > 
 > > 
 > >    This happens because the "old" driver misses the PLL calibration code.
 > >    You may want to try these Albert's patches:
 > > 
 > > http://marc.theaimsgroup.com/?t=110992452800002&r=1&w=2
 > > http://marc.theaimsgroup.com/?t=110992471500002&r=1&w=2
 > > http://marc.theaimsgroup.com/?t=110992490100002&r=1&w=2
 > > http://marc.theaimsgroup.com/?t=111019238400003&r=1&w=2
 > > 
 > >    It looks like they were never considered for accepting into the kernel
 > > while they succesfully solve this issue. Maybe Albert could try pushing
 > > them into -mm tree once more?
 > > 
 > 
 > Hi,
 > 
 > The libata version has three improvements compared to the IDE version.
 > 
 > 1. The PLL calibration patches in the above URLs (for IDE)
 > still need more improvement as done in the pdc_read_counter()
 > of the libata version.
 > 
 > 2. The Promise 2027x adapters check the "set features - xfer mode"
 >    and set the timing register automatically. However, the automatically
 >    set values are not correct under 133MHz. Libata has a hook
 >    pdc2027x_post_set_mode() to set the values back by software.
 > 
 > 3. ATAPI DMA is supported (please see pdc2027x_check_atapi_dma()).
 >    Maybe we also need to add this to the IDE version.

Do you know how large the difference is between the 20267 (old driver)
and the 20269 (new driver) in the areas touched by these patches?
Long ago I tried a 20267 PCI card in my PowerMac, and it had the same
issues that the 20269 card had. So I'm interested in porting the
calibration/timing fixes to pdc202xx_old.c.

/Mikael
