Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbTFGAxl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTFGAxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:53:41 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:6154 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262488AbTFGAvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:51:23 -0400
Date: Fri, 6 Jun 2003 22:06:01 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: __user annotations
Message-ID: <20030607010601.GF5554@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
References: <16097.12932.161268.783738@argo.ozlabs.ibm.com> <Pine.LNX.4.44.0306061738200.31112-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306061738200.31112-100000@home.transmeta.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 06, 2003 at 05:43:58PM -0700, Linus Torvalds escreveu:
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

In 3.3 this style is not accepted (haven't read the c99 draft to see if it is
OK)

struct foo {
	struct bar {
		int a, b;
	};
}

But this one is:

struct foo {
	struct /* bar */ {
		int a, b;
	}
}

Does anybody knows if gcc 3.3 behaviour is correct and the fact that gcc 3.2
accepts the former style was just a temporary bug?

- Arnaldo
