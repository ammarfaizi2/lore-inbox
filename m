Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWEMMqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWEMMqN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWEMMqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:46:13 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:26637 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932404AbWEMMqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:46:13 -0400
Date: Sat, 13 May 2006 14:45:26 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Neil Brown <neilb@suse.de>
Cc: Stefan Smietanowski <stesmi@stesmi.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Mark Rosenstand <mark@borkware.net>, linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
Message-ID: <20060513124526.GJ11191@w.ods.org>
References: <20060513103841.B6683146AF@hunin.borkware.net> <1147517786.3217.0.camel@laptopd505.fenrus.org> <20060513110324.10A38146AF@hunin.borkware.net> <1147518432.3217.2.camel@laptopd505.fenrus.org> <87r72yi346.fsf@suzuka.mcnaught.org> <4465C2E8.8070106@stesmi.com> <17509.50441.790871.230011@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17509.50441.790871.230011@cse.unsw.edu.au>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 09:37:45PM +1000, Neil Brown wrote:
> On Saturday May 13, stesmi@stesmi.com wrote:
> > > 
> > > Every Unix I've ever seen works this way.  It'd be nice to have
> > > unreadable executable scripts, but no one's ever done it.
> > 
> > The solution would be to either stick bash in the kernel (YUCK!)
> > or to have the kernel basically copy the read-only script to /tmp
> > or somewhere else, set permissions to sane values and
> > /bin/sh /tmp/foo.a12345.
> 
> ... or open the script file (which there kernel has to do anyway),
> attach it to some unused fd (e.g. fd3) and pass  "/dev/fd/3" to the
> interpreter rather than "/the/shell/script".
> 
> Then the interpreter doesn't need to be able to open the file for
> read.

Not exactly, because people who would like to set their scripts to 111
will also set the shell to 111, which makes the process non-dumpable,
with /dev/fd/3 unreachable (it's a link to /proc/self/fd).

> However it isn't clear that this is really a gain, as the person
> running the script could use ptrace or similar to take a copy of the
> script, the bypassing the missing 'r' permission.
> 
> Mind you, with ptrace, it isn't too hard to get a copy of a normal
> executable that is mode '111'....
> 
> The whole concept of having files that are executable but not readable
> is completely broken - it gives the appearance of protection without
> the reality.
> 
> NeilBrown

Cheers,
Willy

