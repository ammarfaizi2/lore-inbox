Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWJJQpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWJJQpn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWJJQpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:45:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:33664 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030197AbWJJQpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:45:42 -0400
Date: Tue, 10 Oct 2006 09:31:16 -0700
From: Greg KH <greg@kroah.com>
To: Manu Abraham <abraham.manu@gmail.com>
Cc: Amit Choudhary <amit2030@gmail.com>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, stable@kernel.org
Subject: Re: [stable] [PATCH 2.6.19-rc1] drivers/media/dvb/bt8xx/dvb-bt8xx.c: check kmalloc() return value.
Message-ID: <20061010163116.GC3614@kroah.com>
References: <20061008231034.e50118df.amit2030@gmail.com> <452A09A1.8040808@gmail.com> <20061010080110.GA20169@kroah.com> <452B81A2.6060905@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452B81A2.6060905@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 03:18:58PM +0400, Manu Abraham wrote:
> Greg KH wrote:
> > On Mon, Oct 09, 2006 at 12:34:41PM +0400, Manu Abraham wrote:
> >> Amit Choudhary wrote:
> >>> Description: Check the return value of kmalloc() in function frontend_init(), in file drivers/media/dvb/bt8xx/dvb-bt8xx.c.
> >>>
> >>> Signed-off-by: Amit Choudhary <amit2030@gmail.com>
> >>>
> >>> diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> >>> index fb6c4cc..14e69a7 100644
> >>> --- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> >>> +++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> >>> @@ -665,6 +665,10 @@ static void frontend_init(struct dvb_bt8
> >>>  	case BTTV_BOARD_TWINHAN_DST:
> >>>  		/*	DST is not a frontend driver !!!		*/
> >>>  		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
> >>> +		if (!state) {
> >>> +			printk("dvb_bt8xx: No memory\n");
> >>> +			break;
> >>> +		}
> >>>  		/*	Setup the Card					*/
> >>>  		state->config = &dst_config;
> >>>  		state->i2c = card->i2c_adapter;
> >>> -
> >>
> >> Signed-off-by: Manu Abraham <manu@linuxtv.org>
> > 
> > Care to send the full patch in a format that we can apply it to the
> > -stable tree?
> > 
> 
> 
>  dvb-bt8xx.c |    4 ++++
>  1 files changed, 4 insertions(+)
> 
> 
> Thanks,

Um, can you resend it with the proper description and signed-off-by:
lines so that it can be applied correctly?

And does this solve a real bug, or is it just added error condition
checks?  If the latter, I don't think it's ok for -stable right now.

thanks,

greg k-h
