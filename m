Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030647AbWBQQba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030647AbWBQQba (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030648AbWBQQba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:31:30 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:55850 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030647AbWBQQb3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:31:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n1RAIgUPujhphACIyxRgfPgi7nqvk7rvsF7ffUZBP9LWc9GvpWXvGTqsh82mooLcmdSswVyXPywmMz+ug/LXF1sc74ckDPqsyD2QzbrLauQ2cXZf1nuLGXI2vo0KW6+Yn/UZZkNrkoPXFTXZv5cJf1BoeJF2aw+6Vj/NjgfXI64=
Message-ID: <cde01ae70602170831h43668a5ay3a3e4f0ce446c241@mail.gmail.com>
Date: Fri, 17 Feb 2006 17:31:27 +0100
From: Lz <elezeta@gmail.com>
To: "Adam Belay" <ambx1@neo.rr.com>, Lz <elezeta@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Problems with sound on latest kernels.
In-Reply-To: <20060217061701.GA17208@neo.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cde01ae70602140558g6440af40mf59e3e1992088d3b@mail.gmail.com>
	 <1139934640.11659.95.camel@mindpipe>
	 <20060214232222.1016fe87.akpm@osdl.org>
	 <cde01ae70602150542m1b57aa83l62508927276241b@mail.gmail.com>
	 <20060217061701.GA17208@neo.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, it seems to be fixed at the latests git-.

Do you still need me to try that patch?

On 2/17/06, Adam Belay <ambx1@neo.rr.com> wrote:
> On Wed, Feb 15, 2006 at 02:42:05PM +0100, Lz wrote:
> > On 2/15/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > Poor guy - that's rocket science.  It looks like it's due to breakage in
> > > the pnp code anwyay.
> >
> > Yeah, it seemed that to me, alsa wasn't even loaded at that time.
>
> This patch may solve your problem.  Could you send a new dmesg output with it
> applied?
>
> Thanks,
> Adam
>
> --- a/drivers/pnp/card.c        2006-01-02 22:21:10.000000000 -0500
> +++ b/drivers/pnp/card.c        2006-02-17 00:45:37.123525896 -0500
> @@ -302,13 +302,11 @@
>         down_write(&dev->dev.bus->subsys.rwsem);
>         dev->card_link = clink;
>         dev->dev.driver = &drv->link.driver;
> -       if (drv->link.driver.probe) {
> -               if (drv->link.driver.probe(&dev->dev)) {
> -                       dev->dev.driver = NULL;
> -                       dev->card_link = NULL;
> -                       up_write(&dev->dev.bus->subsys.rwsem);
> -                       return NULL;
> -               }
> +       if (pnp_bus_type.probe(&dev->dev)) {
> +               dev->dev.driver = NULL;
> +               dev->card_link = NULL;
> +               up_write(&dev->dev.bus->subsys.rwsem);
> +               return NULL;
>         }
>         device_bind_driver(&dev->dev);
>         up_write(&dev->dev.bus->subsys.rwsem);
>


--
Lz (elezeta@gmail.com).
http://elezeta.bounceme.net
