Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261622AbTC0Xws>; Thu, 27 Mar 2003 18:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbTC0XwA>; Thu, 27 Mar 2003 18:52:00 -0500
Received: from cs.columbia.edu ([128.59.16.20]:28651 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S261622AbTC0XqJ>;
	Thu, 27 Mar 2003 18:46:09 -0500
Subject: Re: process creation/deletions hooks
From: Shaya Potter <spotter@yucs.org>
To: Nathan Straz <nstraz@sgi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030327213131.GA936@sgi.com>
References: <1048799290.31010.62.camel@zaphod>
	 <20030327213131.GA936@sgi.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048809375.30988.140.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Mar 2003 18:56:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the ideas are somewhat similar, but I'm viewing it more from a
module perspective that lets any module author implement something, so
it's not specialized, and hopefully has a better chance of getting in
the kernel (i.e. I think your system could work for this as well).

basically what I envision is something simple, in process creation and
deletion we do something like

item = some list_head;
while (item)
{
	item->function(task_struct);
	item = item->next;
}

so it has very little overhead into the actual kernel if it's not being
used (1 memory load and 1 compare/branch).

the way pagg would work (I think, just did a cursory reading) is that
instead of storing the data in the task_struct, you'd have a seperate
struct that deal with it.  Not as pretty in that regards, but also the
standard way modules that want to extend the linux kernel have to work,
and therefore hopefully linus would be willing to include it in his
kernel.

shaya

On Thu, 2003-03-27 at 16:31, Nathan Straz wrote:
> On Thu, Mar 27, 2003 at 04:08:10PM -0500, Shaya Potter wrote:
> > We are trying to write a module that does it's own accounting of
> > processes as they are created and deleted.  We have an extremely ugly
> > hack of taking care of process creation (wrap fork() and clone() in a
> > syscall wrapper, as that's the only way processes can be created).  
> 
> You might want to look at the PAGG patch.  SGI did something like this
> to implement CSA, an accounting package.  Here are some links that might
> interest you:
> 
> Linux PAGG home page:
> http://oss.sgi.com/projects/pagg/
> 
> Design Doc:
> http://oss.sgi.com/projects/pagg/pagg-lkd.txt

