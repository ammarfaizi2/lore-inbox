Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbSJUP6g>; Mon, 21 Oct 2002 11:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSJUP6g>; Mon, 21 Oct 2002 11:58:36 -0400
Received: from crack.them.org ([65.125.64.184]:31753 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S261442AbSJUP6e>;
	Mon, 21 Oct 2002 11:58:34 -0400
Date: Mon, 21 Oct 2002 12:04:36 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Mark Gross <markgross@thegnar.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
Message-ID: <20021021160436.GA31985@nevyn.them.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	S Vamsikrishna <vamsi_krishna@in.ibm.com>,
	Mark Gross <markgross@thegnar.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200210081627.g98GRZP18285@unix-os.sc.intel.com> <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain> <20021017164040.GA12608@nevyn.them.org> <1035210573.28189.127.camel@irongate.swansea.linux.org.uk> <20021021145432.GA22470@nevyn.them.org> <1035216987.27309.195.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035216987.27309.195.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 05:16:27PM +0100, Alan Cox wrote:
> On Mon, 2002-10-21 at 15:54, Daniel Jacobowitz wrote:
> > On Mon, Oct 21, 2002 at 03:29:33PM +0100, Alan Cox wrote:
> > > On Thu, 2002-10-17 at 17:40, Daniel Jacobowitz wrote:
> > > > My only problem with this is that you're waiting for all threads by
> > > > SIGKILLing them.  If a process vforks or clones, and then the child
> > > > crashes, the parent will receive a SIGKILL - iff we are dumping core. 
> > > > That's a change in behavior that seems a bit too arbitrary to me.
> > > 
> > > It also has a security impact when you construct a fork/fork/crash
> > > sequence that sends sigkill to the module loader or a kernel thread
> > > during start up that has not yet dropped its association with the user
> > > code.
> > 
> > Why?  It's not like userspace couldn't send that SIGKILL on its own,
> > right?  If it's still killable it had better be safe to do so.
> 
> The kernel side isnt, the signal handling isnt always "normal". Its the
> extreme case of the problem not the general one. Fixing the vfork/clone
> crash is doable, and one approach would be to solve the problem by
> saying "if you claim to be a thread group with the new style flags you
> get to be killed as a group and dumped as a group", with old stuff
> behaving like it always did before.

Which is what I'm trying to avoid... most of the world isn't using
CLONE_THREAD yet.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
