Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUFCCi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUFCCi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 22:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265463AbUFCCi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 22:38:29 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:31055 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S265462AbUFCCiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 22:38:18 -0400
Subject: Re: Prism54 WPA Support - wpa_supplicant - Linux general wpa
	support
From: Pedro Ramalhais <ramalhais@serrado.net>
To: Jouni Malinen <jkmaline@cc.hut.fi>
Cc: Netdev <netdev@oss.sgi.com>, hostap@shmoo.com, prism54-devel@prism54.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040603014000.GA7548@jm.kir.nu>
References: <20040602071449.GJ10723@ruslug.rutgers.edu>
	 <20040602132313.GB7341@jm.kir.nu>
	 <20040602155542.GC24822@ruslug.rutgers.edu>
	 <20040603014000.GA7548@jm.kir.nu>
Content-Type: text/plain
Message-Id: <1086230284.7604.38.camel@rootix>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 03 Jun 2004 03:38:05 +0100
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2004 02:38:15.0871 (UTC) FILETIME=[D28A6CF0:01C44913]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pre-Scriptum: Please excuse me for cross posting and/or if this mail is
not relevant for the recipient mailing list/people.

Hi Jouni (and other interest wireless driver developers)!
As you may know (or not), the ipw2100 driver is somewhat based on hostap
code. We use some code from hostap in the ipw2100 driver, and use the
hostap driver externally as a way to provide WEP.
I'm currently working on turning hostap_crypt* into ieee80211_crypt* in
such a way that could be used in a generic way by all drivers that need
host based WEP (and TKIP/CCMP). I basically renamed the hostap_crypt* to
ieee80211_crypt* and search&replaced hostap with ieee80211. Also made
hostap_crypt.c into a module (instead of having to rely on hostap.o).
I have WEP working and a Makefile that can be used in the kernel or
externally. I took a look at the TKIP and CCMP source files and it is
somewhat tied up to ioctls and headers (just took a quick look correct
me if i'm wrong) from hostap. This makes it somewhat difficult to turn
them into code that compiles without hostap code.
Besides this, the ipw2100 code also has an attempt at a somewhat generic
ieee80211 interface for drivers. ieee80211_rx.c is mostly based on
hostap_hw.c code (which looks like is now in CVS as hostap_80211_rx.c )
and there's also ieee80211_tx.c which i think was created from scratch
by James Ketrenos (ipw2100 main developer @intel).
My question is: would it be interesting to try and merge code from
hostap, ipw2100 and possibly other drivers to try to create generic code
for 80211 and 80211_crypt? How much interest is there on the part of the
developers (hostap, prism54, atmel, etc...). I'm asking this because
AFAICS, the hostap driver always had an history of more focus on new
features, functionality, bug fixes, than "standard" APIs, etc... and i
completely understand that and thank god it has been like this because
the final result was a really nice driver.
Would you accept patches at least for now to make hostap_crypt* into
ieee80211_crypt*?
Sorry, i have so many questions and ideas, that i cannot express myself
very well =:-).
This is getting lengthy, so, hope you got the idea at least of some of
my questions/ideas/worries, etc....
Thank you!

PS: Comments, ideas, proposals, etc are welcome for discussion.(What is
the best way to discuss this matter? There's a large number of
developers involved. Maybe netdev?)

On Thu, 2004-06-03 at 02:40, Jouni Malinen wrote:
> On Wed, Jun 02, 2004 at 11:55:42AM -0400, Luis R. Rodriguez wrote:
> 
> > If you find the patches that'd be great :). I'll see what I can do about
> > fixing up extended MLME. I'll keep you posted. 
> 
> I now know where the wpa_supplicant part is and once I find the matching
> patch for Prism54 driver, I'll send them both to you.
> 
> > I have yet to review most of the wpa_supplicant code so I cannot say for
> > sure yet what I think should go into the kernel. I e-mailed most lists
> > mainly to get comments from others who have poked at wpa_supplicant
> > and/or are looking into adding WPA client support into their drivers.
> > I just wanted to make sure we were heading in the right direction since
> > I only see 2 drivers that are currently using wpa_supplicant.
> 
> You may have seen only two drivers, but actually I'm already aware of at
> least seven drivers that work with wpa_supplicant.. All of these are not
> yet available publicly, though.
> 
> I believe that the current design for wpa_supplicant is quite alright
> for most cases. I would like to give some more thought for the roaming
> part (i.e., consider giving more control for the driver), but this
> should be doable in a backward compatible way without breaking support
> with existing code.
-- 
Pedro Ramalhais <ramalhais@serrado.net>

