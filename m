Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275778AbRJ2PNl>; Mon, 29 Oct 2001 10:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275527AbRJ2PNb>; Mon, 29 Oct 2001 10:13:31 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:62470 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S274803AbRJ2PNO>;
	Mon, 29 Oct 2001 10:13:14 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Manik Raina <manik@cisco.com>
Date: Mon, 29 Oct 2001 16:13:14 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] small compile warning fix 
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <7A9BC5E3241@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Oct 01 at 15:43, Manik Raina wrote:
> 
> Index: ncplib_kernel.c
> ===================================================================
> RCS file: /vger/linux/fs/ncpfs/ncplib_kernel.c,v
> retrieving revision 1.29
> diff -u -r1.29 ncplib_kernel.c
> --- ncplib_kernel.c 18 Sep 2001 22:29:08 -0000  1.29
> +++ ncplib_kernel.c 29 Oct 2001 10:09:27 -0000
> @@ -52,6 +52,11 @@
>     return;
>  }
> 
> +#ifdef LATER
> +/*
> + * This function is not currently in use. This leads to a compiler warning.
> + * Remove #ifdef when in use...
> + */
>  static void ncp_add_mem_fromfs(struct ncp_server *server, const char *source, int size)
>  {
>     assert_server_locked(server);

You can remove it completely. It should not be '#ifdef LATER', but
'#ifdef OLDVERSION'... ncp_add_mem_fromfs was invoked with lock on
ncp_server structure, but then it directly accessed userspace. It was
possible to use this to cause deadlock, so now ncpfs uses bounce buffers
and double copy instead of this.

I have some ncpfs patches, but I though that I'll leave them for 2.5.x.
Maybe it is time to change this decision.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
