Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758562AbWLADq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758562AbWLADq5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 22:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758543AbWLADq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 22:46:57 -0500
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:13954 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1758562AbWLADq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 22:46:56 -0500
Date: Thu, 30 Nov 2006 22:41:43 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Paul Mundt <lethal@linux-sh.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 1/2] atomic.h atomic64_t standardization
Message-ID: <20061201034143.GA11388@Krystal>
References: <20061124215518.GE25048@Krystal> <20061127165643.GD5348@infradead.org> <20061201031153.GA10835@Krystal> <20061201033423.GB27639@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061201033423.GB27639@linux-sh.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 22:38:53 up 100 days, 46 min,  2 users,  load average: 0.17, 0.40, 0.37
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul Mundt (lethal@linux-sh.org) wrote:
> On Thu, Nov 30, 2006 at 10:11:53PM -0500, Mathieu Desnoyers wrote:
> > --- a/include/asm-generic/atomic.h
> > +++ b/include/asm-generic/atomic.h
> [snip]
> > +#if 0
> > +/* Atomic add unless is only effective on atomic_t on powerpc (at least) */
> > +static inline long atomic_long_add_unless(atomic_long_t *l, long a, long u)
> > +{
> > +	atomic_t *v = (atomic_t *)l;
> > +	
> > +	return atomic_add_unless(v, a, u);
> > +}
> > +
> > +static inline long atomic_long_inc_not_zero(atomic_long_t *l)
> > +{
> > +	atomic_t *v = (atomic_t *)l;
> > +	
> > +	return atomic_inc_not_zero(v);
> > +}
> > +#endif //0
> > +
> 
> Why is this in the patch?
> 

Oops, I forgot to remove these comments after I fixed it in the powerpc code.
Code for all other architectures will have to modified too : I just modified
i386, x86_64, mips, arm and powerpc.

Thanks for reporting.

Mathieu


Here is the fix :


--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -122,22 +122,19 @@ static inline long atomic_long_dec_retur
 	return atomic64_dec_return(v);
 }
 
-#if 0
-/* Atomic add unless is only effective on atomic_t on powerpc (at least) */
 static inline long atomic_long_add_unless(atomic_long_t *l, long a, long u)
 {
-	atomic_t *v = (atomic_t *)l;
+	atomic64_t *v = (atomic64_t *)l;
 	
-	return atomic_add_unless(v, a, u);
+	return atomic64_add_unless(v, a, u);
 }
 
 static inline long atomic_long_inc_not_zero(atomic_long_t *l)
 {
-	atomic_t *v = (atomic_t *)l;
+	atomic64_t *v = (atomic64_t *)l;
 	
-	return atomic_inc_not_zero(v);
+	return atomic64_inc_not_zero(v);
 }
-#endif //0
 
 #else
 


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
