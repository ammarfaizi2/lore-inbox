Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280462AbRKNLD6>; Wed, 14 Nov 2001 06:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280457AbRKNLDt>; Wed, 14 Nov 2001 06:03:49 -0500
Received: from [217.6.75.131] ([217.6.75.131]:60121 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S280450AbRKNLDf>; Wed, 14 Nov 2001 06:03:35 -0500
Message-ID: <3BF251C6.23CD1243@internetwork-ag.de>
Date: Wed, 14 Nov 2001 12:13:10 +0100
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Organization: interNetwork AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, paulus@samba.org, linux-ppp@vger.kernel.org
Subject: Re: [PATCH] ppp_generic causes skput:under: w/ pppoatm andvc-encaps
In-Reply-To: <3BF190F0.3FB26BD0@internetwork-ag.de> <20011113.210221.55509229.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:

>    From: Till Immanuel Patzschke <tip@internetwork-ag.de>
>    Date: Tue, 13 Nov 2001 22:30:24 +0100
>
>    I've attached a patch, checking for headroom first, and - if necessary -
>    reallocating a larger buffer for the skb_push.
>
>    Please check and apply - or find a better fix!
>
> Here is my "better fix". In pppoatm, we should be increasing the
> device header length appropriately.  ie. dev->hard_header_len needs to
> be increased in the pppoatm driver when vc-encaps is used.

that is - of course - a more pppoatm specific fix BUT my concern ist that
PPP requires (!) to have at least 2 bytes headroom [when using PPP_FILTER]
(which is NOT noted), and isn't it good practice to check for room before
claiming it?


--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de



