Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbWCNRhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWCNRhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWCNRhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:37:36 -0500
Received: from xenotime.net ([66.160.160.81]:54959 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751567AbWCNRhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:37:35 -0500
Date: Tue, 14 Mar 2006 09:39:20 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-kernel@vger.kernel.org, marcel@holtmann.org, maxk@qualcomm.com,
       bluez-devel@lists.sourceforge.net
Subject: Re: [PATCH] Fix SCO on Broadcom Bluetooth adapters
Message-Id: <20060314093920.d3b5cf13.rdunlap@xenotime.net>
In-Reply-To: <20060314111248.GA75477@dspnet.fr.eu.org>
References: <20060314111248.GA75477@dspnet.fr.eu.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006 12:12:48 +0100 Olivier Galibert wrote:

> Broadcom USB Bluetooth adapters report a maximum of zero SCO packets
> in-flight, killing SCO.  Use a reasonable count instead in that case.
> 
> Signed-off-by: Olivier Galibert <galibert@pobox.com>
> 
> ---
> 
> I don't think that could be reasonably done as a quirk.  Simple
> examination of the .inf coming with the windows driver shows that 100+
> different models may be having this problem.  Also, it can't break
> already working adapters, so why bother.
> 
>  net/bluetooth/hci_event.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
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

missing trailing ';'

---
~Randy
