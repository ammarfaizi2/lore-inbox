Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbSLKIJJ>; Wed, 11 Dec 2002 03:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267062AbSLKIJJ>; Wed, 11 Dec 2002 03:09:09 -0500
Received: from rth.ninka.net ([216.101.162.244]:21738 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267059AbSLKIJI>;
	Wed, 11 Dec 2002 03:09:08 -0500
Subject: Re: atyfb in 2.5.51
From: "David S. Miller" <davem@redhat.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0212102215450.2617-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0212102215450.2617-100000@maxwell.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 00:42:29 -0800
Message-Id: <1039596149.24691.2.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 22:18, James Simmons wrote:
> > AFAIK, the X "mach64" driver in XF 4.* doesn't care about UseFBDev.
> > Marc Aurele La France (maintainer of this driver) is basically allergic
> > to kernel fbdev support.
> 
> :-(

I've always stated that the whole fbdev model was flawed, it makes
basic assumptions about how a video card's memory and registers are
accessed (ie. the programming model) and many popular cards absolutely
do not fit into that model.

> I will have to go threw the X code to fix that :-(

There is nothing to fix.  You simply must restore the video state when
the last mmap() client goes away.  The __sparc__ code does exactly that.

I think relying on an application that mmap's a card to perfectly
restore the state would work in a perfect world, one we do not live
in.  Furthermore, fixing up the state like I am suggesting makes life
much simpler for people actually working on things like X servers and
other programs directly programming the ATI chip.

