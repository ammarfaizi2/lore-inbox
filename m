Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279851AbRJ3EYK>; Mon, 29 Oct 2001 23:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279853AbRJ3EYB>; Mon, 29 Oct 2001 23:24:01 -0500
Received: from ams-msg-core-1.cisco.com ([144.254.74.60]:42448 "EHLO
	ams-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S279851AbRJ3EXp>; Mon, 29 Oct 2001 23:23:45 -0500
Message-ID: <3BDE2B4D.CA679FF1@cisco.com>
Date: Tue, 30 Oct 2001 09:53:41 +0530
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small compile warning fix
In-Reply-To: <7A9BC5E3241@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

> On 29 Oct 01 at 15:43, Manik Raina wrote:
> >
> > Index: ncplib_kernel.c
> > ===================================================================
> > RCS file: /vger/linux/fs/ncpfs/ncplib_kernel.c,v
> > retrieving revision 1.29
> > diff -u -r1.29 ncplib_kernel.c
> > --- ncplib_kernel.c 18 Sep 2001 22:29:08 -0000  1.29
> > +++ ncplib_kernel.c 29 Oct 2001 10:09:27 -0000
> > @@ -52,6 +52,11 @@
> >     return;
> >  }
> >
> > +#ifdef LATER
> > +/*
> > + * This function is not currently in use. This leads to a compiler warning.
> > + * Remove #ifdef when in use...
> > + */
> >  static void ncp_add_mem_fromfs(struct ncp_server *server, const char *source, int size)
> >  {
> >     assert_server_locked(server);
>
> You can remove it completely. It should not be '#ifdef LATER', but
> '#ifdef OLDVERSION'... ncp_add_mem_fromfs was invoked with lock on
> ncp_server structure, but then it directly accessed userspace. It was
> possible to use this to cause deadlock, so now ncpfs uses bounce buffers
> and double copy instead of this.
>

would you include this in your patches or would you like me to make
it #ifdef OLDVERSION ?

thanks
Manik

>
> I have some ncpfs patches, but I though that I'll leave them for 2.5.x.
> Maybe it is time to change this decision.
>                                             Best regards,
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
>

