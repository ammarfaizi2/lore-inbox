Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWCNMNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWCNMNn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbWCNMNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:13:42 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29570 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751893AbWCNMNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:13:42 -0500
Date: Tue, 14 Mar 2006 13:12:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>,
       "Hack inc." <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
       maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: Re: [PATCH] Fix SCO on Broadcom Bluetooth adapters
Message-ID: <20060314121224.GA11211@elf.ucw.cz>
References: <20060314111248.GA75477@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060314111248.GA75477@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 14-03-06 12:12:48, Olivier Galibert wrote:
> Broadcom USB Bluetooth adapters report a maximum of zero SCO packets
> in-flight, killing SCO.  Use a reasonable count instead in that
> case.

Printk("broken Broadcom USB detected, working around"), I'd say. Then
you can also remove the comment :-). Maybe 4 is reasonable value for
some really broken thing, or something...
								
> Signed-off-by: Olivier Galibert <galibert@pobox.com>

								Pavel

> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -324,6 +324,13 @@ static void hci_cc_info_param(struct hci
>  		hdev->acl_pkts = hdev->acl_cnt = __le16_to_cpu(bs->acl_max_pkt);
>  		hdev->sco_pkts = hdev->sco_cnt = __le16_to_cpu(bs->sco_max_pkt);
>  
> +		/* Some buggy USB bluetooth adapters, Broadcom in
> +		   particular, answer zero as the max number of sco
> +		   packets in flight.  Use a reasonable value
> +		   instead */
> +		if (hdev->sco_pkts == 0)
> +			hdev->sco_pkts = hdev->sco_cnt = 8
> +
>  		BT_DBG("%s mtu: acl %d, sco %d max_pkt: acl %d, sco %d", hdev->name,
>  			hdev->acl_mtu, hdev->sco_mtu, hdev->acl_pkts, hdev->sco_pkts);
>  		break;


-- 
189:    private string AtomSTSZ = "stsz";
