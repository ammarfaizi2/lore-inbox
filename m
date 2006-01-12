Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbWALM2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWALM2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 07:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbWALM2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 07:28:18 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:32448 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1030374AbWALM2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 07:28:16 -0500
Date: Thu, 12 Jan 2006 07:27:59 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-reply-to: <Pine.LNX.4.61.0601121155450.30994@scrub.home>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <1137068880.4254.8.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <0ISL003ZI97GCY@a34-mta01.direcway.com>
 <200601090109.06051.zippel@linux-m68k.org> <1136779153.1043.26.camel@grayson>
 <200601091232.56348.zippel@linux-m68k.org> <1136814126.1043.36.camel@grayson>
 <Pine.LNX.4.61.0601120019430.30994@scrub.home>
 <1137031253.9643.38.camel@grayson>
 <Pine.LNX.4.61.0601121155450.30994@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 12:08 +0100, Roman Zippel wrote:
> Hi,
> 
> On Wed, 11 Jan 2006, Ben Collins wrote:
> 
> > First, we need oldconfig because it allows us to look at the build log
> > and see exactly what happened in the config stage. Silentoldconfig gives
> > us no feedback for logs.
> 
> silentoldconfig gives you exactly the same information. Both conf and 
> oldconfig will change invisible options without telling you, so it's not 
> exact at all.
> If you can't trust a silent oldconfig, a more verbose oldconfig can't tell 
> you anything else, if it would it's a bug.

silentoldconfig tells you a lot less, agreed? I want the verbose
oldconfig, and I want it to fail on closed stdin when it needs input.

> > 3) Obviously since current behavior of oldconfig was broken with a
> > closed stdin, then it was never doing what anyone wanted in this usage
> > case. Since no one else noticed it, that means that we are the only use
> > case for this.
> 
> This is enough reason to simply hijack conf and use it for your own 
> purpose without even asking the maintainer about the intended bahaviour?

Hijack? It was broken, correct? It has always been broken. This problem
has existed for as long as I've been handling kernel builds with Debian
(which seems to be about 6-7 years now). So intended behavior aside, it
has never worked as intended.

> > 5) My patch did not break anything, nor did it change anything that was
> > already working.
> 
> It _was_ working like that, you're breaking it.

At what point did oldconfig use default values when stdin was closed?
Show me the code that actually did this. Yes, it has always used default
values when it was empty input, just like silentoldconfig does. But
silentoldconfig aborts when stdin is closed, why should oldconfig?

> > 6) In response you make oldconfig work exactly opposite of
> > silentoldconfig by using the default value for a config option when
> > stdin is closed (basically acting like the user hit ENTER), and further
> > break things for me in this usage case, with no purpose, and no reason
> > for making your change the way you did. Since it was broken, you aren't
> > helping anyone. We can't have the build system using default values. We
> > need it to abort.
> 
> So simply use silentoldconfig.

That's not the usage I want. Show me where and when oldconfig worked as
you say it was intended to work. And then explain why oldconfig is
intended to be inconsistent with silentoldconfig.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

