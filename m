Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVCPRYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVCPRYM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVCPRYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:24:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37257 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262701AbVCPRYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:24:08 -0500
Date: Wed, 16 Mar 2005 09:19:07 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jacques Basson <jacques_basson@myrealbox.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: softdog.c kernel 2.4.29
Message-ID: <20050316121907.GB12881@logos.cnet>
References: <1110959428.10190.5.camel@lancelot.advanced-imaging-technologies>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110959428.10190.5.camel@lancelot.advanced-imaging-technologies>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jacques

On Wed, Mar 16, 2005 at 09:50:27AM +0200, Jacques Basson wrote:
> Hi
> 
> There is a bug in the softdog.c (v 0.05) in the 2.4 kernel series
> (certainly in 2.4.29 and there are no references to it in the latest
> Changelog) that won't reboot the machine if /dev/watchdog is closed
> unexpectedly and nowayout is not set.

Yup, thanks. Applied.

> diff -Naur softdog.c.orig softdog.c
> --- softdog.c.orig      2003-11-28 20:26:20.000000000 +0200
> +++ softdog.c   2005-03-16 09:12:34.000000000 +0200
> @@ -124,7 +124,7 @@
>          *      Shut off the timer.
>          *      Lock it in if it's a module and we set nowayout
>          */
> -       if (expect_close || nowayout == 0) {
> +       if (expect_close && nowayout == 0) {
>                 del_timer(&watchdog_ticktock);
>         } else {
>                 printk(KERN_CRIT "SOFTDOG: WDT device closed
> unexpectedly.  WDT will not stop!\n");
