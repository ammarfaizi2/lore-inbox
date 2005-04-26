Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVDZReu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVDZReu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVDZReb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:34:31 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:16883 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261734AbVDZReP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:34:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ihXh3umBudXGuu9cMrdW2Q1G02WgIif8+vA0SkxfH6FkOBYamBo+E7U/rMg4HYu1Sqis2iX8FscsWH//oBRPIqGDRF3cQpqmdTJ1EcecxN0WhPxSBK4Hqn9Tu2ypDiXxkrqyOHmdLwpQST4kOBSS5467GXYOrFYutDEoxPWMsiE=
Message-ID: <d120d50005042610342368cd72@mail.gmail.com>
Date: Tue, 26 Apr 2005 12:34:13 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number next.
Cc: netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <20050426203023.378e4831@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	 <d120d5000504260857cb5f99e@mail.gmail.com>
	 <20050426202437.234e7d45@zanzibar.2ka.mipt.ru>
	 <20050426203023.378e4831@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> --- orig/drivers/connector/connector.c
> +++ mod/drivers/connector/connector.c
> @@ -151,8 +151,8 @@
>                        __cbq->ddata = data;
>                        __cbq->destruct_data = destruct_data;
> 
> -                       queue_work(dev->cbdev->cn_queue, &__cbq->work);
> -                       found = 1;
> +                       if (queue_work(dev->cbdev->cn_queue, &__cbq->work))
> +                               found = 1;
>                        break;

What does it help exactly? By the time you checked result of
queue_work you have already corrupted work structure wuth the new data
(and probably destructor).

Also, where is the rest of the code? Should we notify caller that
cn_netlink_send has dropped the message? And how do we do that?

-- 
Dmitry
