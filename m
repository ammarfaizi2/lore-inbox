Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287054AbRL2Bof>; Fri, 28 Dec 2001 20:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287056AbRL2Bo0>; Fri, 28 Dec 2001 20:44:26 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:22800 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287054AbRL2BoN>;
	Fri, 28 Dec 2001 20:44:13 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: wingel@hog.ctrl-c.liu.se (Christer Weinigel), linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Fri, 28 Dec 2001 17:39:08 -0000."
             <E16K0yL-0001Ad-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 29 Dec 2001 12:44:00 +1100
Message-ID: <7974.1009590240@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001 17:39:08 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> * make dep is only run once
>> 
>> Personally, I don't see this as a big problem.  Just tell people to 
>
>I run make dep whenever I change config. Guess what - one cmp and I can
>automate that as part of make. If the .config doesnt match the
>.configwhendep then its time to make dep again

Don't forget that any change that affects a file's #include list
(including patches) requires you to run make dep.

make dep does not handle generated files at all, change the code that
generates a file and the file is regenerated but make dep did not pick
up the file the first time so kbuild 2.4 does not detect the change.
Another make dep will fix that of course.  So now we have

  Run make dep after -

    A change to .config.
    Any source change, it might have changed the #include list.
    Any source or command line change that affects generated files.

How do you automate that?  You end up saying that you always run make
dep.

>> That dependencies are absolute is also not a thing that has bothered me 
>> too much, it's always possible to run "make dep" after moving a tree, 
>> on the other hand, I don't use NFS a lot anymore, so I can see it being 
>> a problem in other environments.
>
>sed works too, as do symlinks

For people who know what they are doing, not for the larger population
that are struggling with the kernel build process.  kbuild 2.5 is
designed to work accurately and automatically for everyone, from the
high druids of the kernel down to the lowliest newbie.

