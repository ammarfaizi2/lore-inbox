Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUGKB0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUGKB0s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 21:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266474AbUGKB0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 21:26:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:38069 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266473AbUGKB0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 21:26:45 -0400
Date: Sat, 10 Jul 2004 18:25:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Adam Kropelin" <akropel1@rochester.rr.com>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       tim.bird@am.sony.com, celinux-dev@tree.celinuxforum.org,
       tpoynor@mvista.com, geert@linux-m68k.org
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
Message-Id: <20040710182527.47534358.akpm@osdl.org>
In-Reply-To: <099101c466ba$7d75aa30$03c8a8c0@kroptech.com>
References: <40EEF10F.1030404@am.sony.com>
	<20040710115413.A31260@mail.kroptech.com>
	<20040710142800.A5093@mail.kroptech.com>
	<200407101319.31147.dtor_core@ameritech.net>
	<099101c466ba$7d75aa30$03c8a8c0@kroptech.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam Kropelin" <akropel1@rochester.rr.com> wrote:
>
> > Does 250 ms worth all this pain?
> 
>  On a desktop box, almost certainly not. On a massive SMP machine, maybe. On
>  an embedded system that is required to boot in a ridiculously short time,
>  absolutely.

Yes, it's pretty small beer, but we do recognise that although the number
of development teams which use features like this is small, the number of
systems is large, so the features are correspondingly more important.

One of the services which we kernel developers provide the downstream
kernel users is the hosting and maintenance of their code so they don't
have to carry important stuff off-stream, and when the changes are this
small and simple, I don't see a problem with merging them, even if none of
"us" will use the feature.

wrt this particular patch:

a) I don't see much point in making it configurable.  Just add the boot
   option and be done with it.  The few hundred bytes of extra code will be
   dropped from core anyway.

   The main reason for this is that most people won't turn on the config
   option, so your new code could get accidentally broken quite easily. 
   Plus it removes some ifdefs.

b) Coding style consistency, please:

   Replace things like

		/* Do a binary approximation to get loops_per_jiffy set to
		   equal one clock (up to lps_precision bits) */

   with 

		/*
		 * Do a binary approximation to get loops_per_jiffy set to
		 * equal one clock (up to lps_precision bits)
		 */


	while ( lps_precision-- && (loopbit >>= 1) ) {

  should be

	while (lps_precision-- && (loopbit >>= 1)) {

  Yes, some of the code was already like that, but let's regularise these
  things as we go.

