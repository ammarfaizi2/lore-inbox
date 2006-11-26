Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758009AbWKZWTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758009AbWKZWTf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 17:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758008AbWKZWTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 17:19:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:39354 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1758009AbWKZWTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 17:19:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XXINd3nKmAz29v/x9eqk5Ry5yeQBvfMJoyzOPAMDW4Lfb5Scm8OMZTV3IX/rh/25c2VAp4OGN6ck//+ltMqK1W8NZ74UMBDrev0CfaEveWePZms/GDuDKFQq84DcY35QzTxTp1Grj/EG9uABpDI5qnm0D6kxaR03NvLl+BUdJEw=
Message-ID: <21d7e9970611261419s12da9881h1f19adcf11756769@mail.gmail.com>
Date: Mon, 27 Nov 2006 09:19:32 +1100
From: "Dave Airlie" <airlied@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>, "Adam Jackson" <ajax@nwnk.net>
Subject: Re: Overriding X on panic
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Casey Dahlin" <cjdahlin@ncsu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20061126142213.52c292d3@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1164434093.10503.2.camel@localhost.localdomain>
	 <1164443561.3147.54.camel@laptopd505.fenrus.org>
	 <20061125161043.18f1b68d@localhost.localdomain>
	 <1164529121.3147.65.camel@laptopd505.fenrus.org>
	 <20061126142213.52c292d3@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> On Sun, 26 Nov 2006 09:18:41 +0100
> Arjan van de Ven <arjan@infradead.org> wrote:
> > > The mode switch sequences for modern cards are a bit more hairy than
> > > lists of I/O poking unfortunately.
> >
> > for the Intel hw Keith doesn't seem to think it's all that much of a
> > problem though...
>
> Including the TV out, odder LCD panels, non BIOS modes etc ? If so then
> it might be an interesting test case for intelfb to grow some kind of
> console helper interface
>

It's non-trivial, I think you are better off going initially with just
using the current framebuffer that X is using, I know ajax was doing
some hacking on this with a "user"-framebuffer, until I disuaded him
due to I think the trouble caused by dual-head and something else I
can't remember..

I personally think we need to probably just bite the bullet and start
sticking graphics drivers into the kernel, the new randr-1.2 interface
for X is probably a good starting point for a generic mode setting
interface that isn't so X dependent and could replace fbdev with
something more sane wrt dualhead and multiple outputs... fbdev could
be implemented on top of that layer then.. also suspend/resume really
needs this sort of thing....

My main worry with integrating graphics drivers into the kernel is
that when they don't work the user gets no screen, with network/sound
etc this isn't so bad, but if they can't see a screen debugging gets
to be a bit more difficult....

Dave.
