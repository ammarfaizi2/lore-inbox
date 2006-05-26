Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWEZQLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWEZQLV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWEZQLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:11:20 -0400
Received: from mail.linicks.net ([217.204.244.146]:10639 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1750982AbWEZQLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:11:15 -0400
From: Nick Warne <nick@linicks.net>
To: Antonio <tritemio@gmail.com>
Subject: Re: : unclean backward scrolling
Date: Fri, 26 May 2006 17:11:06 +0100
User-Agent: KMail/1.9.1
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <5486cca80605210638l2906112fv515df1bc390cff24@mail.gmail.com> <44764F4F.5000102@gmail.com> <5486cca80605260500p72e107fcw8c422c1ea884be4f@mail.gmail.com>
In-Reply-To: <5486cca80605260500p72e107fcw8c422c1ea884be4f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261711.07096.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 13:00, Antonio wrote:
> Hi,
>
> On 5/26/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > Nick Warne wrote:
> > > Hmmmph.
> > >
> > > I get this problem, and always have, but I always put it down to my
> > > system.
> > >
> > > I run Slackware 10, and this has always happened to me from 2.6.2
> > > upwards on CRT 1024x768 and later TFT 1280x1024 dvi.
> > >
> > > I use[d] in lilo:
> > >
> > > # VESA framebuffer console @ 1280x1024x?k
> > > vga=794
> > > # VESA framebuffer console @ 1024x768x64k
> > > #vga=791
> > >
> > > So you are not alone.
> > >
> > > Nick
> > >
> > > On 21/05/06, Antonio <tritemio@gmail.com> wrote:
> > >> Hi,
> > >>
> > >> I'm using the radeonfb driver with a radeon 7000 with the frambuffer
> > >> at 1280x1024 on a i386 system, with a 2.6.16.17 kernel. At boot time,
> > >> if I stop the messages with CTRL+s and try look the previous messages
> > >> with CTRL+PagUp (backward scrolling) the screen become unreadable. In
> > >> fact some lengthier lines are not erased scrolling backward and some
> > >> random characters a overwritten instead. So it's very difficult to
> > >> read the messages.
> > >>
> > >> I don't have such problem with the frambuffer at 1024x768.
> > >>
> > >> All the previous kernels I've tried have this problem (at least up to
> > >> 2.6.15).
> > >>
> > >> If someone can look at this issue I can provide further information.
> > >>
> > >> Many Thanks.
> > >>
> > >> Cheers,
> >
> > Can you try this patch and let me know if this fixes the problem?
> >
> > Tony
> >
> > PATCH: Fix scrollback with logo issue immediately after boot.
>
> [cut]
>
> This patch fixes completely the problem for me. Many thanks!
>
> Is going to be included in mainline anytime soon?
>
> Many thanks again, I've really appreciated your help.
>
> Cheers,
>
>   ~ Antonio

Yep, good job!  I confirm it fixes the issues I had on garbled screen when 
scrolling back (which I always thought was my hardware!).

Many Thanks!

Nick

Signed-off-by: David Hollister <david.hollister@amd.com>
Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/console/fbcon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index ca02071..953eb8c 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2631,7 +2631,7 @@ static int fbcon_scrolldelta(struct vc_d
                                        scr_memcpyw((u16 *) q, (u16 *) p,
                                                    vc->vc_size_row);
                                }
-                               softback_in = p;
+                               softback_in = softback_curr = p;
                                update_region(vc, vc->vc_origin,
                                              logo_lines * vc->vc_cols);
                        }



-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
