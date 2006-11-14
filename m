Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966295AbWKNUsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966295AbWKNUsd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966345AbWKNUsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:48:33 -0500
Received: from mx27.mail.ru ([194.67.23.64]:63339 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S966295AbWKNUsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:48:32 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.19-rc5 regression: can't disable OHCI wakeup via sysfs
Date: Tue, 14 Nov 2006 23:48:29 +0300
User-Agent: KMail/1.9.5
Cc: David Brownell <david-b@pacbell.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0611131457050.2390-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0611131457050.2390-100000@iolanthe.rowland.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611142348.30082.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 13 November 2006 22:58, Alan Stern wrote:
> Andrey:
>
> Try this patch for 2.6.19-rc5.  Although it doesn't make all the changes
> Dave and I have discussed, it ought to fix your problem.
>

It did. Thank you

- -andrey

> Alan Stern
>
>
> Index: 2.6.19-rc5/drivers/usb/host/ohci-hub.c
> ===================================================================
> --- 2.6.19-rc5.orig/drivers/usb/host/ohci-hub.c
> +++ 2.6.19-rc5/drivers/usb/host/ohci-hub.c
> @@ -422,7 +422,8 @@ ohci_hub_status_data (struct usb_hcd *hc
>  				ohci->autostop = 0;
>  				ohci->next_statechange = jiffies +
>  						STATECHANGE_DELAY;
> -			} else if (time_after_eq (jiffies,
> +			} else if (device_may_wakeup(&hcd->self.root_hub->dev)
> +					&& time_after_eq(jiffies,
>  						ohci->next_statechange)
>  					&& !ohci->ed_rm_list
>  					&& !(ohci->hc_control &
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFWiueR6LMutpd94wRAu9JAKC/IXuGi+NvXx+O9zwDwaJI3AXqXQCfTF/I
jzkfD8gsU+JgYlqWkzQ2Pis=
=ckCE
-----END PGP SIGNATURE-----
