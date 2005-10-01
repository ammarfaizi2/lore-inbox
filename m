Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVJAUpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVJAUpr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 16:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbVJAUpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 16:45:47 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:5383 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750840AbVJAUpr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 16:45:47 -0400
Date: Sat, 1 Oct 2005 22:46:04 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [HWMON] kmalloc + memset -> kzalloc conversion
Message-Id: <20051001224604.484ef912.khali@linux-fr.org>
In-Reply-To: <20051001072630.GJ25424@plexity.net>
References: <20051001072630.GJ25424@plexity.net>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deepak,

> Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
> 
> diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
> --- a/drivers/hwmon/adm1021.c
> +++ b/drivers/hwmon/adm1021.c
> @@ -204,11 +204,10 @@ static int adm1021_detect(struct i2c_ada
>  	   client structure, even though we cannot fill it completely yet.
>  	   But it allows us to access adm1021_{read,write}_value. */
>  
> -	if (!(data = kmalloc(sizeof(struct adm1021_data), GFP_KERNEL))) {
> +	if (!(data = kzalloc(sizeof(struct adm1021_data), GFP_KERNEL))) {
>  		err = -ENOMEM;
>  		goto error0;
>  	}
> -	memset(data, 0, sizeof(struct adm1021_data));
> (...)

OK, I'll pick that patch. Three comments however:

1* Please exclude adm9240, it is already updated in my tree.

2* Please add some comment before your Signed-off-line, explaining what
the patch is all about. It doesn't need to be long, but it needs to
exist.

3* Please include diffstat output in the patch header.

Care to respin your patch?

As a side note, I don't think it was worth sending this to Linus,
Andrew and two mailing lists. There's nothing ground breaking here.
Send this kind of patches to me as the subsystem maintainer, CC LKML
for comments if you want, and that should be sufficient.

Thanks,
-- 
Jean Delvare
