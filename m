Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311024AbSCPWEE>; Sat, 16 Mar 2002 17:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311023AbSCPWDo>; Sat, 16 Mar 2002 17:03:44 -0500
Received: from ns.suse.de ([213.95.15.193]:59406 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310912AbSCPWDi>;
	Sat, 16 Mar 2002 17:03:38 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nice values for kernel modules
In-Reply-To: <Pine.LNX.4.33.0203161300300.1089-100000@einstein.homenet.suse.lists.linux.kernel> <E16mICa-0006mr-00@the-village.bc.nu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 16 Mar 2002 23:03:36 +0100
In-Reply-To: Alan Cox's message of "16 Mar 2002 18:40:02 +0100"
Message-ID: <p73d6y4187b.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Ability to bypass the stupid commercial time-locked licences (at some time
> > wordperfect demo was locked like that and my timetravel module turned a
> > demo into full product -- users were happy, at least according to emails I
> > received :)
> 
> Not any more. Under the DMCA your time travel module probably makes you
> a fugtive from US justice 8)
> 
> In general though calling into the syscall table by hand is a bad move. If
> the function you are calling is generically useful then its much better to
> work out whether the real function should be exported.

Some programs depends on tapping the system call table. For example private
ice and oprofile do this for execve and other calls to know when a new 
process is started. It would be possible to add function pointers to all these
functions, but just tapping the system call table actually looks cleaner
to me. 

[yes, the approach has module unload races, but these modules tend to just 
make themselves not unloadable]

-Andi
