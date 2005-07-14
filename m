Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVGNXFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVGNXFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVGNXDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:03:20 -0400
Received: from smtp05.auna.com ([62.81.186.15]:29858 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S263176AbVGNXC2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:02:28 -0400
Date: Thu, 14 Jul 2005 23:02:24 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Thread_Id
To: rvk@prodmail.net
Cc: Ian Campbell <ijc@hellion.org.uk>, Arjan van de Ven <arjan@infradead.org>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it>
	<42CB465E.6080104@shaw.ca> <42D5F934.6000603@prodmail.net>
	<1121327103.3967.14.camel@laptopd505.fenrus.org>
	<42D63916.7000007@prodmail.net>
	<1121337567.18265.26.camel@icampbell-debian>
	<42D6462B.8030706@prodmail.net> <1121339809.10537.6.camel@icampbell-debian>
In-Reply-To: <42D64B83.4000605@prodmail.net> (from rvk@prodmail.net on Thu
	Jul 14 13:24:51 2005)
X-Mailer: Balsa 2.3.4
Message-Id: <1121382144l.16874l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.215.11] Login:jamagallon@able.es Fecha:Fri, 15 Jul 2005 01:02:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.14, RVK wrote:
> Ian Campbell wrote:
> 
> >On Thu, 2005-07-14 at 16:32 +0530, RVK wrote:
> >  
> >
> >>Ian Campbell wrote:
> >>    
> >>
> >>>What Arjan is saying is that pthread_t is a cookie -- this means that
> >>>you cannot interpret it in any way, it is just a "thing" which you can
> >>>pass back to the API, that pthread_t happens to be typedef'd to unsigned
> >>>long int is irrelevant.
> >>>      
> >>>
> >>Do you want to say for both 2.6.x and 2.4.x I should interpret that way ?
> >>    
> >>
> >
> >As I understand it, yes, you should never try and assign any meaning to
> >the values. The fact that you may have been able to find some apparent
> >meaning under 2.4 is just a coincidence.
> >
> >  
> >
> Iam sorry I don't agree on this. This confusion have created only becoz 
> of the different behavior of pthread_self() on 2.4.18 and 2.6.x kernels. 
> And Iam looking for clarifying my doubt. I can't digest this at all.
> 

It is simple: none ever never told you that a pthread_t has nothing to do
with a pid. pthreads is a standard and portable implementation that
guarantees you can port _pthread_ code between posix systems. It uses
an internal opaque type to identify threads, but you should never relay on
it have nothing to do with pids. The fact that somewhere-in-time-in-some-os
the pthread_t equals the pid/tid/ etc is just pure chance. If you had
code relaying on this, it is just broken. Where is stated if pthread_t is
the tid, an index into a table internal to pthread library, a pointer
to an struct (mmm, bloken on 64 bits?) or what ?

Whatif:
- you swith kernels and thread library implementation ?
- you go solaris (it has user level threads ?)

I think one of the sources of the confussion is that:
- man pages about system calls talk about 'threads', but that should be
  read as 'sibling _processes_ created via clone(CLONE_THREAD) syscall'.
- man pages about phthreads library also talk about 'threads', but that
  should be read as 'posix threads created via pthread_create'.
And none guarantees that both 'threads' are the same.

If you just want to use gettid(), don't go further that clone().
If you use pthread_create(), forget about gettid().

(AFAIK ;) )

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam9 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


