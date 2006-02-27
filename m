Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWB0Vfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWB0Vfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWB0Vfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:35:55 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:26091 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751265AbWB0Vfy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:35:54 -0500
Subject: Re: Which of the virtualization approaches is more suitable for
	kernel?
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrey Savochkin <saw@sawoct.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Stanislav Protassov <st@sw.ru>,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Herbert Poetzl <herbert@13thfloor.at>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <m1ek1owllf.fsf@ebiederm.dsl.xmission.com>
References: <43F9E411.1060305@sw.ru>
	 <m1oe0wbfed.fsf@ebiederm.dsl.xmission.com>
	 <1141062132.8697.161.camel@localhost.localdomain>
	 <m1ek1owllf.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 13:35:48 -0800
Message-Id: <1141076148.10105.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 14:14 -0700, Eric W. Biederman wrote:
> I like the namespace nomenclature.  (It can be shorted to _space  or _ns).
> In part because it shortens well, and in part because it emphasizes that
> we are *just* dealing with the names.

When I was looking at this, I was pretending to be just somebody looking
at sysv code, with no knowledge of containers or namespaces.

For a person like that, I think names like _space or _ns are pretty much
not an option, unless those terms become as integral to the kernel as
things like kobjects.  

> You split the resolution at just ipc_msgs.  When I really think it should
> be everything ipcs deals with.

This was just the first patch. :)

> Performing the assignment inside the tasklist_lock is not something we
> want to do in do_fork().

Any particular reason why?  There seem to be a number of things done in
there that aren't _strictly_ needed under the tasklist_lock.  Where
would you do it?

> So it looks like a good start.  There are a lot of details yet to be filled
> in, proc, sysctl, cleanup on namespace release.  (We can still provide
> the create destroy methods even if we don't hook the up).

Yeah, I saved shm for last because it has the largest number of outside
interactions.  My current thoughts are that we'll need _contexts or
_namespaces associated with /proc mounts as well.  

> I think in this case I would put the actual namespace structure
> definition in util.h, and just put a struct ipc_ns in sched.h.

Ahhh, as in

	struct ipc_ns;

And just keep a pointer from the task?  Yeah, that does keep it quite
isolated.  

-- Dave


