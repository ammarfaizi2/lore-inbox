Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWCCK3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWCCK3S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 05:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWCCK3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 05:29:17 -0500
Received: from mx03.kontent.de ([81.88.34.122]:36028 "EHLO MX03.KONTENT.De")
	by vger.kernel.org with ESMTP id S1751184AbWCCK3R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 05:29:17 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: Re: MAX_USBFS_BUFFER_SIZE
Date: Fri, 3 Mar 2006 11:29:00 +0100
User-Agent: KMail/1.8
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.de>,
       linux-kernel@vger.kernel.org
References: <200603012116.25869.rene@exactcode.de> <20060302130519.588b18a2.zaitcev@redhat.com> <200603030912.11622.duncan.sands@math.u-psud.fr>
In-Reply-To: <200603030912.11622.duncan.sands@math.u-psud.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603031129.00619.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 3. März 2006 09:12 schrieb Duncan Sands:
> > Have you ever considered how many TDs have to be allocated to transfer
> > a data buffer this big? No, seriously. If your application cannot deliver
> > the tranfer speeds with 16KB URBs, we ought to consider if the combination
> > of our USB stack, usbfs, libusb and the application ought to get serious
> > performance enhancing surgery. The problem is obviously in the software
> > overhead.
> 
> If you queue a large number of 16KB urbs, rather than one jumbo urb,
> does that make any difference to the number of TDs allocated?  I thought
> TDs were allocated for all queued urbs at the moment they are queued...

It changes the time the TDs are allocated. TDs allocated while an URB is
in flight don't hurt bandwidth. If your throughput is low because there
is too much delay between URBs, allocating many TDs makes matters worse.

	Regards
		Oliver
