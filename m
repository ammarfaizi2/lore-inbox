Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293611AbSCERaZ>; Tue, 5 Mar 2002 12:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293628AbSCERaP>; Tue, 5 Mar 2002 12:30:15 -0500
Received: from ASYNC3-CS1.NET.CS.CMU.EDU ([128.2.188.131]:13572 "EHLO
	mentor.odyssey.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S293611AbSCERaI>; Tue, 5 Mar 2002 12:30:08 -0500
Date: Tue, 5 Mar 2002 12:30:03 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
Message-ID: <20020305173003.GA645@mentor.odyssey.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020304232806.A31622@redhat.com> <200203051443.JAA02119@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203051443.JAA02119@ccure.karaya.com>
User-Agent: Mutt/1.3.27i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 09:43:39AM -0500, Jeff Dike wrote:
> bcrl@redhat.com said:
> > you only need to do the memsets once at  startup of UML where the ram
> > is allocated -> a uml booted with 64MB of  ram would write into every
> > page of the backing store file before even  running the kernel.
> > Doesn't that accomplish the same thing?
> 
> The other reason I don't like this is that, at some point, I'd like to
> start thinking about userspace cooperating with the kernel on memory
> management.  UML looks like a perfect place to start since it's essentially
> identical to the host making it easier for the two to bargain over memory.

I could use the same thing in Coda, we have large private memory
mappings that are backed by a file which isn't always up-to-date. But we
can make it so by applying the logged modifications. If there is some
'memory pressure' signal we could apply the log and remap the memory to
reduce swap usage.

On the other hand, applying the logged modifications generates a lot of
write activity which could push the system over the edge, so the current
method of having a large amount of swap available is probably more
reliable. Otherwise we'll get the whole OOM killer debate again (the
pre-OOM signaller?).

Jan

