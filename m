Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVKNWUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVKNWUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 17:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVKNWUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 17:20:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:32140 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932202AbVKNWUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 17:20:36 -0500
Date: Mon, 14 Nov 2005 14:07:09 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: [RFC] HOWTO do Linux kernel development
Message-ID: <20051114220709.GA5234@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Over time, I get a lot of the same kind of emails from developers.
Messages asking how to do this or that, or how this process works.  I
also see a lot of new developers make the same mistakes (wrong patch
format, no signed-off-by:, not sent to the proper developer, wrong
coding style, etc.)

Along with these requests, I have heard a lot of complaints over time,
about how there is no single place to go to to figure out how to do
Linux kernel development, and where to point other people to.

So, I've been working on a document for the past week or so to help
alleviate a lot of these problems.  If nothing else, it should be a place
where anyone can point someone to when they ask the common questions, or
do something in the not-correct way.  I'd like to add this to the Linux
kernel source tree, so it will be kept up to date over time, as things
change (like the development process.)  Ideally I'd like to put it in
the main directory as HOWTO, but I don't know how others feel about
this.

Anyway, I'd like to get comments on what has been produced so far.  I
know the section about the development process is still not complete (it
has a <TODO> mark), and if anyone wants to fill that in, I'd really
appreciate it.

I would like to thank Pat Mochel, Hanna Linder, Randy Dunlap, Kay
Sievers, Vojtech Pavlik, and Jan Kara for their review and comments on
early drafts of this document.

thanks,

greg k-h



------------------------------

HOWTO do Linux kernel development
---------------------------------

This is the be-all, end-all document on this topic.  It contains
instructions on how to become a Linux kernel developer and how to learn
to work with the Linux kernel development community.

If anything in this document becomes out of date, please send in patches
to the maintainer of this file, who is listed at the bottom of the
document.


Intro
-----

So, you want to learn how to become a Linux kernel developer?  Or you
have been told by your manager, "Go write a Linux driver for this
device."  This document's goal is to teach you everything you need to
know to achieve this by describing the process you need to go through,
and hints on how to work with the community.  It will also try to
explain some of the reasons why the community works like it does.

The kernel is written mostly in C, with some architectural-dependent
parts written in assembly. A good understanding of C is required to
kernel development. Assembly (any architecture) is not required unless
you plan to do low-level development for that architecture. Though they
are not a good substitute for a solid C education and/or years of
experience, the following books are good, if anything for reference:

"The C Programming Language" by Kernighan and Ritchie [Prentice Hall]
"Practical C Programming" by Steve Oualline [O'Reilly]
"Programming the 80386" by Crawford and Gelsinger [Sybek]
"UNIX Systems for Modern Architectures" by Curt Schimmel [Addison Wesley]

The kernel is written using GNU C and the GNU toolchain. While it
adheres to the ISO C99 (??) standard, it uses a number of extensions
that are not featured in the standard. It can sometimes be difficult to
understand the assumptions the kernel has on the toolchain and the
extensions that it uses, and unfortunately there is no definitive
reference for them. Please check the gcc info pages (`info gcc`) for
some information on them.

Please remember that you are trying to learn how to work with the
existing development community.  It is a very diverse group of people,
with very high standards for coding, style and procedure.  These
procedures have been created over time based on what they have found to
work best for such a large and geographically dispersed team.  Try to
learn as much as possible about these procedures ahead of time, as they
are well documented, and not expect people to adapt to you, or your
company's way of doing things.



Legal Issues
------------

The Linux kernel source code is released under the GPL.  Please see the
file, COPYING, in the main directory of the source tree, for details on
the license.  If you have further questions about the license, please
contact a lawyer, and do not ask on the Linux kernel mailing list.  The
people on the mailing lists are not lawyers, and you should not rely on
their statements on legal matters.


Documentation
------------

The Linux kernel source tree has a large range of documents that are
invaluable in learning how to interact with the kernel community.  When
new features are added to the kernel, it is recommended that new
documentation files are also added, that explain how to use the feature.
Here is a list of files that are in the kernel source tree that are
required reading:
  Documetation/CodingStyle
    This describes the Linux kernel coding style, and some of the
    rationale behind it. All new code is expected to follow the
    guidelines in this document. Most maintainers will only accept
    patches if these rules are followed, and many people will only
    review code if it is in the proper style.

  Documentation/SubmittingPatches
  Documentation/SubmittingDrivers
    These files describe in explicit detail how to successfully create
    and send a patch, including (but not limited to):
       - Email contents
       - Email format
       - Who to send it to
    Following these rules will not guarantee success (as all patches are
    subject to scrutiny of content and style), but not following them
    will almost always prevent it.
 
    Other excellent descriptions of how to create patches properly are:
	"The Perfect Patch"
		http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
	"Linux kernel patch submission format"
		http://linux.yyz.us/patch-format.html

  Documentation/stable_api_nonsense.txt
    This file describes the rationale behind the conscious decision to
    not have a stable API within the kernel, including for things like:
      - Subsystem shim-layers (for compatibility?)
      - Driver portability between Operating Systems.
      - Mitigating rapid change within the kernel source tree (or
	preventing rapid change)
    This document is crucial for understand the Linux development
    philosophy and is very important for people moving to Linux from
    development on other Operating Systems.

  Documentation/SecurityBugs
    If you feel you have found a security problem in the Linux kernel,
    please follow the steps in this document to help notify the kernel
    developers, and help solve the issue.

  Documentation/ManagementStyle
    This document describes how Linux kernel maintainers operate and the
    shared ethos behind their methodologies.  This is important reading
    for anyone new to kernel development (or anyone simply curious about
    it), as it resolves a lot of common misconceptions and confusion
    about the unique behavior of kernel maintainers.

  Documentation/stable_kernel_rules.txt
    This file describes the rules on how the stable kernel releases
    happen, and what to do if you want to get a change into one of these
    releases.

  Documentation/kernel-docs.txt
    A list of external documentation that pertains to kernel
    development.  Please consult this list, if you do not find what you
    are looking for within the in-kernel documentation.


The kernel also has a large number of documents that can be
automatically generated from the source code itself.  This includes a
full description of the in-kernel api, and rules on how to handle
locking properly.  The documents will be created in the
Documentation/DocBook/ directory and can be generated as PDF,
Postscript, HTML, and man pages by running:
	make pdfdocs
	make psdocs
	make htmldocs
	make mandocs
respectively from the main kernel source directory.


Becoming A Kernel Developer
---------------------------

If you do not know anything about Linux kernel development, you should
look at the Linux KernelNewbies project:
	http://kernelnewbies.org
It consists of a helpful mailing list, where you can ask almost any type
of basic kernel development question (make sure to search the archives
first, before asking something that has already been answered in the
past.)  It also has a IRC channel that you can use to ask questions in
real-time, and a lot of helpful documentation that is useful for
learning about Linux kernel development.

The website has basic information about code organization, subsystems,
and current projects (both in-tree and out-of-tree). It also basic
logistical information, like compiling a kernel and applying a patch.

If you do not know where you want to start, but you want to look for
some task to start doing to join into the kernel development community,
go to the Linux Kernel Janitor's project:
	http://janitor.kernelnewbies.org/
It is a great place to start.  It describes a list of relatively simple
tasks that need to be cleaned up and fixed within the Linux kernel
source tree.  Working with the developers in charge of this project, you
will learn the basics of getting your patch into the Linux kernel tree,
and possibly point you in the direction of what to go work on next, if
you do not already have an idea.


If you already have a chunk of code that you want to have go into the
kernel tree, but need some help getting it in the proper form, the
kernel-mentors project was created to help you out with this.  It is a
mailing list, and can be found at:
	http://selenic.com/mailman/listinfo/kernel-mentors


The development process
-----------------------

<TODO>


Mailing lists
-------------

As some of the above documents describe, the majority of the core kernel
developers participate on the Linux Kernel Mailing list.  Details on how
to subscribe and unsubscribe from the list, can be found at:
	http://vger.kernel.org/vger-lists.html#linux-kernel
There are archives of the mailing list on the web in many different
places.  Use a search engine to find these archives. It is highly
recommended that you search the archives about the topic you want to bring
up, before you post it to the list. A lot of things are already discussed
in detail and are only recorded at the mailing list archives.

Most of the individual kernel subsystems also have their own separate
mailing list where they do their development efforts.  See the
MAINTAINERS file for a list of what these lists are, for the different
groups.

Many of the lists are hosted on kernel.org. Information on them can be
found here:
	http://vger.kernel.org/vger-lists.html

Please remember to follow good behavioral habits when using the lists.
Though a bit cheesy, the following URL has some simple guidelines for
interacting with the list (or any list):
	http://www.albion.com/netiquette/

If multiple people respond to your mail, the CC: list of recipients may
get pretty large. Don't remove anybody from the CC: list without a good
reason, or don't reply only to the list address. Get used to receive the
mail twice, one from the sender and the one from the list and don't try
to tune that by adding fancy mail-headers, people will not like it.

Remember to keep the context and the attribution of your replies intact,
keep the "John Kernelhacker wrote ...:" lines at the top of you reply and
add your statements between the individual quoted sections instead of
writing at the top of the mail.

If you add patches to your mail, make sure they are plain readable text
as stated in Documentation/SubmittingPatches. Kernel developers don't
want to deal with attachments or compressed patches, they may want
to comment individual lines of your patch, which works only that way.
Make sure you use a mail program that does not mangle spaces and tab
characters. A good first test is to send the mail to yourself and try
to apply your own patch by yourself. If that doesn't work, get your
mail program fixed or change it until it works.

Above all, please remember to show respect to other subscribers.



Working with the community
--------------------------

The kernel community works differently than most traditional corporate
development environments.  Here are a list of things that you can try to
do to try to avoid problems:
  Good things to say regarding your proposed changes:
    - "This solves multiple problems."
    - "This deletes 2000 lines of code."
    - "Here is a patch that explains what I am trying to describe."
    - "I tested it on 5 different architectures..."
    - "Here is a series of small patches that..."
    - "This increases performance on typical machines..."

  Bad things you should avoid saying:
    - "We did it this way in AIX/ptx/Solaris, so therefore it must be
      good..."
    - "I've being doing this for 20 years, so..."
    - "It makes this proprietary benchmark go faster"
    - "This is required for my company to make money"
    - "This is for our Enterprise product line."
    - "Here is my 1000 page design document that describes my idea"
    - "I've been working on this for 6 months..."
    - "Here's a 5000 line patch that..."
    - "I rewrote all of the current mess, and here it is..."
    - "I have a deadline, and this patch needs to be applied now."

Another way the kernel community is different than most traditional
software engineering work environments is the faceless nature of
interaction.  One benefit of using email and irc as the primary forms of
communication is the lack of discrimination based on gender or race.
The Linux kernel work environment is accepting of women and minorities
because all you are is an email address.  The international aspect also
helps to level the playing field because you can't guess gender based on
a person's name. A man may be named Andrea and a woman may be named Pat.
Most women who have worked in the Linux kernel and have expressed an
opinion have had positive experiences.  Here is a group that is a good
starting point for women interested in contributing to Linux:
	http://www.linuxchix.org/

The language barrier can be present for some people who are not
comfortable with English.  A good grasp of the language can be needed in
order to get ideas across properly on mailing lists, so it is
recommended that you check your emails to make sure they make sense in
English before sending them.


Break your changes up
---------------------

The Linux kernel community does not gladly accept large chunks of code
dropped on it all at once.  The changes need to be properly introduced,
discussed, and broken up into tiny, individual portions.  This is almost
exactly opposite of what companies are used to doing.  Your proposal
should also be introduced very early in the development process, so that
you can receive feedback on what you are doing.  It also lets the
community feel that you are working with them, and not simply using them
as a dumping ground for your feature.  However, don't send 50 emails at
one time to a mailing list, your patch series should be smaller than
that almost all of the time.

The reasons for breaking things up are the following:

1) Small patches increase the likelihood that your patches will be
   applied, since they don't take much time or effort to verify for
   correctness.  A 5 line patch can be applied by a maintainer with
   barely a second glance. But, a 500 line patch may take hours to
   review for correctness (the time it takes is exponentially
   proportional to the size of the patch, or something).

   Small patches also make it very easy to debug when something goes
   wrong.  It's much easier to back out patches one by one, than it is
   to dissect a very large patch after it's been applied (and broken
   something).

2) It's important not only to send small patches, but also to rewrite
   and simplify (or simply re-order) patches before submitting them.

Here is an analogy from kernel developer Al Viro:
	"Think of a teacher grading homework from a math student.  The
	teacher does not want to see the student's trials and errors
	before they came up with the solution. They want to see the
	cleanest, most elegant answer.  A good student knows this, and
	would never submit her intermediate work before the final
	solution."

	The same is true of kernel development. The maintainers and
	reviewers do not want to see the thought process behind the
	solution to the problem one is solving. They want to see a
	simple and elegant solution."

That may be challenging to keep the balance between presenting an elegant
solution and working together with the community and discuss your
unfinished work. Therefore it is good to get early in the process to
get feedback to improve your work, but also keep your changes in small
chunks that they may get already accepted, even when your whole task is
not ready for inclusion now.  

Also realize that it is not acceptable to send patches for inclusion
that are unfinished and will be "fixed up later."


Justify your change
-------------------

Along with breaking up your patches, it is very important for you to let
the Linux community know why they should add this change.  New features
must be justified as being needed and useful.




All of these things are sometimes very hard to do. It can take years to
perfect these practices (if at all). It's a continuous process of
improvement that requires a lot of patience and determination. But,
don't give up. It's possible. Many have done it before, and each had to
start exactly where you are now.




----------
Thanks to Randy Dunlap and Gerrit Huizenga for the list of things you
should and should not say.  Also thanks to Pat Mochel, Hanna Linder,
Randy Dunlap, Kay Sievers, Vojtech Pavlik, and Jan Kara for their review
and comments on early drafts of this document.



Maintainer: Greg Kroah-Hartman <greg@kroah.com>

