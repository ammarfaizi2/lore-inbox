Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751951AbWISTNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbWISTNX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbWISTNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:13:23 -0400
Received: from tomts40.bellnexxia.net ([209.226.175.97]:55990 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751951AbWISTNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:13:22 -0400
Date: Tue, 19 Sep 2006 15:13:20 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Tom Zanussi <zanussi@us.ibm.com>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       systemtap@sources.redhat.com, ltt-dev@shafik.org
Subject: Re: [PATCH] Linux Kernel Markers 0.2 for Linux 2.6.17
Message-ID: <20060919191320.GB30556@Krystal>
References: <20060919183447.GA16095@Krystal> <Pine.LNX.4.58.0609191140370.5184@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0609191140370.5184@shark.he.net>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 15:00:03 up 27 days, 16:08,  7 users,  load average: 0.28, 0.20, 0.19
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thanks for the comments, see below :

* Randy.Dunlap (rdunlap@xenotime.net) wrote:
> > +static inline void __mark_check_format(const char *fmt, ...)
> > +	__attribute__ ((format (printf, 1, 2)));
> > +void __mark_check_format(const char *fmt, ...) {  }
> 
> That last line is confusing (to me).  What's it for?
> Is it just an empty (inline) function definition?
> If so, why repeat the void + function name?
> 

The goal of this "empty" function is just to have to compiler check the string
format consistency.

I separated the function declaration and implementation because I have seen some
compilers complain about having the two merged together.

I will change it to

static inline __attribute__ ((format (printf, 1, 2)))
void __mark_check_format(const char *fmt, ...)
{ }

And hope every compiler will like it.

The empty implementation is because the function is called (must therefore be
implemented), but I expect the compiler to completely optimize it away.

> > --- /dev/null
> > +++ b/kernel/Kconfig.marker
> > @@ -0,0 +1,75 @@
> > +# Code markers configuration
> > +
> > +menu "Marker configuration"
> > +
> > +
> > +config MARK
> > +	bool "Enable MARK code markers"
> > +	default y
> 
> Please justify using 'y' as the default value.
> 

It has to be debated. The default for markers will put a symbol for all the
markers, so that kprobe can easily attach to it. It has no impact that I am
aware of except to boost the number of symbols.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
