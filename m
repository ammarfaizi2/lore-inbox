Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVGBLgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVGBLgg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 07:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVGBLgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 07:36:36 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:23424 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261171AbVGBLgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 07:36:00 -0400
Date: Sat, 2 Jul 2005 13:33:11 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Cc: Juha Laiho <Juha.Laiho@iki.fi>, Andrew Hutchings <info@a-wing.co.uk>,
       linux-kernel@vger.kernel.org, vinay kumar <b4uvin@yahoo.co.in>,
       jgarzik@pobox.com
Subject: Re: sis190
Message-ID: <20050702113311.GA12832@electric-eye.fr.zoreil.com>
References: <22391136.1120301527301.JavaMail.www@wwinf1518>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22391136.1120301527301.JavaMail.www@wwinf1518>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal CHAPPERON <pascal.chapperon@wanadoo.fr> :
[...]
> A few lines diff, and now the driver is very stable with or
> without preempted kernel...
>
> I'll be very happy if you can tell me where is the trick.

Probably:
- when it filled the last Tx descriptor sis190_start_xmit()
  issued a netif_stop_queue and returned NETDEV_TX_BUSY;
- the asic completed DMAing the packet and acked it;
- sis190_tx_interrupt later released the descriptor and freed the skb;

-> since NETDEV_TX_BUSY assumes that the driver does not play with the skb,
   one gets interesting results.

[...]
> I tried it carefully : console, X11 (without nvidia), X11 (with nvidia),
> IRQ sharing between sis190/nvidia, full load : it worked perfectly.

Megateuf Wayne !

[...]
> BTW, can you remove the following printks from the patch ?
> The printks in interrupt functions make dmesg unusuable,
> and the stuff in sis190_get_drvinfo triggers a kernel oops
> when the module is loaded (null pointer assignment).

I'll polish the thing and sprinkle a few netif_msg_xxx() later today.

--
Ueimor
