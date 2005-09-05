Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVIEToj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVIEToj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 15:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVIEToj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 15:44:39 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:26413 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932436AbVIEToi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 15:44:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QvD9rUiDFjHFLZdNGHKcCiFi3o9VyVZ9cA7avfaM6wgUKl5GpKDAG0/nhzBv/deHtYMV2u8tQjBnVZ7eX7bpX2DKhow4QEokIlvGpxvJvMt489toUzROLWaYPKJnmae+a4alFhhQoKFD4Z9iJsPUJ7quOoaecnvwigk1Zc0Fwuo=
Message-ID: <29495f1d05090512447da5bcb5@mail.gmail.com>
Date: Mon, 5 Sep 2005 12:44:37 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] Omnikey Cardman 4000 driver
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20050906013545.GB16056@rama.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050906013545.GB16056@rama.de.gnumonks.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, Harald Welte <laforge@gnumonks.org> wrote:
> Hi!
> 
> Following-up to the Cardman 4040 driver, I'm now sumitting a driver for
> the Cardman 4000 reader.  It is, too, a PCMCIA smartcard reader and the
> predecessor of the 4040.
> 
> From a technical point of view, the two devices have nothing in common,
> so there is no possibility of code sharing.

<snip>

> --- /dev/null
> +++ b/drivers/char/pcmcia/cm4000_cs.c

<snip>

> +/* interruptible_pause() */
> +static inline void ipause(unsigned long amount)
> +{
> +       current->state = TASK_INTERRUPTIBLE;
> +       schedule_timeout(amount);
> +}
> +
> +/* uninterruptible_pause() */
> +static inline void upause(unsigned long amount)
> +{
> +       current->state = TASK_UNINTERRUPTIBLE;
> +       schedule_timeout(amount);
> +}

It looks like all callers of these functions pass in milliseconds? Any
chance you can get rid of these two and use msleep_interruptible() and
msleep() instead? As long as you are not using these functions around
wait-queues, you are ok (which I think is the case here). If you are
using wait-queues with these sleeps, then please use
schedule_timeout_interruptible() and
schedule_timeout_uninterruptible() from the -mm tree.

Thanks,
Nish
