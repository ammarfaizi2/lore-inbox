Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWCZRbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWCZRbN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWCZRbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:31:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32706 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751294AbWCZRbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:31:13 -0500
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@argo.co.il>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
In-Reply-To: <4426CE5F.5070201@argo.co.il>
References: <200603141619.36609.mmazur@kernel.pl>
	 <200603231811.26546.mmazur@kernel.pl>
	 <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
	 <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix>
	 <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
	 <20060326065205.d691539c.mrmacman_g4@mac.com>
	 <1143376008.3064.0.camel@laptopd505.fenrus.org>
	 <F31089B5-0915-439D-B218-009384E2148F@mac.com>
	 <4426974D.8040309@argo.co.il>
	 <25A7D808-9900-4035-BEB3-A782C5EF8EF4@mac.com>
	 <4426CE5F.5070201@argo.co.il>
Content-Type: text/plain
Date: Sun, 26 Mar 2006 19:29:55 +0200
Message-Id: <1143394195.3055.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-26 at 19:24 +0200, Avi Kivity wrote:
> Kyle Moffett wrote:
> > On Mar 26, 2006, at 08:29:49, Avi Kivity wrote:
> >> Kyle Moffett wrote:
> >>> Well I guess you could call it UABI, but that might also imply that 
> >>> it's _userspace_ that defines the interface, instead of the kernel.  
> >>> Since the headers themselves are rather tightly coupled with the 
> >>> kernel, I think I'll stick with the KABI name for now (unless 
> >>> somebody can come up with a better one, of course :-D).
> >>
> >> How about __linux, or __linux_abi? There are ABIs for other 
> >> components, and other OSes. Linux is the name of the project after all.
> >
> > The other thing that I quickly noticed while writing up the patches is 
> > that it's kind of tedious typing __kabi_ over and over again.  I 
> > actually did first try with __linux_abi_ but the typing effort and 
> > finger cramps made me give up on that really quickly.
> #define _LA(x) __linux_abi_##x
> 
> struct _LA(whatever) {
>     int foo;
>     int bar;
> };
> 
> struct _LA(another) {
>     ...
> };

this is a good sign that this is all very over designed :)

namespace pollution is perhaps evil, but we also should not overreact.
Especially for struct names. *IF* they are in a "narrow enough" header,
the user of the header knows what he is doing, and accepts these to be
in his namespace.

The problem is things like u64 etc that is VERY common in all headers,
but then again __u64 etc are just fine, history has proven that already.


