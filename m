Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVCGNGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVCGNGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 08:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVCGNGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 08:06:15 -0500
Received: from mx1.mail.ru ([194.67.23.121]:22356 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261151AbVCGNGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 08:06:08 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Subject: Re: [patch] fix NULL pointer deference in ALPS
Date: Mon, 7 Mar 2005 16:06:33 +0200
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <20050307122432.GG8138@ens-lyon.fr>
In-Reply-To: <20050307122432.GG8138@ens-lyon.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503071606.33984.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 March 2005 14:24, Benoit Boissinot wrote:

> alps_get_model returns a pointer or NULL in case of errors, so we need to
> check for the results being NULL, not negative.

2.6.11-bk2:	int alps_get_model(struct psmouse *psmouse)
	takes 1 argument, returns -1 on error

2.6.11-mm1:	static struct alps_model_info *alps_get_model(struct psmouse *psmouse, int *version)
	takes 2 arguments, returns NULL on error

> --- linux-clean/drivers/input/mouse/alps.c
> +++ linux-vanilla/drivers/input/mouse/alps.c

> -	if ((model = alps_get_model(psmouse)) < 0)
> +	if (!(model = alps_get_model(psmouse)))

> -	if ((model = alps_get_model(psmouse)) < 0)
> +	if (!(model = alps_get_model(psmouse)))

> -	if (alps_get_model(psmouse) < 0)
> +	if (!alps_get_model(psmouse))

To what version of kernel this patch should be applied?

	Alexey
