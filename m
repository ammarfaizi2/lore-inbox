Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbTIXAz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 20:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbTIXAz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 20:55:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51125 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261223AbTIXAz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 20:55:27 -0400
Date: Wed, 24 Sep 2003 01:55:26 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Deepak Saxena <dsaxena@mvista.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com.br
Subject: Re: [PATCH] Fix %x parsing in vsscanf()
Message-ID: <20030924005526.GQ7665@parcelfarce.linux.theplanet.co.uk>
References: <20030923212207.GA25234@xanadu.az.mvista.com> <Pine.LNX.4.44.0309231421450.24527-100000@home.osdl.org> <20030923213533.GN7665@parcelfarce.linux.theplanet.co.uk> <20030923221611.GA25464@xanadu.az.mvista.com> <20030923222632.GO7665@parcelfarce.linux.theplanet.co.uk> <20030924010258.GA24014@xanadu.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030924010258.GA24014@xanadu.az.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 06:02:58PM -0700, Deepak Saxena wrote:
> On Sep 23 2003, at 23:26, viro@parcelfarce.linux.theplanet.co.uk was caught saying:
> > The following, AFAICS, would be correct:
> > 
> >         if (*cp == '0') {
> >                 cp++;
> >                 if (unlikely((*cp == 'x' || *cp == 'X') && isxdigit(cp[1]))) {
> >                         if (!base || base == 16) {
> >                                 cp++;
> >                                 base = 16;
> >                         }
> >                 } else if (!base)
> >                         base = 8;
> >         } else if (!base)
> >                 base = 10;
> 
> We can remove everything but "base = 10;" from the second "else if"
> clause b/c by this point we're guaranteed that it's not a hex or
> octal value.

Bzzert.  strtoul() with e.g. base 8 on "1234" should parse it as octal.
