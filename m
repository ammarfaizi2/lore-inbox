Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318256AbSIOU7O>; Sun, 15 Sep 2002 16:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318257AbSIOU7O>; Sun, 15 Sep 2002 16:59:14 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:63131 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S318256AbSIOU7N>;
	Sun, 15 Sep 2002 16:59:13 -0400
Date: Sun, 15 Sep 2002 23:04:02 +0200 (MEST)
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] binfmt_script: interpreted interpreter doesn't work
In-Reply-To: <20020915220651.C642@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.GSO.4.30.0209152301110.22107-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002, Ingo Oeser wrote:

> Hi Pozsar,
>
> On Sun, Sep 15, 2002 at 07:15:38PM +0200, Pozsar Balazs wrote:
> > This may well not be bug, rather an intended feature, but please enlighten
> > me why the following doesn't work:
> >
> > I have two scripts:
> > /home/pozsy/a:
> > #!/bin/sh
> > echo "Hello from a!"
> >
> > /home/pozsy/b:
> > #!/home/pozsy/a
> > echo "hello from b!"
> >
> > Both of them has +x permissions.
> > But I cannot execute the /home/pozsy/b script:
> >
> > Isn't this "indirection" allowed?
>
> Right, this isn't allowed to avoid eating kernel resources
> without getting anything done.
>
> Solution is to always compile an interpreter or to write
> a wrapper in C, which is compiled and calls the perl interpreter
> with your perl script. This wrapper would be ANSI-C with really
> basic POSIX extensions and should thus be as portable as perl ;-)
>
> So you hide the indirection from the kernel this way.
>
> Of course you now define the wrapper as the interpreter for your
> perl scripts.
>
> Hope that helps.

Ok, using a C wrapper I can workaround the problem. But that is ugly,
and I do not see the point why cannot be the indirection level, say, 5.

I have also had a look at fs/exec.c and fs/binfmt_script.c and I cannot
see where the 1-level comes from. Could anyone explain?

-- 
pozsy

