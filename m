Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWIZQmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWIZQmM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 12:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWIZQmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 12:42:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43694 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751544AbWIZQmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 12:42:11 -0400
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Martin Bligh <mbligh@google.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Karim Yaghmour <karim@opersys.com>, Pavel Machek <pavel@suse.cz>,
       Joe Perches <joe@perches.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.11 for 2.6.17
References: <20060925151028.GA14695@Krystal>
	<20060925160115.GE25296@redhat.com> <20060925232828.GA29343@Krystal>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 26 Sep 2006 12:39:38 -0400
In-Reply-To: <20060925232828.GA29343@Krystal>
Message-ID: <y0mr6xyeg51.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <compudj@krystal.dyndns.org> writes:

> [...]
> > I believe [printf formatting directives] are not
> > quite general enough either e.g. to describe a raw binary blob.
>
> If you want to dump a raw binary blob, what about :
> MARK(mysubsys_myevent, "char %p %u", blobptr, blobsize); where %p is
> a pointer to an array of char and %u the length ?

That involves new conventions beyond printf.  Why not "%p %p %u %u"
for two blobs ... or why implicitly dereference the given pointers.  A
probe handler unaware of a specific marker's semantics would not know
whether or not this is implied.


> My idea is to use the string to identify what is referred by a
> pointer, so it can be casted into this type with some kind of
> coherency between the marker and the probe.

I understand what you're using them for.  To me, they just don't look
like a good fit.


> > I realize they serve a useful purpose in abbreviating what otherwise
> > one might have to do (like that multiplicity of STAP_MARK_* type/arity
> > permutations).  [...]
> 
> I think that duplicating the number of marker macros could easily make
> them unflexible and ugly. [...]

Inflexible and ugly in what way?  Remember, the macro definitions can
be automatically generated.  At the macro call site, there needs to be
little difference.


> [...]  Good point, I will setup a va_args in the probe.  When
> correctly used, however, there is no need to use the format string :
> we can directly get the variables from the var arg list if we know
> in advance what the string will be.

Do I understand you correctly that the probe handlers would be given
va_list values, and would have to call va_arg to yank out individual
actual arguments?  So again type safety is a matter of explicit coding
(equivalent to correctly casting each type)?


- FChE
