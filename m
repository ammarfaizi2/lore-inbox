Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVHHGJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVHHGJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 02:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbVHHGJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 02:09:11 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:2913 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750733AbVHHGJK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 02:09:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qborlv8D6DoSFhF+sulOSXGGHiGfncLasEyf5UIcdc8FUourhMsBr9pjCqQqTkSRx+TB8qDVLNusa1reAoutAZ27wqUybzRrREdR2qG2DaZvnkO/1yo/D0Om2cLuj1lqCkpMnc/6l4RxjdF6vL61imqZuGGFB5MCwJMMj4E/keQ=
Message-ID: <17db6d3a05080723096ec26531@mail.gmail.com>
Date: Mon, 8 Aug 2005 11:39:07 +0530
From: Nikhil Dharashivkar <nikhildharashivkar@gmail.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: [PATCH] remove warning about e1000_suspend
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <256850000.1123442258@10.10.2.4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <256850000.1123442258@10.10.2.4>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,
    But e1000_notify_reboot () function calls this e1000_suspend()
function irrespective of  CONFIG_FM is defined or not. So according to
your soution, what if CONFIG_FM is not defined.

On 8/8/05, Martin J. Bligh <mbligh@mbligh.org> wrote:
> e1000_suspend is only used under #ifdef CONFIG_PM. Move the declaration
> of it to be the same way, just like e1000_resume, otherwise gcc whines
> on compile. I offer as evidence:
> 
>         static struct pci_driver e1000_driver = {
>                .name     = e1000_driver_name,
>               .id_table = e1000_pci_tbl,
>               .probe    = e1000_probe,
>               .remove   = __devexit_p(e1000_remove),
>               /* Power Managment Hooks */
>         #ifdef CONFIG_PM
>                .suspend  = e1000_suspend,
>                .resume   = e1000_resume
>         #endif
>         };
> 
> 
> diff -aurpN -X /home/fletch/.diff.exclude virgin/drivers/net/e1000/e1000_main.c e1000_suspend/drivers/net/e1000/e1000_main.c
> --- virgin/drivers/net/e1000/e1000_main.c       2005-08-07 09:15:36.000000000 -0700
> +++ e1000_suspend/drivers/net/e1000/e1000_main.c        2005-08-07 12:10:42.000000000 -0700
> @@ -162,8 +162,8 @@ static void e1000_vlan_rx_add_vid(struct
>  static void e1000_vlan_rx_kill_vid(struct net_device *netdev, uint16_t vid);
>  static void e1000_restore_vlan(struct e1000_adapter *adapter);
> 
> -static int e1000_suspend(struct pci_dev *pdev, uint32_t state);
>  #ifdef CONFIG_PM
> +static int e1000_suspend(struct pci_dev *pdev, uint32_t state);
>  static int e1000_resume(struct pci_dev *pdev);
>  #endif
> 
> @@ -3641,6 +3641,7 @@ e1000_set_spd_dplx(struct e1000_adapter
>         return 0;
>  }
> 
> +#ifdef CONFIG_PM
>  static int
>  e1000_suspend(struct pci_dev *pdev, uint32_t state)
>  {
> @@ -3733,7 +3734,6 @@ e1000_suspend(struct pci_dev *pdev, uint
>         return 0;
>  }
> 
> -#ifdef CONFIG_PM
>  static int
>  e1000_resume(struct pci_dev *pdev)
>  {
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Thanks and Regards,
         Nikhil.
