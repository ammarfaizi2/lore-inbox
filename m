Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUHFDqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUHFDqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 23:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266454AbUHFDqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 23:46:12 -0400
Received: from [203.178.140.15] ([203.178.140.15]:12554 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S266391AbUHFDqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 23:46:10 -0400
Date: Thu, 05 Aug 2004 20:46:37 -0700 (PDT)
Message-Id: <20040805.204637.107575718.yoshfuji@linux-ipv6.org>
To: ak@muc.de, davem@redhat.com
Cc: jgarzik@pobox.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: block layer sg, bsg
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040805114917.GC31944@muc.de>
References: <20040804232116.GA30152@muc.de>
	<20040804.165113.06226042.yoshfuji@linux-ipv6.org>
	<20040805114917.GC31944@muc.de>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040805114917.GC31944@muc.de> (at 5 Aug 2004 13:49:17 +0200,Thu, 5 Aug 2004 13:49:17 +0200), Andi Kleen <ak@muc.de> says:

> > > Well, 32bit ipsec on x86-64/ia64 is a NOP because of that.
> > 
> > Hmm, I don't get the point.
> > What part (or which structore) is broken?
> 
> xfrm_usersa_info due to inclusion of xfrm_lifetime_cfg/xfrm_lifetime_cur
> The xfrm layer uses it like an array, but they have different sizes
> on x86-64 and i386.

Thanks for clarifications, David and Andi.
Okay, I now recognize that the difference of layouts, one on 32bit mode 
and one on 64bit mode is the problem.

I'd suggest changing XFRM_MSG_xxx things to 64bit-aware structures,
whose layouts do not change between 64bit mode and 32bit mode.
Of course, they will come with backward compatibility stuff.
If you don't mind this, I'd like to take care of this.

Thanks.

--yoshfuji
