Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVCBWJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVCBWJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVCBWH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:07:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43785 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262461AbVCBV7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:59:05 -0500
Date: Wed, 2 Mar 2005 22:59:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>, jmorris@redhat.com, davem@davemloft.net
Cc: Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.11-rc4-mm1 patch] fix buggy IEEE80211_CRYPT_* selects
Message-ID: <20050302215903.GG4608@stusta.de>
References: <20050223014233.6710fd73.akpm@osdl.org> <20050226113123.GJ3311@stusta.de> <42256078.1040002@pobox.com> <20050302140833.GD4608@stusta.de> <42261004.4000501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42261004.4000501@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 02:12:04PM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >On Wed, Mar 02, 2005 at 01:43:04AM -0500, Jeff Garzik wrote:
> >
> >>Adrian Bunk wrote:
> >>
> >>>+	select CRYPTO
> >>>	select CRYPTO_AES
> >>>	---help---
> >>>	Include software based cipher suites in support of IEEE 802.11i 
> >>>	(aka TGi, WPA, WPA2, WPA-PSK, etc.) for use with CCMP enabled 
> >>>	networks.
> >>>@@ -54,10 +55,11 @@
> >>>	"ieee80211_crypt_ccmp".
> >>>
> >>>config IEEE80211_CRYPT_TKIP
> >>>	tristate "IEEE 802.11i TKIP encryption"
> >>>	depends on IEEE80211
> >>>+	select CRYPTO
> >>>	select CRYPTO_MICHAEL_MIC
> >>
> >>
> >>'select CRYPTO_AES' should 'select CRYPTO' automatically, I would hope.
> >
> >
> >This would result in a recursive dependency.
> 
> No, it wouldn't.  CRYPTO_AES depends on CRYPTO, which depends on nothing.

Exactly.

And if CRYPTO_AES would select CRYPTO, you'd have a recursive 
dependency.

The only possible thing would be to change all dependencies on CRYPTO to 
selects. This wouldn't be unlogical since the whole crypto subsystem is 
only a helper for other subsystems.

James, any opinions on this issue?

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

