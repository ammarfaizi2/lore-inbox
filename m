Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268322AbTCCEM5>; Sun, 2 Mar 2003 23:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268324AbTCCEM5>; Sun, 2 Mar 2003 23:12:57 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:64727 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268322AbTCCEMy>;
	Sun, 2 Mar 2003 23:12:54 -0500
Date: Mon, 3 Mar 2003 09:58:24 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software Suspend Functionality in 2.5
Message-ID: <20030303095824.A2312@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1046238339.1699.65.camel@laptop-linux.cunninghams> <20030227181220.A3082@in.ibm.com> <1046369790.2190.9.camel@laptop-linux.cunninghams> <20030228121725.B2241@in.ibm.com> <20030228130548.GA8498@atrey.karlin.mff.cuni.cz> <20030228190924.A3034@in.ibm.com> <20030228134406.GA14927@atrey.karlin.mff.cuni.cz> <20030228204831.A3223@in.ibm.com> <20030228151744.GB14927@atrey.karlin.mff.cuni.cz> <1046458775.1720.5.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1046458775.1720.5.camel@laptop-linux.cunninghams>; from ncunningham@clear.net.nz on Sat, Mar 01, 2003 at 07:59:36AM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 07:59:36AM +1300, Nigel Cunningham wrote:
> On Sat, 2003-03-01 at 04:17, Pavel Machek wrote:
> > > For the kind of atomicity you need there probably are two
> > > steps:
> > > 1) Quiesce the system - get to a point of consistency (when you
> > >    can take a resumable snapshot)
> > > 2) Perform an atomic copy / snapshot
> > > 
> > > Step (1) would be different for swsusp and crash dump (not
> > > intended to be common ). But for Step (2), do you think
> > > what you need/do is complicated by crashed system requirements ?
> > 
> > Well, I guess count_and_copy_data_pages() is easy to share, OTOH it is
> > really small piece of code. Also do you think you can free half of
> > memory in crashed system? Thats what swsusp currently does...
> > 
> > [I need really little about LKCD... But you are going to need modified
> > disk drivers etc, right? I'd like to get away without that in swsusp,
> > at least in 2.6.X.]
> > 
> 
> With the changes I've made, which I'm starting to merge with Pavel, I
> think the two are a lot closer to each other.

Yes, I've noticed that, this is why it was in the context of 
your changes that I brought up the question.

> 
> With regard to quiescing the system, we need the same things stopped
> that you need. We can of course use drivers_suspend when you can't, but
> we could probably also use the SMP code you have.
> 
> I've got swsusp so that freeing memory is not necessary - the whole
> image can be written to disk. There is still an option for the user to
> aim for a smaller image (a soft limit can be set), and if there's not
> enough swap available, that will also cause some memory to be freed, but

If you add to that the possibility of being able to save more 
in less space if you have compression, would it be useful ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

