Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753245AbWKFPir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbWKFPir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 10:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbWKFPir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 10:38:47 -0500
Received: from mga03.intel.com ([143.182.124.21]:65463 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1753245AbWKFPiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 10:38:46 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,392,1157353200"; 
   d="scan'208"; a="141902544:sNHT21098406"
Message-ID: <454F5703.7040209@intel.com>
Date: Mon, 06 Nov 2006 07:38:43 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       stable@vger.kernel.org, rjw@sisk.pl, bunk@stusta.de, akpm@osdl.org,
       laurent.riffard@free.fr, rajesh.shah@intel.com, toralf.foerster@gmx.de,
       pavel@ucw.cz, jesse.brandeburg@intel.com,
       "Ronciak, John" <john.ronciak@intel.com>,
       "John W. Linville" <linville@tuxdriver.com>, nhorman@redhat.com,
       cluebot@fedorafaq.org, notting@redhat.com, bruce.w.allan@intel.com,
       davej@redhat.com, linville@redhat.com, wtogami@redhat.com,
       dag@wieers.com, error27@gmail.com,
       e1000-list <e1000-devel@lists.sourceforge.net>
Subject: Re: [PATCH] e1000: Fix regression: garbled stats and irq allocation
 during swsusp
References: <454B9BED.306@intel.com> <454EEA84.4060805@garzik.org>
In-Reply-To: <454EEA84.4060805@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2006 15:38:44.0213 (UTC) FILETIME=[A466DA50:01C701B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Auke Kok wrote:
>>
>> e1000: Fix regression: garbled stats and irq allocation during swsusp
>>
>> After 7.0.33/2.6.16, e1000 suspend/resume left the user with an enabled
>> device showing garbled statistics and undetermined irq allocation state,
>> where `ifconfig eth0 down` would display `trying to free already freed 
>> irq`.
>>
>> Explicitly free and allocate irq as well as powerup the PHY during resume
>> fixes.
>>
>> Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
> 
> ACK, but:
> 
> Applying 'e1000: Fix regression: garbled stats and irq allocation during 
> swsusp'
> 
> fatal: corrupt patch at line 8


There's another problem with it, that needs attention as well. I will reformat and 
re-post the patch to everyone.

Cheers,

Auke


From: <chrisw@sous-sol.org>
Also, would this cause a problem if I ifdown the interface to call
->close then suspend?  Looks like it'd free_irq twice, maybe need a
netif_running() check?
