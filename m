Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268138AbUIJFab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268138AbUIJFab (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 01:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268197AbUIJFab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 01:30:31 -0400
Received: from smtp-out.hotpop.com ([38.113.3.51]:2003 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S268138AbUIJF17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 01:27:59 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Fri, 10 Sep 2004 13:28:57 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
References: <1094783022.2667.106.camel@gaston>
In-Reply-To: <1094783022.2667.106.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409101328.57431.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 September 2004 10:23, Benjamin Herrenschmidt wrote:
> Recent changes upstream are breaking fbdev on pmacs.
>
> I haven't had time to go deep into that (but I suspect Linus sees it
> too on his own g5 unless he removed offb from his .config).
>
> From what I see, it seems that offb is kicking in by default, reserves
> the mmio regions, and then whatever chip driver loads can't access them.
>
> offb is supposed to be a "fallback" driver in case no fbdev is taking
> over, it should also be "forced" in with video=ofonly kernel command
> line. This logic has been broken.
>

Hi Ben,

Actually, I was thinking about this problem with offb.  I was planning on
adding video=offb:off support for offb, and then place offb at the very top
drivers Makefile (the reason why I placed it there, but forgot to add the
setup support for offb).  So, without the 'off' option, offb becomes the
first driver that gets initialized by reason that it's at the top, and with
the 'off' option, it just exits initialization immediately, giving the other
drivers a chance to get through.

This first method is easy to add.

The second method is not harder but will involve, again, changes to all 
drivers.  The only sane method I can think of is to change fb_get_options so
it returns an error if:

a. "off" option is enabled
b. "ofonly" is enabled but only if name != "offb"

If fb_get_options returns an error, drivers will not proceed with their
initialization. The second method is more compatible with the
previous setup semantics.

I told Geert that if the changes did bite us, then I have no choice
but to add support for the second method.

So, if you think that the first method is not enough, then I will add the
second method. Let me know.

Tony


