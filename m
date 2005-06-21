Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVFUQHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVFUQHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVFUQHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:07:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44205 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261682AbVFUQG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:06:57 -0400
Date: Tue, 21 Jun 2005 09:05:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Waitz <tali@admingilde.org>
cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       jgarzik@pobox.com, telendiz@eircom.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaces two GOTO statements with one IF_ELSE statement
 in /fs/open.c
In-Reply-To: <20050621085740.GK11059@admingilde.org>
Message-ID: <Pine.LNX.4.58.0506210904040.2268@ppc970.osdl.org>
References: <Pine.LNX.4.62.0506201834460.5008@localhost.localdomain>
 <42B70E62.5070704@pobox.com> <Pine.LNX.4.62.0506201154300.2245@graphe.net>
 <20050620133800.0dac1d97.akpm@osdl.org> <20050621085740.GK11059@admingilde.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Jun 2005, Martin Waitz wrote:
> 
> On Mon, Jun 20, 2005 at 01:38:00PM -0700, Andrew Morton wrote:
> > Yes, it is cleaner that way.
> 
> Well, I don't think so...
> 
> > The old trick to make the error-handling code out-of-line shouldn't be
> > needed nowadays - IS_ERR uses unlikely(), which is supposed to handle that
> > stuff.
> 
> IMHO out-of-line error handling improves readability because you have a
> clear boundary between real functionality and error handling.  If both
> are mixed up you have to look longer at the code to understand the
> control-flow.

I personally tend to prefer out-of-line error handling when there are 
multiple error paths, or the function is even slightly more complex. 

In this case the in-line error handling seems warranted, though. Doing it 
out-of-line just doesn't buy you anything in this case.

		Linus
