Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVAFF13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVAFF13 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVAFF12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:27:28 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36761 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262734AbVAFF0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:26:52 -0500
To: Itsuro Oda <oda@valinux.co.jp>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Yet another crash dump tool
References: <20041014074718.26E6.ODA@valinux.co.jp>
	<m1sm5xusxk.fsf@ebiederm.dsl.xmission.com>
	<20050106093723.6C35.ODA@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Jan 2005 22:25:34 -0700
In-Reply-To: <20050106093723.6C35.ODA@valinux.co.jp>
Message-ID: <m1y8f7nn75.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itsuro Oda <oda@valinux.co.jp> writes:

> Hi,
> 
> On 23 Dec 2004 04:59:03 -0700
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
> > developed right now.  Would you be willing to work on the kexec system
> > call so we can get a infrastructure that reliably does what is needed
> > for everyone? 
> 
> We concentrate on the fault analysis. We think the original aim of the
> kexec (== fastboot) differ from the caputuring dump. However,
> since we apply the effort of the kexec project to mkdump, we are happy
> to return something to the kexec project. 

As a whole it has always been a goal.  The functionality was first
prototyped with kexec predecessor mcore.   At OLS this year there
appears to have been a lot of discussion the consensus reached was
that a kexec type mechanism was the way to go.  From comments Andrew
Morton has made I know it is something he would like to see.

Hariprasad Nellitheertha <hari@in.ibm.com>, and Vivek Goyal
<vgoyal@in.ibm.com> have recently been working on getting  the crash
dump case working.

Personally the crash dump case is not a large motivator but at the
same time I find handling the general case is quite important.
Currently I am in the process of cleaning things up and simplifying
them so hopefully we have something interesting.

> > Reading your documentation it seems to indicate that you have
> > successfully avoid using any memory that the crashing kernel used.
> > Is that correct?
> 
> No. If the code or the data structures running from crash occur to the
> mini kernel start (although it is very short) is damaged, starting the 
> mini kernel will fail.
> What we done (and will do partialy) is that the logical possibility of 
> the deadlock/hang condition is eliminated from the code running from 
> crash occur to the mini kernel start.

Let me clarify my question.

One of the problems  Hariprasad and Vivek seem to have been having is
that the keeping the crash dump kernel from using the first 1M.  You
have avoided that problem correct?

> > And just for a little active feedback.  While you safely tuck
> > your kernel away in your reserved area of memory it does not appear
> > you tuck away the data structures necessary to get there.  Which
> > makes me just a little nervous.
> 
> What do you mean "the data structures necessary to get there" ?
> The necessary information to run the mini kernel and to caputure dump 
> is stored in the reserved area at the same time of loading the mini kernel
> (during the kernel is normal).

As I recall from looking at your patch and it was obviously your last
version was that you were using kmalloc or get_free_pages for some 
of your data structures that controlled the loaded of the mini kernel
instead of allocating those data structures from the reserved area.

I'm not quite there as currently I have one structure still not
allocated in the reserved area.  But everything else is.

As soon as I can manage to focus I will have a new patch set out.

Eric
