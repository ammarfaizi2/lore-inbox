Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTEEKND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 06:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbTEEKND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 06:13:03 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:61961 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261153AbTEEKNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 06:13:02 -0400
Date: Mon, 5 May 2003 11:25:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030505112531.B16914@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Terje Eggestad <terje.eggestad@scali.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
References: <1052122784.2821.4.camel@pc-16.office.scali.no> <20030505092324.A13336@infradead.org> <1052127216.2821.51.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052127216.2821.51.camel@pc-16.office.scali.no>; from terje.eggestad@scali.com on Mon, May 05, 2003 at 11:33:36AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 11:33:36AM +0200, Terje Eggestad wrote:
> 1. performance is everything. 

then Linux is the wrong OS for you :)

> 2. We're making a MPI library, and as such we don't have any control
> with the application. 

I can't remember that the MPI spec tells anything about intercepting
syscalls..

> 3b. the performance loss from copying from a receive area to the
> userspace buffer is unacceptable. 
> 3c. It's therefore necessary for HW to access user pages. 
> 4. In order to to 3, the user pages must be pinned down. 
> 5. the way MPI is written, it's not using a special malloc() to allocate
> the send receive buffers. It can't since it would break language binding
> to fortran. Thus ANY writeable user page may be used. 

so use get_user_pages.

> 6. point 4: pinning is VERY expensive (point 1), so I can't pin the
> buffers every time they're used. 

Umm, pinning memory all the time means you get a bunch of nice DoS
attachs due to the huge amount of memory.

> 7. The only way to cache buffers (to see if they're used before and
> hence pinned) is the user space virtual address. A syscall, thus ioctl
> to a device file is prohibitive expensive under point 1.  

That's a horribly b0rked approach..

Again, where's your driver source so we can help you to find a better
approach out of that mess?
 
