Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946699AbWKAIPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946699AbWKAIPT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 03:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946700AbWKAIPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 03:15:19 -0500
Received: from moci.net4u.de ([217.7.64.195]:44936 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S1946696AbWKAIPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 03:15:17 -0500
From: Ernst Herzberg <earny@net4u.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc[1-4]: boot fail with (lapic && on_battery)
Date: Wed, 1 Nov 2006 09:14:56 +0100
User-Agent: KMail/1.9.1
Cc: Adrian Bunk <bunk@stusta.de>, mingo@redhat.com
References: <200610312227.54617.list-lkml@net4u.de> <200611010305.33990.earny@net4u.de> <20061101023450.GD27968@stusta.de>
In-Reply-To: <20061101023450.GD27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611010914.57545.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 November 2006 03:34, Adrian Bunk wrote:
> On Wed, Nov 01, 2006 at 03:05:33AM +0100, Ernst Herzberg wrote:
> > On Wednesday 01 November 2006 02:04, Adrian Bunk wrote:
> > > @Ingo:
> > > Any ideas?
> > >
> > >
> > > @Ernst:
> > > Thanks for your report.
> > > What model is your laptop?
> >
> > It's a Thinkpad R50p
>
> Does anyone own a Thinkpad 2.6.19-rc did not break?  ;-)
>
> We have a (most likely unrelated) problem after resume reported by
> owners of three different Thinkpad models.
>
> > > Unless someone is able to spot the problem from your bug report, please
> > > do the following process of git bisecting for finding what broke it:
> > > ....
> > > After at about 12 reboots, ...
> >
> > Will try, if i get a little spare time ;-)
>
> Thanks a lot!

halso:~/bisect/linux-2.6 # git bisect good
1fbbac4bcb03033d325c71fc7273aa0b9c1d9a03 is first bad commit
commit 1fbbac4bcb03033d325c71fc7273aa0b9c1d9a03
Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
Date:   Sat Sep 16 21:09:41 2006 +0100

    [SERIAL] serial_cs: convert multi-port table to quirk table

    - rename multi_id table to serial_quirk / quirks[]
    - use named initialisers
    - store a pointer to the quirk table in the serial_info structure
      so we can use the quirk table entry later.
    - apply multi-port quirk after the multi-port guessing code,
      but only if it's != -1.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

:040000 040000 0e673263987d236da67e6668100335f3223626ea 
6a32d673832850311983f072189fbaa09855f875 M      drivers


(if there is no time, don't sleep:)

First feeling: unrelatet. But if i compile 2.6.19-rc4 without cardbus support, 
the laptop boots on_battery and with lapic!

Need first a little sleep....

Thanks

<earny>

PS: _EXACT_ 12 kernels :-)
