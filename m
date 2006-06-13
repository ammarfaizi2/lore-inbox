Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWFMLqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWFMLqD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 07:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWFMLqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 07:46:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40368 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751098AbWFMLqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 07:46:02 -0400
Date: Tue, 13 Jun 2006 04:45:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@sgi.com>
Cc: ak@suse.de, mingo@elte.hu, michal.k.k.piotrowski@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
Message-Id: <20060613044532.29e10a31.akpm@osdl.org>
In-Reply-To: <10021.1150175320@kao2.melbourne.sgi.com>
References: <200606130656.45511.ak@suse.de>
	<10021.1150175320@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006 15:08:40 +1000
Keith Owens <kaos@sgi.com> wrote:

> Andi Kleen (on Tue, 13 Jun 2006 06:56:45 +0200) wrote:
> >
> >> I have previously suggested a lightweight solution that pins a process
> >> to a cpu 
> >
> >That is preempt_disable()/preempt_enable() effectively
> >It's also light weight as much as these things can be.
> 
> The difference being that preempt_disable() does not allow the code to
> sleep.  There are some places where we want to use cpu local data and
> the code can tolerate preemption and even sleeping, as long as the
> process schedules back on the same cpu.

It would be easy to use this mechanism wrongly:

	thread 1 on CPU N		thread 2 on CPU N

	foo = per_cpu(...)
	<preempt>
					foo = per_cpu(...);
					foo++;
					per_cpu(...) = foo;
					<unpreempt>
	foo++;
	per_cpu(...) = foo;	// whoops


In which scenarios did you envisage it being used?
