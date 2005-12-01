Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVLAEF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVLAEF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 23:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVLAEF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 23:05:28 -0500
Received: from magic.adaptec.com ([216.52.22.17]:48848 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751290AbVLAEF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 23:05:27 -0500
Date: Thu, 1 Dec 2005 09:42:09 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Why does insmod _not_ check for symbol redefinition ??
In-Reply-To: <1133398629.8128.10.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0512010926460.1697-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 01 Dec 2005 04:05:22.0603 (UTC) FILETIME=[7375EFB0:01C5F62C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, Rusty Russell wrote:

> Sure.  It was due to minimalism.  If you override a symbol it's
> undefined behavior.  It should be fairly simple to add a check that
> noone overrides a symbol.  We didn't bother checking for it because it
> wasn't clear that it was problematic.

Thanx.
Of all the problems (including kernel crashes, BUGs etc) one of the 
more serious  kinds are the ones where someone writes a new module and 
accidently  defines a function which has the same name as one of functions 
(say  foo_export),  already EXPORTed by either kernel proper or some 
loaded  module (as the  kernel is growing bigger chances of this happening 
is also  growing). The module happily loads and then some other module 
which wants  to use the function foo_export (obviously the one EXPORTed by 
kernel  proper and not the one overidden by the overiding module) is 
loaded. It  will also load happily but will get linked against the new 
foo_export,  defnitely not something that he wants. And, all this has 
happened without the kernel telling the user anything.
	IMHO, these kind of silent errors are very dangerous and not 
something that should be acceptable.
As you rightly said, it should be fairly straightforward to check for 
symbol redefinition. We need to do it only for the symbols EXPORTed by the 
loadable module.

Thanx,
Tomar

-- "Theory is when you know something, but it doesn't work.
    Practice is when something works, but you don't know why.
    Programmers combine theory and practice: Nothing works 
    and they don't know why ..."

