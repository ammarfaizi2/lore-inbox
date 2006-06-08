Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWFHPkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWFHPkt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 11:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWFHPkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 11:40:49 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:35004 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S964880AbWFHPkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 11:40:49 -0400
Message-ID: <448843A4.8070102@comcast.net>
Date: Thu, 08 Jun 2006 11:35:00 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Clean-up:  TASK_UNMAPPED_BASE and mmap_base
References: <44862CE3.7040406@comcast.net> <1149769487.3380.70.camel@laptopd505.fenrus.org>
In-Reply-To: <1149769487.3380.70.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> On Tue, 2006-06-06 at 21:33 -0400, John Richard Moser wrote:
>> This patch applies to 2.6.17-rc6 to replace several occurrences of
>> TASK_UNMAPPED_BASE with current->mm->mmap_base, mm->mmap_base, or base,
>> as appropriate.
>>
>> I am not entirely sure what all of the code I messed with is doing, to
>> be quite honest.  Code that seemed to be initializing a task and setting
>> up the mmap() base I left with TASK_UNMAPPED_BASE; code that seemed to
>> be trying to figure out what the mmap() base was I replaced with
>> mm->mmap_base.
>>
>> Because of this, I may have made a couple errors.  Could I get some
>> comments on whether any of this is dirty and why?  I'll make appropriate
>> changes and re-submit.  This only took 2 hours anyway.
>>
> 
> now if you put your patch inline you'd get comments in detail
> 

Hmm.  I hit "Attach" in Thunderbird.  Viewing the message shows the
patch inline with the message for me.  I wasn't aware I needed to do
something for that.  (Any help here is appreciated.. I'm sure I can't
just copy-paste the diff because Thunderbird likes to wrap long lines
PHYSICALLY)

> but you missed that some of the places where this is used is the
> fallback in case the per-task value doesnt result in a good memory hole
> found.

So I replaced TASK_UNMAPPED_BASE somewhere where it needs to be
TASK_UNMAPPED_BASE?

Function?  get_unmapped_area() and arch_get_unmapped_area()?

> 
> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRIhDoQs1xW0HCTEFAQKMUhAAnZtNfzUKealy7VhEWHSTdPAvGRK1s/0U
u+Cr9j2uhGPeiYwwZIIpx6Ilr3E2EiFm9alOZfL0kRIiYUEYU1jFXWIi7HYPf4XG
JR/0JyN1X8DU6vdPhMSfLjvhKaTHPhhnuU5IV384gtGp8noTSS2RV0Zyry0r38Lp
AH6Q7yt237a30mv97lSHhjqT+RotiASlLqvTbwLKrDrNy0z1biM6q4cl2eMKLwEg
LtTCF5H0Mh8MPBQSwM1ESejGX83mwnMMfyslwzU3wzglx9uhK/dVoa2l5mGZe6vP
5p5/MweQb8S7T9jzcxiSF0vYJTA/IGMCR2DYmlpN6s5ww2t0VZRdEoNHCPx/3aPA
Ibjz70xl6hS6AjY9lvVcOc73vOvRgjHZl4jhMhJU8mL5i0yWSm6tKgBLG29hcZHI
OuI4hdH16drEf3keRTt6vNeYSV2RgiMj6Gb/bQfXaUt4doAwv6hJiyQERG3lgOl3
KhusWdIvPtR1BJoBHu6BxqmKXa43rGtoJF6I54pVQ3jbwj7HWtixT/XD1GrjZnM8
w/0elm80PSHINfvyC+jt7yELFd9xTVAtGaa2Cakg32Hx/XnpNKlSaxE6Fv6PxuHx
7+78mBYNXp1Mlr4CRsYGq09xanWfwgmMcOVq73+CbIP3r8mp4g5rRY0d6wKdN9AX
J/aLeoYIQvs=
=mQFP
-----END PGP SIGNATURE-----
