Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263682AbUDOSw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUDOSwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:52:49 -0400
Received: from mail1.kontent.de ([81.88.34.36]:17856 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263142AbUDOSu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:50:58 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Colin Leroy <colin@colino.net>, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.6.6-rc1: cdc-acm still (differently) broken
Date: Thu, 15 Apr 2004 20:50:53 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net
References: <20040415201117.11524f63@jack.colino.net>
In-Reply-To: <20040415201117.11524f63@jack.colino.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404152050.53251.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 15. April 2004 20:11 schrieb Colin Leroy:
> Hi,
>
> cdc-acm was broken since after 2.6.4, due to the alt_cursetting changes. I
> sent a patch, which has been integrated (well, the same one has ;-)) not
> long ago. I gave 2.6.6-rc1 a try, and found that cdc-acm is now broken is a
> new way: when plugging the phone, acm_probe() fails on interface #0; I
> traced the problem to this: usb_interface_claimed() returns true - and in
> fact intf->dev.driver is already cdc-acm (despite the fact that this is the
> first call to acm_probe() !), for reasons beyond my comprehension.
>
> But, even if the interface is claimed, the intfdata hasn't been set, which
> allows to do another check: the attached patch fixes this bug.

But somebody else may have claimed the interface. You can't simply
assume that only cdc-acm will take the device.

	Regards
		Oliver

