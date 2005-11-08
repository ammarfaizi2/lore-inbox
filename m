Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbVKHGud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbVKHGud (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 01:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbVKHGud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 01:50:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7872 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964911AbVKHGud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 01:50:33 -0500
Date: Mon, 7 Nov 2005 22:50:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: drzeus-list@drzeus.cx, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] wbsd pnp suspend
Message-Id: <20051107225019.7cd01a77.akpm@osdl.org>
In-Reply-To: <20051108064100.18059.79712.stgit@poseidon.drzeus.cx>
References: <20051108064100.18059.79712.stgit@poseidon.drzeus.cx>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman <drzeus@drzeus.cx> wrote:
>
> Allow the wbsd driver to use the new suspend/resume functions added to
> the PnP layer.
> 

Doesn't Russell handle mmc stuff?

> -static int wbsd_suspend(struct device *dev, pm_message_t state)
> +static int wbsd_suspend(struct wbsd_host *host, pm_message_t state)
> +{
> +	BUG_ON(host == NULL);
> +
> +	return mmc_suspend_host(host->mmc, state);
> +}

There's not much point in this BUG_ON.  If host==0 then we'll get a
perfectly good oops in the next statement - it's just as informative.

> +static int wbsd_resume(struct wbsd_host *host)
> +{
> +	BUG_ON(host == NULL);

Ditto.

> +	if (host->config != 0)
> +	{
> +		if (!wbsd_chip_validate(host))
> +		{

Like:

	if (host->config != 0) {
		if (!wbsd_chip_validate(host)) {

please.

