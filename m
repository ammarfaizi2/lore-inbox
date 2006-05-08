Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWEHEwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWEHEwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 00:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWEHEwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 00:52:55 -0400
Received: from waste.org ([64.81.244.121]:54936 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932297AbWEHEwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 00:52:55 -0400
Date: Sun, 7 May 2006 23:48:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Small patch to bloat-o-meter.
Message-ID: <20060508044800.GV15445@waste.org>
References: <200605071559.00253.rob@landley.net> <20060508030216.GR15445@waste.org> <200605080043.51415.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605080043.51415.rob@landley.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 12:43:51AM -0400, Rob Landley wrote:
> On Sunday 07 May 2006 11:02 pm, Matt Mackall wrote:
> > > --- linux-old/scripts/bloat-o-meter	2006-05-07 15:47:23.000000000 -0400
> > > +++ linux-2.6.16/scripts/bloat-o-meter	2006-05-07 15:08:31.000000000
> > > -0400 @@ -18,7 +18,9 @@
> > >      for l in os.popen("nm --size-sort " + file).readlines():
> > >          size, type, name = l[:-1].split()
> > >          if type in "tTdDbB":
> > > -            sym[name] = int(size, 16)
> > > +            if name.find(".") != -1: name = "static." +
> > > name.split(".")[0]
> >
> > if "." in name:
> >
> > (just like 'if type in "tTdDbB":' above it)
> 
> I learned python over 5 years ago and the language has changed out from under 
> me a bit.  When I've done a lot of C programming recently, I tend to fall 
> back on the old ways... :)
> 
> > > +            if name in sym: sym[name] += int(size, 16)
> > > +            else :sym[name] = int(size, 16)
> >
> > else:
> 
> I'm surprised that even ran...
> 
> > Actually, this probably wants to be:
> >
> > sym.setdefault(name, 0) += int(size, 16)
> 
> File "scripts/bloat-o-meter", line 22
>   sym.setdefault(name, 0) += int(size, 16)
> SyntaxError: can't assign to function call

Oh, right. That's why I never do that.

sym[name] = sym.get(name, 0) + int(size, 16)

-- 
Mathematics is the supreme nostalgia of our time.
