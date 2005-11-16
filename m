Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbVKPAXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbVKPAXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 19:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbVKPAXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 19:23:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57092 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965102AbVKPAXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 19:23:49 -0500
Date: Wed, 16 Nov 2005 01:23:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC] HOWTO do Linux kernel development - take 2
Message-ID: <20051116002348.GL5735@stusta.de>
References: <20051115210459.GA11363@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115210459.GA11363@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 01:05:00PM -0800, Greg KH wrote:

> Here's an updated version of the "HOTO do Linux kernel development"
> document that I've been working on.
>...

Good idea :-)

Some comments below.

>...
> Introduction
> ------------
>...
> The kernel is written mostly in C, with some architecture-dependent
> parts written in assembly. A good understanding of C is required for
> kernel development.  Assembly (any architecture) is not required unless
> you plan to do low-level development for that architecture.  Though they
> are not a good substitute for a solid C education and/or years of
> experience, the following books are good for, if anything, reference:
>  - "The C Programming Language" by Kernighan and Ritchie [Prentice Hall]
>  - "Practical C Programming" by Steve Oualline [O'Reilly]
>  - "Programming the 80386" by Crawford and Gelsinger [Sybek]
>  - "UNIX Systems for Modern Architectures" by Curt Schimmel [Addison Wesley]


"UNIX Systems for Modern Architectures" is a good book about cpu caches.

But it's hardly interesting for the average driver writer and even less 
a book about C programming.


LDD (as you might have heard, it's also available online for free ;-) )
and the book by Robert Love are good starting points for learning kernel 
programming, and they should IMHO be listed here.


> The kernel is written using GNU C and the GNU toolchain.  While it
> adheres to the ISO C89 standard, it uses a number of extensions that are
> not featured in the standard.  The kernel is a freestanding C
> environment, with no reliance on the standard C library, so some
> portions of the C standard are not supported.  Arbitrary long long
> divisions and floating point are not allowed.  It can sometimes be
> difficult to understand the assumptions the kernel has on the toolchain
> and the extensions that it uses, and unfortunately there is no
> definitive reference for them.  Please check the gcc info pages (`info
> gcc`) for some information on them.
> 
> Please remember that you are trying to learn how to work with the
> existing development community.  It is a very diverse group of people,
> with very high standards for coding, style and procedure.  These


I'd drop the "very", it sounds a bit arrogant.


> standards have been created over time based on what they have found to
> work best for such a large and geographically dispersed team.  Try to
> learn as much as possible about these standards ahead of time, as they
> are well documented; do not expect people to adapt to you or your
> company's way of doing things.
> 
> 
> Legal Issues
> ------------
> 
> The Linux kernel source code is released under the GPL.  Please see the
> file, COPYING, in the main directory of the source tree, for details on
> the license.  If you have further questions about the license, please
> contact a lawyer, and do not ask on the Linux kernel mailing list.  The
> people on the mailing lists are not lawyers, and you should not rely on
> their statements on legal matters.


I understand this "ask your lawyer" regarding non-free modules.

But for many of the other GPL questions a link to
  http://www.gnu.org/licenses/gpl-faq.html
might help.


>...
> Becoming A Kernel Developer
> ---------------------------
>...
> If you already have a chunk of code that you want to put into the kernel
> tree, but need some help getting it in the proper form, the
> kernel-mentors project was created to help you out with this.  It is a
> mailing list, and can be found at:
> 	http://selenic.com/mailman/listinfo/kernel-mentors


This list seems to be nearly dead, and it seems the following one is now 
used instead:
   http://mail.nl.linux.org/kernelnewbies/


>...
> Bug Reporting
> -------------
> 
> bugzilla.kernel.org is where the Linux kernel developers track kernel
> bugs.  Users are encouraged to report all bugs that they find in this
> tool.


Please add a reference to
  http://test.kernel.org/bugzilla/faq.html


>...
> Working with the community
> --------------------------
> 
> The goal of the kernel community is to provide the best possible kernel
> there is.  When you submit a patch for acceptance, it will be reviewed
> on its technical merits and those alone.  So, what should you be
> expecting?
>   - criticism
>   - comments
>   - requests for change
>   - requests justification
>   - silence
> 
> Remember, this is part of getting your patch into the kernel.  You have
> to be able to take criticism and comments about your patches, evaluate
> them at a technical level and either rework your patches or provide
> clear and concise reasoning as to why those changes should not be made.
> If there are no responses to your posting, wait a few days and try
> again, sometimes things get lost in the huge volume.
> 
> What should you not do?
>   - expect your patch to be accepted without question
>   - become defensive
>   - ignore comments
>   - resubmit the patch without making any of the requested changes
> 
> In a community that is looking for the best technical solution possible,
> there will always be differing opinions on how beneficial a patch is.
> You have to be cooperative, and willing to adapt your idea to fit within
> the kernel.  Or at least be willing to prove your idea is worth it.
> Remember, being wrong is acceptable as long as you are willing to work
> toward a solution that is right.


Can you add something like:

It's normal that the answers to your first patch might simply be a list 
of a dozen things you should correct. This does _not_ imply that your 
patch will not be accepted, and it is _not_ meant against you 
personally. Simply correct all issues raised against your patch and 
resend it.


> Differences between the kernel community and corporate structures
> -----------------------------------------------------------------
> 
> The kernel community works differently than most traditional corporate
> development environments.  Here are a list of things that you can try to
> do to try to avoid problems:
>   Good things to say regarding your proposed changes:
>     - "This solves multiple problems."
>     - "This deletes 2000 lines of code."
>     - "Here is a patch that explains what I am trying to describe."
>     - "I tested it on 5 different architectures..."
>     - "Here is a series of small patches that..."
>     - "This increases performance on typical machines..."
> 
>   Bad things you should avoid saying:
>     - "We did it this way in AIX/ptx/Solaris, so therefore it must be
>       good..."
>     - "I've being doing this for 20 years, so..."
>     - "It makes this proprietary benchmark go faster"


I'd drop the "proprietary benchmark" from the "bad" list.

A benchmark alone might not be enough to justify a patch, but in an 
otherwise justified patch this would simply be an indication that some 
testing was done (which is positive).


>     - "This is required for my company to make money"
>     - "This is for our Enterprise product line."
>     - "Here is my 1000 page design document that describes my idea"
>     - "I've been working on this for 6 months..."
>     - "Here's a 5000 line patch that..."
>     - "I rewrote all of the current mess, and here it is..."
>     - "I have a deadline, and this patch needs to be applied now."
> 
> Another way the kernel community is different than most traditional
> software engineering work environments is the faceless nature of
> interaction.  One benefit of using email and irc as the primary forms of
> communication is the lack of discrimination based on gender or race.
> The Linux kernel work environment is accepting of women and minorities
> because all you are is an email address.  The international aspect also
> helps to level the playing field because you can't guess gender based on
> a person's name. A man may be named Andrea and a woman may be named Pat.
> Most women who have worked in the Linux kernel and have expressed an
> opinion have had positive experiences.


First you say that gender doesn't matter.


> Here is a group that is a good
> starting point for women interested in contributing to Linux:
> 	http://www.linuxchix.org/
>...


Then you tell where women belong to...

I'd simply drop this reference to linuxchix.org.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

