Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751531AbWAINmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWAINmm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWAINmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:42:42 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:5863 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1751530AbWAINmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:42:42 -0500
Date: Mon, 09 Jan 2006 08:42:06 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-reply-to: <200601091232.56348.zippel@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <1136814126.1043.36.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <0ISL003ZI97GCY@a34-mta01.direcway.com>
 <200601090109.06051.zippel@linux-m68k.org> <1136779153.1043.26.camel@grayson>
 <200601091232.56348.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 12:32 +0100, Roman Zippel wrote:
> Hi,
> 
> On Monday 09 January 2006 04:59, Ben Collins wrote:
> 
> > > Then something is wrong with your automatic build. If the config needs to
> > > be updated and stdin is redirected during a kbuild, it will already
> > > abort.
> >
> > And what should be directed into stdin? Nothing. There should be no
> > input going into an automated build, exactly because it could produce
> > incorrect results.
> >
> > BTW, this is the automatic build that Debian and Ubuntu both use (in
> > Debian's case, used for quite a number of years). So this isn't
> > something I whipped up.
> 
> That just means Debian's automatic build for the kernel has been broken for 
> years. All normal config targets require user input and no input equals 
> default input. Only silentoldconfig will abort if input is not available.

I think that's broken (because I don't see where that behavior is
described). IMO, based on the code, it should only go with defaults when
-n -y or -m is passed. Anything else should detect when stdin is not
valid and abort. If stdin is valid, and empty string is read, then
that's a valid "give me the default" response.

Why is it so hard to error when stdin is closed? It's not like that will
break anything.

Since silentoldconfig does this, then oldconfig should aswell. The only
naming difference is that silentoldconfig is quiet, and oldconfig is
not. Why should the two act any differently with a closed stdin?

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

