Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265694AbTFNRiU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 13:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265695AbTFNRiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 13:38:20 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:40445 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265694AbTFNRiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 13:38:19 -0400
Subject: Re: [RFC] recursive pagetables for x86 PAE
From: Dave Hansen <haveblue@us.ibm.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <200306141327.48649.oliver@neukum.org>
References: <1055540875.3531.2581.camel@nighthawk>
	 <200306141327.48649.oliver@neukum.org>
Content-Type: text/plain
Organization: 
Message-Id: <1055612996.3531.3270.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 Jun 2003 10:49:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-14 at 04:27, Oliver Neukum wrote:
> Am Freitag, 13. Juni 2003 23:47 schrieb Dave Hansen:
> > The following patches implement something which we like to call UKVA.
> > It's a Kernel Virtual Area which is private to a process, just like
> > Userspace.  You can put any process-local data that you want in the
> > area.  But, for now, I just put PTE pages in there.
> 
> If you put only such pages there, do you really want that memory to
> be per task? IMHO it should be per memory context to aid threading
> performance.

I think you're confusing what I mean by tasks and processes.  A task is
something with a task_struct and a kernel stack.  A process is a single
task, or multiple tasks that share an mm.   If things share an mm, they
share pagetables implicitly.  Per-process _is_  per memory context.

> Secondly, doesn't this scream for using large pages?

Large pages aren't used for generic user memory at all.  That would take
some serious surgery.  (Don't get Bill started on it :)

-- 
Dave Hansen
haveblue@us.ibm.com

