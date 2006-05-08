Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWEHEm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWEHEm6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 00:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWEHEm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 00:42:58 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32469
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932291AbWEHEm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 00:42:58 -0400
From: Rob Landley <rob@landley.net>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] Small patch to bloat-o-meter.
Date: Mon, 8 May 2006 00:43:51 -0400
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200605071559.00253.rob@landley.net> <20060508030216.GR15445@waste.org>
In-Reply-To: <20060508030216.GR15445@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605080043.51415.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 May 2006 11:02 pm, Matt Mackall wrote:
> > --- linux-old/scripts/bloat-o-meter	2006-05-07 15:47:23.000000000 -0400
> > +++ linux-2.6.16/scripts/bloat-o-meter	2006-05-07 15:08:31.000000000
> > -0400 @@ -18,7 +18,9 @@
> >      for l in os.popen("nm --size-sort " + file).readlines():
> >          size, type, name = l[:-1].split()
> >          if type in "tTdDbB":
> > -            sym[name] = int(size, 16)
> > +            if name.find(".") != -1: name = "static." +
> > name.split(".")[0]
>
> if "." in name:
>
> (just like 'if type in "tTdDbB":' above it)

I learned python over 5 years ago and the language has changed out from under 
me a bit.  When I've done a lot of C programming recently, I tend to fall 
back on the old ways... :)

> > +            if name in sym: sym[name] += int(size, 16)
> > +            else :sym[name] = int(size, 16)
>
> else:

I'm surprised that even ran...

> Actually, this probably wants to be:
>
> sym.setdefault(name, 0) += int(size, 16)

File "scripts/bloat-o-meter", line 22
  sym.setdefault(name, 0) += int(size, 16)
SyntaxError: can't assign to function call

Rob
-- 
Never bet against the cheap plastic solution.
