Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268060AbTB1SqG>; Fri, 28 Feb 2003 13:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268061AbTB1SqG>; Fri, 28 Feb 2003 13:46:06 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:47488 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S268060AbTB1SqF>; Fri, 28 Feb 2003 13:46:05 -0500
Date: Sat, 01 Mar 2003 07:59:36 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Software Suspend Functionality in 2.5
In-reply-to: <20030228151744.GB14927@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1046458775.1720.5.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1046238339.1699.65.camel@laptop-linux.cunninghams>
 <20030227181220.A3082@in.ibm.com>
 <1046369790.2190.9.camel@laptop-linux.cunninghams>
 <20030228121725.B2241@in.ibm.com>
 <20030228130548.GA8498@atrey.karlin.mff.cuni.cz>
 <20030228190924.A3034@in.ibm.com>
 <20030228134406.GA14927@atrey.karlin.mff.cuni.cz>
 <20030228204831.A3223@in.ibm.com>
 <20030228151744.GB14927@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-01 at 04:17, Pavel Machek wrote:
> > For the kind of atomicity you need there probably are two
> > steps:
> > 1) Quiesce the system - get to a point of consistency (when you
> >    can take a resumable snapshot)
> > 2) Perform an atomic copy / snapshot
> > 
> > Step (1) would be different for swsusp and crash dump (not
> > intended to be common ). But for Step (2), do you think
> > what you need/do is complicated by crashed system requirements ?
> 
> Well, I guess count_and_copy_data_pages() is easy to share, OTOH it is
> really small piece of code. Also do you think you can free half of
> memory in crashed system? Thats what swsusp currently does...
> 
> [I need really little about LKCD... But you are going to need modified
> disk drivers etc, right? I'd like to get away without that in swsusp,
> at least in 2.6.X.]
> 

With the changes I've made, which I'm starting to merge with Pavel, I
think the two are a lot closer to each other.

With regard to quiescing the system, we need the same things stopped
that you need. We can of course use drivers_suspend when you can't, but
we could probably also use the SMP code you have.

I've got swsusp so that freeing memory is not necessary - the whole
image can be written to disk. There is still an option for the user to
aim for a smaller image (a soft limit can be set), and if there's not
enough swap available, that will also cause some memory to be freed, but
LKCD would run into that problem writing to swap too.

Regards,

Nigel

