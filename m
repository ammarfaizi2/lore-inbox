Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316803AbSGBQCX>; Tue, 2 Jul 2002 12:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316820AbSGBQCW>; Tue, 2 Jul 2002 12:02:22 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:35286 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S316803AbSGBQCV>;
	Tue, 2 Jul 2002 12:02:21 -0400
Date: Tue, 2 Jul 2002 13:08:19 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Module removal
Message-ID: <20020702130819.G2295@almesberger.net>
References: <20020702123718.A4711@redhat.com> <Pine.LNX.3.96.1020702111607.27954E-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020702111607.27954E-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Tue, Jul 02, 2002 at 11:20:19AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> On Tue, 2 Jul 2002, Stephen C. Tweedie wrote:
> > Again, you might want to do this even with a non-modular driver, or if
> > you had one module driving two separate NICs --- the shutdown of one
> > card shouldn't necessarily require the removal of the module code from
> > the kernel, which is all Rusty was talking about doing.
[...]
> Also, as someone mentioned, it means a reboot every time you need to try
> something new while doing module development. That doesn't sound like a
> great idea...

They key phrase is "removal of the module code".
                                          ====
The proposal was to leave the code in the kernel, but to drop all
references such that it would not interfere with new versions of
the same module. The issue is strictly making sure *something* is
there, if an after-removal reference happens.

As I wrote in the other thread on this topic, it seems that only
the "return" case is truly module-specific. Since that one could
probably be fixed by other means, I don't quite see what not
freeing the memory area occupied by a module would really buy.

On the other hand, if there are cases where other after-removal
references can happen, this would also break other areas of the
kernel, and should be fixed no matter what happens with modules.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
