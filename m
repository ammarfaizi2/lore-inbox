Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSGBDE6>; Mon, 1 Jul 2002 23:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSGBDE5>; Mon, 1 Jul 2002 23:04:57 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:20181 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S316614AbSGBDE4>;
	Mon, 1 Jul 2002 23:04:56 -0400
Date: Tue, 2 Jul 2002 00:11:52 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RE2: [OKS] Module removal
Message-ID: <20020702001152.D2295@almesberger.net>
References: <20020701224034.C2295@almesberger.net> <31042.1025576745@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31042.1025576745@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, Jul 02, 2002 at 12:25:45PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> This is just one symptom of the overall problem, which is module code
> that adjusts its use count by executing code that belongs to the
> module.  The same problem exists on entry to a module function, the
> module can be removed before MOD_INC_USE_COUNT is reached.

Ah yes, now I remember, thanks. I filed that under "improper reference
tracking". After all, why would anybody hold an uncounted reference in
the first place ?

I can understand that the exact number of references may be unknown,
e.g. if I pass a reference to some registration function, which may in
turn hand it to third parties, but why wouldn't I know that there is
at least one reference ?

If some other module B hands out uncounted references on behalf of
some module A, it would seem natural for B to make sure that it
collects them before getting unloaded (and thereby releasing A).

> 1) Do the reference counting outside the module, before it is entered.

Evil, agreed ;-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
