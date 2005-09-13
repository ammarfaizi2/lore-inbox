Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbVIMQC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVIMQC2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbVIMQC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:02:27 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:27809 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964829AbVIMQC0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:02:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gb8z1Bh7l+11kPup3jZT5p7vWoEt/d2NWDI3WWzOVtZB02LY8HjQFcScVgZuHmiosq4MnIBlvKjesDKn3w9IKQSu3zIj1zzrdrLmwRIF6Ch9MugRm29XMCU8+hI9ed+uZtbr/gvXA2ZUxdpnm4o5dgXh1eK4YmG+W2NCiIEarog=
Message-ID: <29495f1d050913090219cc44fa@mail.gmail.com>
Date: Tue, 13 Sep 2005 09:02:22 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH 1/2] New Omnikey Cardman 4040 driver
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050913155116.GY29695@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050913155116.GY29695@sunbeam.de.gnumonks.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/05, Harald Welte <laforge@gnumonks.org> wrote:
> Hi!
> 
> I've now incorporated all requested/suggested changes. Please apply the
> following patch to the mainline tree, thanks!

<snip>

> diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c

<snip>

> +static ssize_t cm4040_read(struct file *filp, char __user *buf,
> +                       size_t count, loff_t *ppos)
> +{

<snip>

> +       schedule_timeout(1*HZ);

This needs a state set, or it will return immediately. Use either
schedule_timeout_interruptible() or schedule_timeout_uninterruptible()
(merged in 2.6.14-rc1). Otherwise the patches look good.

Thanks,
Nish
