Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWIVCic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWIVCic (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWIVCic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:38:32 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:34505 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932238AbWIVCib convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:38:31 -0400
Date: Thu, 21 Sep 2006 22:38:28 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.7 for 2.6.17 (with type checking!)
Message-ID: <20060922023828.GA10291@Krystal>
References: <20060921232024.GA16155@Krystal> <451331A1.3020601@goop.org> <20060922020119.GA28712@Krystal> <45134539.7070305@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <45134539.7070305@goop.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 22:33:37 up 29 days, 23:42,  2 users,  load average: 0.13, 0.23, 0.18
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Mathieu Desnoyers wrote:
> >#define MARK_SYM(name) \
> >        do { \
> >                __label__ here; \
> >                volatile static void *__mark_kprobe_##name \
> >                        asm (MARK_CALL_PREFIX#name) \
> >                        __attribute__((unused)) = &&here; \
> >here: \
> >                do { } while(0); \
> >        } while(0)
> >
> >Which fixes the problem. Some tests showed me that the compiler does not 
> >unroll
> >an otherwise unrolled loop when this specific macro is called. (test done 
> >with
> >-funroll-all-loops).
> 
> Eh?  I thought you wanted to avoid changing the generated code?  
> Inhibiting loop unrolling could be a pretty large change...
> 

>From what I see in 2.6.17/2.6.18 makefiles, only -OS and -O2 are generally 
used by the build system (no -O3) and there is not use of -funroll-loops. I
guess it must not be so useful in this context.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
