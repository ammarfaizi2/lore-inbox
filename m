Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSGBI5i>; Tue, 2 Jul 2002 04:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315375AbSGBI5h>; Tue, 2 Jul 2002 04:57:37 -0400
Received: from codepoet.org ([166.70.99.138]:906 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315278AbSGBI5f>;
	Tue, 2 Jul 2002 04:57:35 -0400
Date: Tue, 2 Jul 2002 03:00:03 -0600
From: Erik Andersen <andersen@codepoet.org>
To: William Lee Irwin III <wli@holomorphy.com>, Timo Benk <t_benk@web.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: allocate memory in userspace
Message-ID: <20020702090002.GA6370@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Timo Benk <t_benk@web.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20020701172659.GA4431@toshiba> <20020701174913.GA19338@codepoet.org> <20020702083737.GQ22961@holomorphy.com> <20020702084418.GR22961@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020702084418.GR22961@holomorphy.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jul 02, 2002 at 01:44:18AM -0700, William Lee Irwin III wrote:
> On Mon, Jul 01, 2002 at 11:49:13AM -0600, Erik Andersen wrote:
> >> void *malloc(size_t size)
> >> {
> >>     void *result;
> >>     if (size == 0)
> >> 	return NULL;
> >>     result = mmap((void *) 0, size + sizeof(size_t), PROT_READ | PROT_WRITE, 
> >> 	    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> >>     if (result == MAP_FAILED)
> >> 	return 0;
> >>     * (size_t *) result = size;
> >>     return(result + sizeof(size_t));
> >> }
> 
> On Tue, Jul 02, 2002 at 01:37:37AM -0700, William Lee Irwin III wrote:
> > This looks like a very bad idea. Userspace allocators should make some
> > attempt at avoiding diving into the kernel at every allocation like this.
> 
> Sorry, I also forgot the rather severe internal fragmentation this is
> likely to suffer due to page-level restrictions on mmap's operation.

Of course.  No question there -- actually using such an allocator
(with a standard linux kernel) would be a terrible idea.  I was
merely providing a trivial answer to his question on how to use
mmap to allocate memory.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
