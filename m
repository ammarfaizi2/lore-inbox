Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVCBUmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVCBUmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 15:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVCBUmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 15:42:15 -0500
Received: from fire.osdl.org ([65.172.181.4]:24472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262477AbVCBUmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 15:42:08 -0500
Date: Wed, 2 Mar 2005 12:38:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: bunk@stusta.de, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.11-rc4-mm1 patch] fix buggy IEEE80211_CRYPT_* selects
Message-Id: <20050302123829.51dbc44b.akpm@osdl.org>
In-Reply-To: <42261004.4000501@pobox.com>
References: <20050223014233.6710fd73.akpm@osdl.org>
	<20050226113123.GJ3311@stusta.de>
	<42256078.1040002@pobox.com>
	<20050302140833.GD4608@stusta.de>
	<42261004.4000501@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Adrian Bunk wrote:
> > On Wed, Mar 02, 2005 at 01:43:04AM -0500, Jeff Garzik wrote:
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
> > This would result in a recursive dependency.
> 
> No, it wouldn't.  CRYPTO_AES depends on CRYPTO, which depends on nothing.
> 

Thing is, CRYPTO_AES on only selectable on x86.

So really, IEEE80211_CRYPT_CCMP should depend upon CRYPTO_AES rather than
selecting it.  But that confuses users.
