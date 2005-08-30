Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVH3ILO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVH3ILO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVH3ILO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:11:14 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:1641 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751228AbVH3ILM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:11:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=jPsCeY2LZrauFJkY6Zvtord9D8HNa6d7ya9com0QW97udjxkut0amp2+//qy2ui3TAuVbyTBlNCkO/rqvS31GEnkt9YWPhqcAxoLd69zEIZq7cgDNx7ChaK17ZMMsloSDspmVEDLxJ6+Xgp6Y5cAYTagNiZC3ACuj50rUV7OFTM=
Date: Tue, 30 Aug 2005 12:20:33 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Pfeiffer <pfeiffer@pds.de>,
       isdn4linux@listserv.isdn4linux.de, Karsten Keil <kkeil@suse.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>
Subject: Re: [PATCH] isdn_v110 warning fix
Message-ID: <20050830082033.GB12449@mipter.zuzino.mipt.ru>
References: <200508300105.44247.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508300105.44247.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 01:05:43AM +0200, Jesper Juhl wrote:
> drivers/isdn/i4l/isdn_v110.c:523: warning: `ret' might be used uninitialized in this function

> --- linux-2.6.13-orig/drivers/isdn/i4l/isdn_v110.c
> +++ linux-2.6.13/drivers/isdn/i4l/isdn_v110.c
> @@ -516,11 +516,11 @@

> -isdn_v110_stat_callback(int idx, isdn_ctrl * c)
> +isdn_v110_stat_callback(int idx, isdn_ctrl *c)
>  {
>  	isdn_v110_stream *v = NULL;
>  	int i;
> -	int ret;
> +	int ret = 0;

ret is used only in isdn_v110_stat_callback()::case ISDN_STAT_BSENT.
It's possible for it to be unused only if passed c->parm.length is 0.
Do you see codepaths that can do it?

