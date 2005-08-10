Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbVHJPKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbVHJPKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 11:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbVHJPKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 11:10:23 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:31182 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965150AbVHJPKW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 11:10:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YsX27dyX6L0RG2d3jIRw46w6kgz203C/OmEL0pYfgUg/BD/wmcaUrD6YWELmmzpsP4WppVAqr/tcn+nThl2CQllAiAPBOneb6e5PZaSskzAwNAP0h+cdOypIZkiVH7SLQOYOEjWPba4H7PdP2W+i/kb31lF9ljLrikDXKLosfRw=
Message-ID: <d120d50005081008106500b26d@mail.gmail.com>
Date: Wed, 10 Aug 2005 10:10:22 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alexander Nyberg <alexn@telia.com>
Subject: Re: [BUG] module ns558
Cc: Michael Stenzel <m.stenzel@tronix.homelinux.org>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050805193031.GA17969@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508052052.42128.m.stenzel@tronix.homelinux.org>
	 <20050805193031.GA17969@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/05, Alexander Nyberg <alexn@telia.com> wrote:
> 
> Please try this:
> 
> Index: linux-2.6/drivers/input/gameport/ns558.c
> ===================================================================
> --- linux-2.6.orig/drivers/input/gameport/ns558.c       2005-07-31 18:10:26.000000000 +0200
> +++ linux-2.6/drivers/input/gameport/ns558.c    2005-08-05 21:20:59.000000000 +0200
> @@ -275,9 +275,9 @@
> 
>  static void __exit ns558_exit(void)
>  {
> -       struct ns558 *ns558;
> +       struct ns558 *ns558, *safe;
> 
> -       list_for_each_entry(ns558, &ns558_list, node) {
> +       list_for_each_entry_safe(ns558, safe, &ns558_list, node) {
>                gameport_unregister_port(ns558->gameport);
>                release_region(ns558->io & ~(ns558->size - 1), ns558->size);
>                kfree(ns558);
> -

I think this one should go into 2.6.13 and probably in -stable too... 

-- 
Dmitry
