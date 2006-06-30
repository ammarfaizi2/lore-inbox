Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWF3RPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWF3RPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 13:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWF3RPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 13:15:13 -0400
Received: from mailhost.alabanza.com ([209.239.39.56]:40334 "EHLO
	mailhost.alabanza.com") by vger.kernel.org with ESMTP
	id S932253AbWF3RPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 13:15:10 -0400
From: eclark <eclark@alabanza.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: problem with new kernel
Date: Fri, 30 Jun 2006 13:10:47 -0400
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200606301046.17526.eclark@alabanza.com> <1151685938.11434.51.camel@laptopd505.fenrus.org>
In-Reply-To: <1151685938.11434.51.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="euc-kr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301310.48075.eclark@alabanza.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excellent! How do I get NPTL built into the kernel. I had already been 
tohttp://people.redhat.com/~drepper/ this morning after googling my straces 
for a few hours, but nothing that indicated what needed to be done to get it 
into the kernel. Any assistance would be superb!
  
On Friday 30 June 2006 12:45 pm, Arjan van de Ven wrote:
> On Fri, 2006-06-30 at 10:46 -0400, eclark wrote:
> > Previous, I was using a RH stock kernel. This was rebuilt to be
> > monolithic with allthe required modules. However, now any binary which
> > uses set_thread_area segfaults. I know this is a kernel issue, as other
> > kernels I have used do not have this same issue. I am running 2.4.33-pre.
> > Below is an example strace of nslookup, one of the relevant binaries now
> > segfaulting. Above the big strace (total strace of nslookup) is where I
> > believe the problem is coming from. Any help would be appreciated, as I
> > have no clue what went wrong with this kernel build.
>
> Hi,
>
> you're running a kernel without NPTL support on a distribution that
> apparently expects NPTL support to be in the kernel... the failure mode
> isn't nice but failure at all isn't totally unexpected...... NPTL is
> needed for certain functionality and if a distribution expects that to
> be there.. things may well go very wonky if absent. (yes glibc tries to
> emulate this but the emulation is quite limited and not really possible)
>
> One example of such thing is cross-process mutexes and other locks; NPTL
> allows that (via futexes on shared pages), and things like rpm use this
> extensively. Another example is thread local storage; emulation is
> fragile via LDT's and such.
>
> Greetings,
>    Arjan van de Ven
