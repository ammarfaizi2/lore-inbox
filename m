Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVKDOtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVKDOtb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 09:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVKDOtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 09:49:31 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:45642 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750706AbVKDOtb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 09:49:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kgefdikTqYpXUgfEqJm9lxaeEQmEQjOwJF35vodCUbHiEitkMl9pStEeWo1TP8Dr5mJSgjM6ptv90ssPEUms8apuTsnY10/Y1ttiAd3ocd7WcX7TBdY11YrYhQaIuPkEcN5RKNAeeDIUcwLCpXe0rPOtrf/SlAIYutaOptHP6MI=
Message-ID: <d120d5000511040649u5b33405an73b5e33fb4ce5cf6@mail.gmail.com>
Date: Fri, 4 Nov 2005 09:49:30 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [Fwd: [PATCH] [PNP][RFC] Suspend support for PNP bus.]
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Adam Belay <ambx1@neo.rr.com>
In-Reply-To: <436B2819.4090909@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436B2819.4090909@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/05, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> +
> +int pnp_start_dev(struct pnp_dev *dev)
> +{
> +       if (!pnp_can_write(dev)) {
> +               pnp_info("Device %s does not supported activation.", dev->dev.bus_id);

"...does not support...", there is no "ed" at the end.

> +               return -EINVAL;
> +       }

Hmm, would'nt presence of such device stop suspend process? It will
cause pnp_bus_resume to fail too. Perhaps returning 0 in this case is
better.

> +
> +int pnp_stop_dev(struct pnp_dev *dev)
> +{
> +       if (!pnp_can_disable(dev)) {
> +               pnp_info("Device %s does not supported disabling.", dev->dev.bus_id);
> +               return -EINVAL;

Same here. No "ed" and -EINVAL will hurt.

--
Dmitry
