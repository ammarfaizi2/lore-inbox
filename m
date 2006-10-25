Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWJYW1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWJYW1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 18:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbWJYW1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 18:27:18 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:26192 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964826AbWJYW1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 18:27:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=xy8wfv6p/BNHeM1GluCa4TAoM3FMGs1C8+S7P0NXEsZdyS7MzSqT+Nm3Gn0YlGSBtMsFyD56JBd5Ke+Tkg4APdfceZReduJxoNeMsFMSCQLypIDlOC5iXSPsyoQuNzuqxU+zqxHe1/RRZGfjiFbxS8q2Ojw76AbjaTf+7w/249U=  ;
Date: Wed, 25 Oct 2006 15:27:09 -0700
From: David Brownell <david-b@pacbell.net>
To: toralf.foerster@gmx.de, randy.dunlap@oracle.com, netdev@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, link@miggy.org, greg@kroah.com,
       akpm@osdl.org
Subject: Re: [PATCH] !CONFIG_NET_ETHERNET unsets CONFIG_PHYLIB, but 
 CONFIG_USB_USBNET also needs CONFIG_PHYLIB
Cc: zippel@linux-m68k.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       dbrownell@users.sourceforge.net
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
 <20061025201341.GH21200@miggy.org>
 <20061025151737.1bf4898c.randy.dunlap@oracle.com>
In-Reply-To: <20061025151737.1bf4898c.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061025222709.A13681C5E0B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -94,6 +95,7 @@ config USB_RTL8150
>  
>  config USB_USBNET
>  	tristate "Multi-purpose USB Networking Framework"
> +	select MII
>  	---help---
>  	  This driver supports several kinds of network links over USB,
>  	  with "minidrivers" built around a common network driver core

The other parts are right, this isn't.

Instead, "usbnet.c" should #ifdef the relevant ethtool hooks
according to CONFIG_MII ... since it's completely legit to
use usbnet with peripherals that don't need MII.

