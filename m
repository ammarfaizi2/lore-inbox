Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265669AbUBFSrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265664AbUBFSrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:47:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44770 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265669AbUBFSrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:47:09 -0500
Date: Fri, 6 Feb 2004 18:47:07 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: John Cherry <cherry@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.2 - 2004-02-05.22.30) - 3 New warnings (gcc 3.2.2)
Message-ID: <20040206184707.GL21151@parcelfarce.linux.theplanet.co.uk>
References: <200402061122.i16BMZ10009537@cherrypit.pdx.osdl.net> <20040206113305.GF21151@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402060850380.30672@home.osdl.org> <20040206182208.GI21151@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402061041190.30672@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402061041190.30672@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 10:42:00AM -0800, Linus Torvalds wrote:
> 
> 
> 
> On Fri, 6 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > Umm...  How about
> > 
> > static inline void BUG() __attribute__((noreturn));
> > 
> > static inline void BUG(void)
> > {
> > 	__asm__ ....
> > }
> 
> Did you try that? Last time I tried, gcc would complain every time it saw 
> the thing about "noreturn function does return".

So it does ;-/

Anyway, in both of those cases BUG() is gratitious.  What that code tries
to do is "if we decided to use one of the old modes, we'll need 3 ports;
otherwise we should claim 8".  So simple if() would be enough.  I'll send
a patch in a few.

It would be nice to have gcc understand that BUG() is a sink.  Oh, well...
