Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWBENqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWBENqP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 08:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWBENqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 08:46:15 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:56708 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750806AbWBENqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 08:46:14 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43E600BC.10408@s5r6.in-berlin.de>
Date: Sun, 05 Feb 2006 14:42:20 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [RFC 3/4] firewire: unconditionally export	hpsb_send_packet_and_wait
References: <1138919238.3621.12.camel@localhost> <1138920077.3621.22.camel@localhost>
In-Reply-To: <1138920077.3621.22.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.661) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg wrote:
> mem1394 will need hpsb_send_packet_and_wait so it needs to be exported
> unconditionally.
> 
> diff --git a/drivers/ieee1394/ieee1394_core.c b/drivers/ieee1394/ieee1394_core.c
> index 17afc3b..5800534 100644
> --- a/drivers/ieee1394/ieee1394_core.c
> +++ b/drivers/ieee1394/ieee1394_core.c
> @@ -589,6 +589,7 @@ int hpsb_send_packet_and_wait(struct hps
>  
>  	return retval;
>  }
> +EXPORT_SYMBOL(hpsb_send_packet_and_wait);
>  
>  static void send_packet_nocare(struct hpsb_packet *packet)
>  {
> @@ -1269,7 +1270,6 @@ EXPORT_SYMBOL(hpsb_packet_received);
>  EXPORT_SYMBOL_GPL(hpsb_disable_irm);
>  #ifdef CONFIG_IEEE1394_EXPORT_FULL_API
>  EXPORT_SYMBOL(hpsb_send_phy_config);
> -EXPORT_SYMBOL(hpsb_send_packet_and_wait);
>  #endif
>  
>  /** ieee1394_transactions.c **/

Leave the export down at the end of ieee1394_core.c among all other 
exports of ieee1394. Just move the export above the #ifdef.

Same for the two new exports by "[RFC 2/4] firewire: dynamic cdev 
allocation below firewire major": Place them at the end of ieee1394_core.c.
-- 
Stefan Richter
-=====-=-==- --=- --=-=
http://arcgraph.de/sr/
