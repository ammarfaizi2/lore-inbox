Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbUBXVrf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbUBXVrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:47:35 -0500
Received: from gyge.telenet-ops.be ([195.130.132.48]:42712 "EHLO
	gyge.telenet-ops.be") by vger.kernel.org with ESMTP id S262323AbUBXVrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:47:24 -0500
From: Bart De Schuymer <bdschuym@pandora.be>
To: "Simon Barber" <simon@instant802.com>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Subject: Re: Problem with ebtables target that changes frame protocol
Date: Tue, 24 Feb 2004 22:47:20 +0100
User-Agent: KMail/1.5
References: <AC8C1F46CD753F4AAC8F890E35A9EB461C66EB@webmail.instant802.com>
In-Reply-To: <AC8C1F46CD753F4AAC8F890E35A9EB461C66EB@webmail.instant802.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402242247.20875.bdschuym@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 February 2004 23:41, Simon Barber wrote:
> I have written an ebtables target that changes the ethernet protocol of
> a received frame (it runs in the broute chain). I have been working on
> 2.4.21 sources - Unfortunately inside netif_rx the skb->protocol is
> looked at before the bridge code is called - and then acted upon after.
> Hence if the bridge code changes the protocol the incorrect protocol is
> used to process the frame.

As the variable type is only used after the bridge code, I think it is best to 
postpone the initialization of type until after the bridge code. This is of 
course of no concern to the standard 2.4 kernel (as ebtables isn't in 2.4). 
This problem exists in the 2.6 kernel, however.
I'll make a fix for 2.6 later, unless someone beats me to it. I'm kind of busy 
at the moment.

cheers,
Bart

