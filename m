Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUIJIeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUIJIeI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUIJIeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:34:08 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:11709 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267248AbUIJIeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:34:04 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, adaplas@pol.net
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Fri, 10 Sep 2004 16:35:16 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1094783022.2667.106.camel@gaston> <200409101328.57431.adaplas@hotpop.com> <1094796002.14398.118.camel@gaston>
In-Reply-To: <1094796002.14398.118.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409101635.16803.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 September 2004 14:00, Benjamin Herrenschmidt wrote:
> On Fri, 2004-09-10 at 15:28, Antonino A. Daplas wrote:
> > If fb_get_options returns an error, drivers will not proceed with their
> > initialization. The second method is more compatible with the
> > previous setup semantics.
> >
> > I told Geert that if the changes did bite us, then I have no choice
> > but to add support for the second method.
> >
> > So, if you think that the first method is not enough, then I will add the
> > second method. Let me know.
>
> I submited a patch moving offb to the bottom of the Makefile to at
> least restore normal drivers. For ofonly, a bit more hackish, but
> what about failing register_framebuffer for anything but offb ?

Yes, that should solve the ofonly problem, with the offb in the very last of 
the Makefile, though as you said, it's a little hackish, but very simple to 
implement.  This will work for ofonly though, since 
info->fix.name is not necessarily equal to "xxxfb".  For instance, offb set 
"OFfb" in info->fix.name, but the boot option is "offb".

After giving it some thought, I think method 2 might be the best since it 
provides compatibility with the old syntax.  Especially if users expect 
video=xxxfb:off to work.  Also, this brings more flexibility in the offchance 
we decide to add more options to "video=".

I'm willing to work on this, but if you don't like it, then I'll do the 'fail 
at register_framebuffer".

Tony



