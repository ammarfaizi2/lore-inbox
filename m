Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSIOUk2>; Sun, 15 Sep 2002 16:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318255AbSIOUk2>; Sun, 15 Sep 2002 16:40:28 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:63119 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S316684AbSIOUk1>; Sun, 15 Sep 2002 16:40:27 -0400
Date: Sun, 15 Sep 2002 22:06:51 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] binfmt_script: interpreted interpreter doesn't work
Message-ID: <20020915220651.C642@nightmaster.csn.tu-chemnitz.de>
Reply-To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
References: <Pine.GSO.4.30.0209151910220.22107-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.30.0209151910220.22107-100000@balu>; from pozsy@uhulinux.hu on Sun, Sep 15, 2002 at 07:15:38PM +0200
X-Spam-Score: -13.0 (-------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *17qgGh-00043K-00*Q/D0wLW0YDM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pozsar,

On Sun, Sep 15, 2002 at 07:15:38PM +0200, Pozsar Balazs wrote:
> This may well not be bug, rather an intended feature, but please enlighten
> me why the following doesn't work:
> 
> I have two scripts:
> /home/pozsy/a:
> #!/bin/sh
> echo "Hello from a!"
> 
> /home/pozsy/b:
> #!/home/pozsy/a
> echo "hello from b!"
> 
> Both of them has +x permissions.
> But I cannot execute the /home/pozsy/b script:
> 
> Isn't this "indirection" allowed?

Right, this isn't allowed to avoid eating kernel resources
without getting anything done.

Solution is to always compile an interpreter or to write 
a wrapper in C, which is compiled and calls the perl interpreter
with your perl script. This wrapper would be ANSI-C with really
basic POSIX extensions and should thus be as portable as perl ;-)

So you hide the indirection from the kernel this way.

Of course you now define the wrapper as the interpreter for your
perl scripts.

Hope that helps.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
