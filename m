Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbWJXOdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWJXOdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWJXOdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:33:45 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:9349 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030403AbWJXOdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:33:44 -0400
Message-Id: <200610241421.k9OELHj6005788@laptop13.inf.utfsm.cl>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: video4linux-list@redhat.com, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, isely@pobox.com, slts@free.fr
Subject: Re: [PATCH] pvrusb2: use NULL instead of 0 
In-Reply-To: Message from Randy Dunlap <randy.dunlap@oracle.com> 
   of "Mon, 23 Oct 2006 20:28:13 PDT." <20061023202813.ff01fc74.randy.dunlap@oracle.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Tue, 24 Oct 2006 11:21:17 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 24 Oct 2006 11:21:20 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <randy.dunlap@oracle.com> wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix sparse NULL usage warnings:
> drivers/media/video/pvrusb2/pvrusb2-v4l2.c:714:14: warning: Using plain integer as NULL pointer
> drivers/media/video/pvrusb2/pvrusb2-v4l2.c:715:16: warning: Using plain integer as NULL pointer
> drivers/media/video/pvrusb2/pvrusb2-v4l2.c:1079:10: warning: Using plain integer as NULL pointer
> drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c:224:58: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c |    2 +-
>  drivers/media/video/pvrusb2/pvrusb2-v4l2.c        |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> --- linux-2.6.19-rc2-git8.orig/drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c
> +++ linux-2.6.19-rc2-git8/drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c
> @@ -221,7 +221,7 @@ static unsigned int decoder_describe(str
>  static void decoder_reset(struct pvr2_v4l_cx2584x *ctxt)
>  {
>  	int ret;
> -	ret = pvr2_i2c_client_cmd(ctxt->client,VIDIOC_INT_RESET,0);
> +	ret = pvr2_i2c_client_cmd(ctxt->client,VIDIOC_INT_RESET,NULL);

Should be, per Coding-style:

        ret = pvr2_i2c_client_cmd(ctxt->client, VIDIOC_INT_RESET, NULL);

There is more similar stuff in the patch. Why not clean that up in the
same sweep?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
