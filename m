Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269818AbUIDGxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269818AbUIDGxL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 02:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269825AbUIDGxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 02:53:11 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:43739 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S269818AbUIDGxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 02:53:05 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Thomas Winischhofer <thomas@winischhofer.net>, adaplas@pol.net
Subject: Re: [PATCH 4/5][RFC] fbdev: Clean up framebuffer initialization
Date: Sat, 4 Sep 2004 14:53:01 +0800
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200409041108.40276.adaplas@hotpop.com> <41393829.6020302@winischhofer.net>
In-Reply-To: <41393829.6020302@winischhofer.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409041453.01644.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 September 2004 11:36, Thomas Winischhofer wrote:
> > 5. Because driver initialization will be dependent on the link order,
> > hardware that depends on other subsystems (agpgart, usb, serial, etc) may
> > choose to initialize after the subsystems they depend on.
> >
> > Signed-off-by: Antonino Daplas <adaplas@pol.net>
>
> I don't really see a benefit but it's ok with me.
>

Mainly cleanup, but also point #5.  The i810fb, for instance, depends on agpgart, but
agpgart gets initialized way after fbdev.  The workaround is for i810fb to explicitly
call intel_agp_init().  Besides the ugliness, forcibly initializing the agpgart subsystem
out of sequence may cause problems.

With this change, in theory, I can move i810fb's link order so it gets initialized after
agpgart.

> (Thanks for considering the "unified" nature of sisfb, by the way. Very
> considarate. Very much appreciated.)
>
> I assume that you tested this stuff before posting it here.

Yes, with hardware that I have.  I did try to at least compile test what I can.

Tony


