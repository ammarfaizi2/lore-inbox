Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316915AbSFVV4b>; Sat, 22 Jun 2002 17:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316919AbSFVV4a>; Sat, 22 Jun 2002 17:56:30 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:19636 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316915AbSFVV43>; Sat, 22 Jun 2002 17:56:29 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 22 Jun 2002 14:56:23 -0700
Message-Id: <200206222156.OAA00651@baldur.yggdrasil.com>
To: henning@makholm.net
Subject: Re: make-3.79.1 bug breaks linux-2.5.24/drivers/net/hamradio/soundmodem
Cc: bug-make@gnu.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
        sailer@ife.ee.ethz.ch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

enning Makholm wrote:
>Scripsit "Adam J. Richter" <adam@yggdrasil.com>
>> 	Until the make bug is fixed, I have worked around the problem
>> by replacing the rule with:

>> $(obj)/sm_tbl_%: $(obj)/gentbl
>>         PATH=$(obj):$$PATH $<

>That looks like an excessively complicated workaround. Why not just

>$(obj)/sm_tbl_%: $(obj)/gentbl
>	$(obj)/gentbl

	Thanks.  That is a cleaner workaround.



>I'm not sure this is really a bug either. It is a Good Thing that make
>tries to normalize the names of targets and dependencies internally,
>lest the build may be incomplete or redundant if make does not realize
>that foo.bar and ./foo.bar is the same file. It is quite reasonable
>for $< to unfold to the *canonical* name of the file in question, I
>think.

	That just makes the behavior of make less predictable.
Whatever make does with the file names internally is its own business.
Rewriting the file names passed to commands unnecessarily is
potentially a big problem.  Suppose, for example, that this was a
command that wanted to chop up the directory prefix and that the
bottom level directory was a symbolic link (for example, maybe I have
/usr/netscape/bin as a symlink to /usr/local/bin, but I want the
installation command to record the path name as /usr/netscape/bin).



>If one absolutely wants the command to use the exact form of the
>dependency that's used in the dependency list, it's easy to simply
>reproduce that form, replacing the % by $*

	Sorry, I do not understand what you mean.  If you want to
explain it to me, you may have to write the rule out.

	Thanks for the better workaround and the advice.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
