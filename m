Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVJCO5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVJCO5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbVJCO5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:57:43 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:16257 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750841AbVJCO5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:57:43 -0400
Subject: Re: [PATCH] release_resource() check for NULL resource
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Ben Dooks <ben-linux@fluff.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20051003134241.GV7992@ftp.linux.org.uk>
References: <20051002170318.GA22074@home.fluff.org>
	 <20051002103922.34dd287d.rdunlap@xenotime.net>
	 <20051003094803.GC3500@home.fluff.org>
	 <9a8748490510030259o43646cbbo22b37f1791d267e@mail.gmail.com>
	 <20051003100431.GA16717@flint.arm.linux.org.uk>
	 <84144f020510030543q10ff4fd2g138de4d06eddc440@mail.gmail.com>
	 <20051003134241.GV7992@ftp.linux.org.uk>
Date: Mon, 03 Oct 2005 17:57:38 +0300
Message-Id: <1128351459.7584.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 03, 2005 at 03:43:50PM +0300, Pekka Enberg wrote:
> > Many drivers have the release function copy-pasted to init with lots
> > of goto labels exactly because release_region, iounmap, and friends
> > aren't NULL safe.

On Mon, 2005-10-03 at 14:42 +0100, Al Viro wrote:
> Bullshit.  I have waded through many, *many* initialization sequences
> like that.  "Lots of goto labels" is _less_ prone to breakage when
> properly done; your variant begs for trouble upon the driver changes.
> 
> Note that "lots of goto" is actually a cleaner control structure than
> what you propose - the amount of instances of offending statement is
> far from being the only metrics.  The only things to verify with it are

Fair enough. Bad example from my part.

My main argument still remains. It is useful to handle NULL in some
release functions (iounmap and release_resource come to mind) because it
simplifies releasing a partially initialized state. Grep for NULL checks
around iounmap() and release_resource() calls for existing usage in the
drivers...

			Pekka

