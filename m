Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbVHLTCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVHLTCG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVHLTCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:02:06 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:37781 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751230AbVHLTCF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:02:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j9Y4zaH3tuqvsKq8UlqKui8vqA6OzVdpJf2viXg2FEJ5YkeZyyq8X+V5wa2Dync3BjgKiUhbbo1qqCFATHLhKfePYuV8JrSvvpzevpuJP9VwU+1AO3MD+ALGb7oV7PgoM4T7DnAMHLp/OiEoEyy0WGQyKb2qmAR9bgZzDmyM4Tg=
Message-ID: <56a8daef0508121202172bcd17@mail.gmail.com>
Date: Fri, 12 Aug 2005 12:02:03 -0700
From: John Ronciak <john.ronciak@gmail.com>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 3/8] netpoll: e1000 netpoll tweak
Cc: Andrew Morton <akpm@osdl.com>, "David S. Miller" <davem@davemloft.net>,
       ak@suse.de, Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
In-Reply-To: <4.502409567@selenic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3.502409567@selenic.com> <4.502409567@selenic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry this reply was to go to the whole list but only made it to Matt.

The e1000_intr() routine already calls e1000_clean_tx_irq().  So
what's the point of this patch?  Am I missing something?

On 8/11/05, Matt Mackall <mpm@selenic.com> wrote:
> Suggested by Steven Rostedt, matches his patch included in e100.
> 
> Signed-off-by: Matt Mackall <mpm@selenic.com>
> 
> Index: l/drivers/net/e1000/e1000_main.c
> ===================================================================
> --- l.orig/drivers/net/e1000/e1000_main.c       2005-08-06 17:36:32.000000000 -0500
> +++ l/drivers/net/e1000/e1000_main.c    2005-08-06 17:55:01.000000000 -0500
> @@ -3789,6 +3789,7 @@ e1000_netpoll(struct net_device *netdev)
>         struct e1000_adapter *adapter = netdev_priv(netdev);
>         disable_irq(adapter->pdev->irq);
>         e1000_intr(adapter->pdev->irq, netdev, NULL);
> +       e1000_clean_tx_irq(adapter);
>         enable_irq(adapter->pdev->irq);
>  }
>  #endif
> 
> 


-- 
Cheers,
John
