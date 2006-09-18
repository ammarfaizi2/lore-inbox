Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965324AbWIRCnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965324AbWIRCnr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 22:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbWIRCnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 22:43:47 -0400
Received: from tomts20.bellnexxia.net ([209.226.175.74]:19948 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S965324AbWIRCnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 22:43:46 -0400
Date: Sun, 17 Sep 2006 22:43:43 -0400
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
Message-ID: <20060918024343.GA23149@Krystal>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060918011352.GB30835@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 22:37:21 up 25 days, 23:46,  2 users,  load average: 0.31, 0.20, 0.19
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> Karim, i dont usually reply if you insult me (and you've grown a habit 
> of that lately ), but this one is almost parodic. To understand my 
> point, please consider this simple example of a static in-source markup, 
> to be used by a dynamic tracer:
> 
>   static int x;
> 
>   void func(int a)
>   {
>        ...
>        MARK(event, a);
>        ...
>   }
> 
> if a dynamic tracer installs a probe into that MARK() spot, it will have 
> access to 'a', but it can also have access to 'x'. While a static 
> in-source markup for _static tracers_, if it also wanted to have the 'x' 
> information, would also have to add 'x' as a parameter:
> 
> 	MARK(event, a, x);
> 

Hi,

If I may, if nothing marks the interest of the tracer in the "x" variable, what
happens when a kernel guru changes it for y (because it looks a lot better). The
code will not compile anymore when the markup marks the interest for x, when
your "dynamic tracer" markup will simply fail to find the information. My point
is that the markup of the interesting variables should follow code changes,
otherwise it will have to be constantly updated elsewhere (hmm ? Documentation/
someone ?)

I would say that not marking a static variable just because it is less visually
intrusive is a not such a good thing to do. That's not because we *can* that we
*should*.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
