Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVKTXyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVKTXyE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVKTXyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:54:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7953 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932134AbVKTXyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:54:03 -0500
Date: Mon, 21 Nov 2005 00:54:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: bcollins@debian.org, dan@dennedy.org,
       linux1394-devel@lists.sourceforge.net, scjody@steamballoon.com,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/raw1394.c: fix a NULL pointer dereference
Message-ID: <20051120235402.GS16060@stusta.de>
References: <20051120232009.GH16060@stusta.de> <9a8748490511201545n70e0e6fftd0f1aaf748abe05@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490511201545n70e0e6fftd0f1aaf748abe05@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 12:45:14AM +0100, Jesper Juhl wrote:
> On 11/21/05, Adrian Bunk <bunk@stusta.de> wrote:
> > The coverity checker spotted that this was a NULL pointer dereference in
> > the "if (copy_from_user(...))" case.
> >
> >
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> > --- linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c.old    2005-11-20 22:08:57.000000000 +0100
> > +++ linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c        2005-11-20 22:09:34.000000000 +0100
> > @@ -2166,7 +2166,8 @@
> >                         }
> >                 }
> >         }
> > -       kfree(cache->filled_head);
> > +       if(cache->filled_head)
> > +               kfree(cache->filled_head);
> >         kfree(cache);
> >
> Hmmm,  kfree() deals with NULL pointers just fine, so there's no
> problem if cache->filled_head is NULL. There is, however, a NULL
> pointer deref problem if `cache' is NULL, but that's not what your
> patch checks for.
>...

OK, I was blind...

I've just sent a better patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

