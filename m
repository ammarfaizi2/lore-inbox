Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271661AbRH0HCt>; Mon, 27 Aug 2001 03:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271658AbRH0HCj>; Mon, 27 Aug 2001 03:02:39 -0400
Received: from mail.gmx.de ([213.165.64.20]:17250 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S271661AbRH0HCf>;
	Mon, 27 Aug 2001 03:02:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Helge Deller <deller@gmx.de>
To: Hollis Blanchard <hollis@austin.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: scr_*() audit
Date: Mon, 27 Aug 2001 09:02:15 +0200
X-Mailer: KMail [version 1.3.5]
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Olaf Hering <olh@suse.de>
In-Reply-To: <Pine.LNX.4.05.10108221846140.6842-100000@callisto.of.borg> <20010826173058.A1418@austin.ibm.com>
In-Reply-To: <20010826173058.A1418@austin.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827070236Z271661-760+6343@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 August 2001 00:30, Hollis Blanchard wrote:
> On Wed, Aug 22, 2001 at 07:06:12PM +0200, Geert Uytterhoeven wrote:
> > Since there are still some issues left with the scr_*() functions on
> > big-endian platforms that can have both VGA and frame buffer consoles, I
> > decided to spent some precious time on auditing the usage of these
> > functions.
>
> Much appreciated.
>
> For the record, this resolves my problems with VGA console (only; no fb) on
> PPC. Previously text written to non-active consoles was endian-reversed.
>
> If no one has any problems (anyone else tested it?), could this patch
> please be committed?

For me it looks good too. I just tested it on HP parisc in text- and fb-mode and 
it worked without any problems. I only had to add a missing semicolon to the
patch:
linux-2.4.8-ac9/drivers/char/console.c:
                        while (cnt--) {
-                               u16 a = *q;
+                               a = scr_readw(q);
                                a = ((a) & 0x88ff) | (((a) & 0x7000) >> 4) | (((a) & 0x0700) << 4);
-                               *q++ = a;
+                               scr_writew(a, q);
+                               q++
                                     ^^^ here

Greetings,
Helge
