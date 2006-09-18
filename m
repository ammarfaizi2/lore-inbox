Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965338AbWIRE0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965338AbWIRE0z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 00:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965340AbWIRE0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 00:26:55 -0400
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:46218 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S965338AbWIRE0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 00:26:54 -0400
Date: Mon, 18 Sep 2006 00:26:52 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060918042652.GB15930@Krystal>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu> <20060918024343.GA23149@Krystal> <20060918032120.GA13076@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060918032120.GA13076@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 00:22:02 up 26 days,  1:30,  2 users,  load average: 0.48, 0.46, 0.34
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> > >   static int x;
> > > 
> > >   void func(int a)
> > >   {
> > >        ...
> > >        MARK(event, a);
> > >        ...
> > >   }
> > > 
> > > if a dynamic tracer installs a probe into that MARK() spot, it will have 
> > > access to 'a', but it can also have access to 'x'. While a static 
> > > in-source markup for _static tracers_, if it also wanted to have the 'x' 
> > > information, would also have to add 'x' as a parameter:
> > > 
> > > 	MARK(event, a, x);
> > > 
> > 
> > Hi,
> >
> > If I may, if nothing marks the interest of the tracer in the "x" 
> > variable, what happens when a kernel guru changes it for y (because it 
> > looks a lot better). The code will not compile anymore when the markup 
> > marks the interest for x, when your "dynamic tracer" markup will 
> > simply fail to find the information. My point is that the markup of 
> > the interesting variables should follow code changes, otherwise it 
> > will have to be constantly updated elsewhere (hmm ? Documentation/ 
> > someone ?)
> 
> yeah - but it shows (as you have now recognized it too) that even static 
> markup for dynamic tracers _can_ be fundamentally different, just 
> because dynamic tracers have access to information that static tracers 
> dont.
> 
> (Karim still disputes it, and he is still wrong.)

The following example voids your example : there are ways to implement static
markers that *could* have access to those variables. (implementation detail)

int x = 5;

#define MARK(a) printk(a, x)

voi func(int a)
{
  ...
  MARK(a);
  ...
}

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
