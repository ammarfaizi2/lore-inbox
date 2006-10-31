Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946153AbWJaXPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946153AbWJaXPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 18:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946156AbWJaXPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 18:15:07 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:45965 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1946153AbWJaXPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 18:15:03 -0500
Date: Wed, 1 Nov 2006 00:05:38 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tmattox@gmail.com, spiky.kiwi@gmail.com, r.bhatia@ipax.at,
       Darren Salt <linux@youmustbejoking.demon.co.uk>,
       Syed Azam <syed.azam@hp.com>,
       Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)
Message-ID: <20061031230538.GA4329@electric-eye.fr.zoreil.com>
References: <20061029223410.GA15413@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610300032190.1435@poirot.grange> <20061030120158.GA28123@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610302148560.9723@poirot.grange> <Pine.LNX.4.60.0610302214350.9723@poirot.grange> <20061030234425.GB6038@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610312000160.5223@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0610312000160.5223@poirot.grange>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> :
[...]
> Well, with that one I booted 3 times, all 3 times it worked. I'll leave it 

Thanks.

Let's cross fingers.

> in to see if it ever fails. So, what does it tell us about the 
> set_mac_address thing?

It tells nothing more about the set_mac_address thing. If people need 
MAC address change support, I can surely hack something and keep a
patch for future reference. Imho it is anything but 2.6.19 material
though.

The patch that I sent to you on 2006/10/29 was enough to fix the link
detection issues experienced with the 0x8136 chipset (1. Darren Salt
on netdev {25/26/31}/08/2006 and {21/22}/10/2006, 2. Syed Azam on BZ,
see http://bugzilla.kernel.org/show_bug.cgi?id=7378).

Your computer was good at spotting issues with the MAC address stuff,
so it was the perfect candidate to test pending fixes for different
problems. As you noticed, it was not exactly safe to feed the MII
control register with some potentially uninitialized stuff, whence
the patch from yesterday.

It remains to be seen if:
- it still does the job for the 0x8136 
- it does not induce new regressions in existing 8169

o Darren and Syed, are your 0x8136 still happy with the patch
  0001-r8169-perform-a-PHY-reset-before-any-other-operation-at-boot-time.txt
  at http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.19-rc4/r8169
  on top of 2.6.19-rc4 ?

o Darren, still ok to keep your S-o-b in it ?

o Could the r8169 users out there check that the same patch does not add
  new regressions to their favorite 2.6.19-rc4 ?

o Lennert, can you apply the two patches
  - 0001-r8169-perform-a-PHY-reset-before-any-other-operation-at-boot-time.txt
  - 0002-r8169-more-magic.txt
  at http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.19-rc4/r8169 against
  2.6.19-rc4 (2.6.19-rc4 reverted the MAC address changes) and see if the
  n2100 board still needs to remove the SYSErr handler ?

-- 
Ueimor
