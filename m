Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbTFGQgQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 12:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTFGQgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 12:36:15 -0400
Received: from crack.them.org ([146.82.138.56]:26079 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S263270AbTFGQgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 12:36:07 -0400
Date: Sat, 7 Jun 2003 12:49:36 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: __user annotations
Message-ID: <20030607164936.GA18862@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
References: <16097.12932.161268.783738@argo.ozlabs.ibm.com> <Pine.LNX.4.44.0306061738200.31112-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306061738200.31112-100000@home.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 05:43:58PM -0700, Linus Torvalds wrote:
> 
> On Sat, 7 Jun 2003, Paul Mackerras wrote:
> > Linus Torvalds writes:
> > 
> > > You can get check from
> > > 
> > > 	bk://kernel.bkbits.net/torvalds/sparse
> > 
> > Is that up to date?  I cloned that repository and said "make" and got
> > heaps of compile errors.  First there were a heap of warnings like
> > this:
> 
> You need to have a modern compiler. The "heaps of errors" is what you get 
> if you use a stone-age compiler that doesn't support anonymous structure 
> and union members or other C99 features.
> 
> Gcc has supported them since some pre-3.x version (which is pretty late,
> since they've been around in other compilers for much longer). They are a
> great way to make readable data structures that have internal structure
> _without_ having to have that structure show up unnecessarily in usage.

Actually, I believe they are an extension, which GCC honors.  Unnamed
structures in standard C99 are actually declaring an unnamed type, not
an unnamed member.  Try it:

     struct {
       int a;
       union {
         int b;
         float c;
       };
       int d;
     } foo;

int bar()
{
  return foo.a + foo.d + foo.b;
}


With -std=c99, the reference to foo.b is an error; with -std=gnu99 or
-std=gnu89, it is accepted.


I don't know why they were getting rejected for Paul, though.  Did you
have GNU set to -ansi mode?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
