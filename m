Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUD3JTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUD3JTU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 05:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265126AbUD3JTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 05:19:20 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:40459 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265124AbUD3JTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 05:19:17 -0400
Date: Fri, 30 Apr 2004 12:18:33 +0300
From: vda@port.imtp.ilyichevsk.odessa.ua
X-Mailer: The Bat! (v1.44)
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
X-Priority: 3 (Normal)
Message-ID: <18781898240.20040430121833@port.imtp.ilyichevsk.odessa.ua>
To: Tim Connors <tconnors+linuxkernel1083305837@astro.swin.edu.au>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       <brettspamacct@fastclick.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re[2]: ~500 megs cached yet 2.6.5 goes into swap hell
In-reply-To: <Pine.LNX.4.53.0404301646510.11320@tellurium.ssi.swin.edu.au>
References: <40904A84.2030307@yahoo.com.au>
 <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
 <slrn-0.9.7.4-14292-10175-200404301617-tc@hexane.ssi.swin.edu.au>
 <4091F38C.3010400@yahoo.com.au>
 <Pine.LNX.4.53.0404301646510.11320@tellurium.ssi.swin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tim,

Friday, April 30, 2004, 10:05:19 AM, you wrote:
TC> Parts of X and the window manager also get swapped out, so when I move to
TC> another virtual page, I get to watch fvwm redraw the screen - this is not
TC> too painful though, because only a few megs need be swapped back in
TC> (although the HD is seeking all over the place as things thrash about, so
TC> it does still take non-negligible amount of time). Mozilla takes about 30
TC> seconds to swap back in (~50-100MB - again, lots of thrashing from the

I don't want to say that you're seeing optimal behavior,
just a different angle of view: wny in hell browser should
have such ridiculously large RSS? Why it tries to keep
so much stuff in the RAM?

Multimedia content (jpegs etc) is typically cached in
filesystem, so Mozilla polluted pagecache with it when
it saved JPEGs to the cache *and* then it keeps 'em in RAM
too, which doubles RAM usage. Most probably more, there
is severe internal fragmentation problems after you use
such a large application for several hours straight.
Why not reread JPEG whenever you need it? If you are
using Mozilla right now, it will be in pagecache.
When you are away, cache will be discarded, no need
to page out Mozilla pages with JPEG content - because
there aren't Mozilla pages with JPEG content!
RSS is smaller, less internal fragmentation, everyone's
happy.

(I don't specifically target Mozilla, it have shown some
improvement recently. Replace with your favorite
monstrosity)

Kernel folks probably can improve kernel behavior.
Next version of $BloatyApp will happily "use"
gained performance and improved RAM management
as an excuse for even less optimal code.

It's a vicious circle.
--
vda


