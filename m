Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUBKUEz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 15:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265700AbUBKUEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 15:04:55 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:64645 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261262AbUBKUEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 15:04:53 -0500
Date: Wed, 11 Feb 2004 21:04:51 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ping Cheng <pingc@wacom.com>
Cc: "'Pete Zaitcev'" <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Wacom USB driver patch
Message-ID: <20040211200451.GA14403@ucw.cz>
References: <28E6D16EC4CCD71196610060CF213AEB065BC2@wacom-nt2.wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28E6D16EC4CCD71196610060CF213AEB065BC2@wacom-nt2.wacom.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 11:47:19AM -0800, Ping Cheng wrote:
> Nice catch, Pete. The Two "return"s should be replaced by "goto exit". 
> 
> Vojtech, should I make another patch or you can handle it with my previous
> one?

It's okay, you don't need to make another patch.

> 
> Thanks, both of you!
> 
> Ping
> 
> -----Original Message-----
> From: Pete Zaitcev [mailto:zaitcev@redhat.com] 
> Sent: Wednesday, February 11, 2004 11:05 AM
> To: Ping Cheng
> Cc: linux-kernel@vger.kernel.org; vojtech@suse.cz
> Subject: Re: Wacom USB driver patch
> 
> 
> On Tue, 10 Feb 2004 17:23:11 -0800
> Ping Cheng <pingc@wacom.com> wrote:
> 
> >  <<linuxwacom.patch>>
> 
> This looks much better, it's not line-wrapped.
> 
> I have one question though, about this part:
> 
> @@ -152,15 +150,103 @@ static void wacom_pl_irq(struct urb *urb
> 
> +                       /* was entered with stylus2 pressed */
> +                       if (wacom->tool[1] == BTN_TOOL_RUBBER && !(data[4] &
> 0x20) ) {
> +                               /* report out proximity for previous tool */
> +                               input_report_key(dev, wacom->tool[1], 0);
> +                               input_sync(dev);
> +                               wacom->tool[1] = BTN_TOOL_PEN;
> +                               return;
> +                       }
> 
> Is it safe to just return without resubmitting the urb here?
> 
> @@ -231,8 +317,12 @@ static void wacom_graphire_irq(struct ur
> +       /* check if we can handle the data */
> +       if (data[0] == 99)
> +               return;
> +
>         if (data[0] != 2)
> 
> Same here.
> 
> Also, please add the path to the patch, e.g. always use recursive diff.
> 
> -- Pete
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
