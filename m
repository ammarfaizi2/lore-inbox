Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVCBVHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVCBVHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVCBVHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:07:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51621 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262508AbVCBVHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:07:41 -0500
Message-ID: <42262B08.2040401@pobox.com>
Date: Wed, 02 Mar 2005 16:07:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: bunk@stusta.de, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.11-rc4-mm1 patch] fix buggy IEEE80211_CRYPT_* selects
References: <20050223014233.6710fd73.akpm@osdl.org>	<20050226113123.GJ3311@stusta.de>	<42256078.1040002@pobox.com>	<20050302140833.GD4608@stusta.de>	<42261004.4000501@pobox.com> <20050302123829.51dbc44b.akpm@osdl.org>
In-Reply-To: <20050302123829.51dbc44b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Adrian Bunk wrote:
>>
>>>On Wed, Mar 02, 2005 at 01:43:04AM -0500, Jeff Garzik wrote:
>>>
>>>
>>>>Adrian Bunk wrote:
>>>>
>>>>
>>>>>+	select CRYPTO
>>>>>	select CRYPTO_AES
>>>>>	---help---
>>>>>	Include software based cipher suites in support of IEEE 802.11i 
>>>>>	(aka TGi, WPA, WPA2, WPA-PSK, etc.) for use with CCMP enabled 
>>>>>	networks.
>>>>>@@ -54,10 +55,11 @@
>>>>>	"ieee80211_crypt_ccmp".
>>>>>
>>>>>config IEEE80211_CRYPT_TKIP
>>>>>	tristate "IEEE 802.11i TKIP encryption"
>>>>>	depends on IEEE80211
>>>>>+	select CRYPTO
>>>>>	select CRYPTO_MICHAEL_MIC
>>>>
>>>>
>>>>'select CRYPTO_AES' should 'select CRYPTO' automatically, I would hope.
>>>
>>>
>>>This would result in a recursive dependency.
>>
>>No, it wouldn't.  CRYPTO_AES depends on CRYPTO, which depends on nothing.
>>
> 
> 
> Thing is, CRYPTO_AES on only selectable on x86.

You're thinking about CRYPTO_AES_586.  But looking at crypto/Kconfig, 
the dependencies are a bit weird:

config CRYPTO_AES
         tristate "AES cipher algorithms"
         depends on CRYPTO && !(X86 && !X86_64)
config CRYPTO_AES_586
         tristate "AES cipher algorithms (i586)"
         depends on CRYPTO && (X86 && !X86_64)

