Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWACXD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWACXD3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWACXD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:03:29 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:10573 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751495AbWACXD2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:03:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DsuC82WhfK3iqCiE7OmhNZiPC0RbID4CdKKRhiTnPRNbSVmqRcght5Nynt5w1Lzd/KG8GZ+jQoCfyNnjZYlbORwc0HqAfmzhDz46mlereC4FCRUzTMBBKXHHOeavJCKEGW5PndPMkrT6LdK/jAXfzeD8rfoRI/s1W0OeAx3ZCdQ=
Message-ID: <6ec4247d0601031503k2232c472o@mail.gmail.com>
Date: Wed, 4 Jan 2006 09:33:27 +1030
From: Graham Gower <graham.gower@gmail.com>
To: Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH] [TRIVIAL] prism54/islpci_eth.c: dev_kfree_skb in irq context
Cc: Roger While <simrw@sim-basis.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <43BA7810.6010308@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6.1.1.1.2.20060103105620.02c523e0@192.168.6.12>
	 <6ec4247d0601030419w377fd396x@mail.gmail.com>
	 <43BA7810.6010308@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/06, Patrick McHardy <kaber@trash.net> wrote:
> Graham Gower wrote:
> > My logs were starting to fill with messages exatcly like that mentioned here:
> > http://patchwork.netfilter.org/netfilter-devel/patch.pl?id=2840
> >
> > In any event, the patch at the end of that link was never applied (it doesn't
> > fix the other call to dev_kfree_skb). After applying my patch, I've not had any
> > more messages in the logs.
>
> The patch has been applied to 2.6.15-rc. Only the first hunk of your
> patch is still required, but it doesn't apply anymore. Can you send
> a new patch against 2.6.15 please?
>

Ok, here's a new one. Hope I got it right this time.

Signed-off-by: Graham Gower <graham.gower@gmail.com>

--- linux-2.6.15/drivers/net/wireless/prism54/islpci_eth.c.orig
+++ linux-2.6.15/drivers/net/wireless/prism54/islpci_eth.c
@@ -177,7 +177,7 @@
 #endif

 			newskb->dev = skb->dev;
-			dev_kfree_skb(skb);
+			dev_kfree_skb_irq(skb);
 			skb = newskb;
 		}
 	}
