Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932972AbWFWJ7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932972AbWFWJ7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932984AbWFWJ7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:59:30 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:38149 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932972AbWFWJ73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:59:29 -0400
Date: Fri, 23 Jun 2006 11:59:28 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: Re: stv680 boolean logic bug.
Message-ID: <20060623095928.GA27774@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <20060623004033.GA14911@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623004033.GA14911@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 08:40:33PM -0400, Dave Jones wrote:
> This looks closer to what I believe the original intent was.
> (Also fixes line-len to meet CodingStyle)
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6/drivers/media/video/stv680.c~	2006-06-22 20:38:21.000000000 -0400
> +++ linux-2.6/drivers/media/video/stv680.c	2006-06-22 20:39:02.000000000 -0400
> @@ -974,7 +974,8 @@ static void bayer_unshuffle (struct usb_
>  	frame->grabstate = FRAME_DONE;
>  	stv680->framecount++;
>  	stv680->readcount++;
> -	if (stv680->frame[(stv680->curframe + 1) & (STV680_NUMFRAMES - 1)].grabstate == FRAME_READY) {
> +	if (stv680->frame[(stv680->curframe + 1) &&
> +			(STV680_NUMFRAMES - 1)].grabstate == FRAME_READY) {
>  		stv680->curframe = (stv680->curframe + 1) & (STV680_NUMFRAMES - 1);
>  	}

That looks very wrong.  You're turning a circular buffer
into... whatever.

  OG.

