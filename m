Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbUKVUs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbUKVUs2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbUKVUsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:48:14 -0500
Received: from smtp-out.hotpop.com ([38.113.3.71]:26307 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S262504AbUKVUrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:47:16 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: [2.6 patch] drivers/video/: misc cleanups
Date: Tue, 23 Nov 2004 04:46:47 +0800
User-Agent: KMail/1.5.4
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20041121153702.GB2829@stusta.de> <200411221055.07693.adaplas@hotpop.com> <Pine.GSO.4.61.0411221043040.7323@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.61.0411221043040.7323@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411230446.50784.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 November 2004 17:43, Geert Uytterhoeven wrote:
> On Mon, 22 Nov 2004, Antonino A. Daplas wrote:
> > On Sunday 21 November 2004 23:58, Adrian Bunk wrote:
> > > On Sun, Nov 21, 2004 at 04:37:02PM +0100, Adrian Bunk wrote:
> > > > The patch below does the following cleanups under drivers/video/ :
> > > > - make some needlessly global code static
> > > > - the following was needlessly EXPORT_SYMBOL'ed:
> > > >   - fbcon.c: fb_con
> > > >   - mdacon.c: fb_blank
> > > >   - fbmon.c: get_EDID_from_firmware (completely unused)
> > > >...
> > >
> > > I forgot one thing:
> > >
> > > Please review my global_mode_option removal in modedb.c .
> > >
> > > It was always NULL and I'd say the only usage was wrong (although it
> > > had no practical effect).
> >
> > Should be ok to remove it.  I only see fb_find_mode using it, and as
> > you've concluded, usage is not very clear.
> >
> > BTW: The global_mode_option, previously, is filled up when no driver is
> > specified in the boot options, such as "video=1024x768@60".  But this was
> > removed during the fb initialization cleanup.
>
> What a pity... It allowed people to not have to care about the name of
> their graphics driver(s)...
>

The absence of the driver name array will make it a bit difficult to differentiate
between options passed specifically to drivers vs the global mode option.

We can bring global_mode_option back. Since driver names always have a
terminating "fb", we can search for the "fb:" substring and if not found,
then it's a global_mode_option.

Is that okay?

Tony


