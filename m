Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWESNJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWESNJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 09:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWESNJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 09:09:57 -0400
Received: from nevyn.them.org ([66.93.172.17]:64899 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751294AbWESNJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 09:09:56 -0400
Date: Fri, 19 May 2006 09:09:52 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: Ulrich Drepper <drepper@gmail.com>, Andi Kleen <ak@suse.de>,
       osd@cs.unibo.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2-ptrace_multi
Message-ID: <20060519130952.GA1242@nevyn.them.org>
Mail-Followup-To: Renzo Davoli <renzo@cs.unibo.it>,
	Ulrich Drepper <drepper@gmail.com>, Andi Kleen <ak@suse.de>,
	osd@cs.unibo.it, linux-kernel@vger.kernel.org
References: <20060518155337.GA17498@cs.unibo.it> <20060518155848.GC17498@cs.unibo.it> <p73sln72im3.fsf@bragg.suse.de> <20060518211321.GC6806@cs.unibo.it> <a36005b50605181923k285b4d50y30d6b43baede95ca@mail.gmail.com> <20060519090726.GA11789@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060519090726.GA11789@cs.unibo.it>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 11:07:26AM +0200, Renzo Davoli wrote:
> On Thu, May 18, 2006 at 07:23:13PM -0700, Ulrich Drepper wrote:
> > On 5/18/06, Renzo Davoli <renzo@cs.unibo.it> wrote:
> > >e.g. To virtualize a write you'd have to call PTRACE_PEEKDATA for each
> > >word of the buffer, very many hundreds cycles lost.
> > 
> > No, this is not how programs should do it.  Just open /proc/PID/mem
> > and use pread() with an offset corresponding to the address.  Now,
> > repeat your timings using this technique.
> 
> That would be faster to access the memory but:
> - the manager has to keep one open file per controlled process

No, it doesn't.  It can open it as needed.  It can even maintain a
cache of open mem files.

GDB's been opening it as needed for years.  It works very well and is
drastically faster than PTRACE_PEEKDATA.

-- 
Daniel Jacobowitz
CodeSourcery
