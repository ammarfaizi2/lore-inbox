Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbVJEU1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbVJEU1F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbVJEU1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:27:04 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:40710 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030373AbVJEU1C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:27:02 -0400
To: Marc Perkel <marc@perkel.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, 7eggert@gmx.de,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	<E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
	<4343E611.1000901@perkel.com>
	<20051005144441.GC8011@csclub.uwaterloo.ca>
	<4343E7AC.6000607@perkel.com>
	<20051005145606.GA7949@csclub.uwaterloo.ca>
	<4343EC6A.70603@perkel.com> <874q7vhj0c.fsf@amaterasu.srvr.nix>
	<434429F2.7030400@perkel.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: the prosecution rests its case.
Date: Wed, 05 Oct 2005 21:26:45 +0100
In-Reply-To: <434429F2.7030400@perkel.com> (Marc Perkel's message of "Wed,
 05 Oct 2005 12:30:58 -0700")
Message-ID: <87vf0bogl6.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2005, Marc Perkel stipulated:
> Nix wrote:
>>On Wed, 05 Oct 2005, Marc Perkel yowled:
>>So, um, what happens to these permissions when you copy a file and put
>>it somewhere else? Do the inherited rights go with it or not? In Unix
>>it's pretty intuitive. In this system there seem to be two right
>>answers, both of which seem... risky from a security perspective.
>
> You inherit the rights of the new directory.

That's a hugely counterintuitive potential security hole in waiting.

Because any number of permissions can be inherited (anything from none
of them, to all of them), this means that upon copying a file *you
cannot reliably tell what its permissions will become* without checking
it.

I don't think I need to point out the flaw in such a scheme.

> Also - under Netware not all permissions are stored with the file. The
> rights are calculated from the file heirachy so you don't store a lot
> of data with each file unless the file has permissions set that is
> different than that of the directory it's in. So moving a file to
> someone's home directory doesn't require any permissions to be set to
> give the user rights to the file.

I consider this a substantial *disadvantage*. Changing permissions should
be something that you have to explicitly do: it shouldn't happen quietly
behind your back merely on account of a rename().

>>/tmp is the problem here, and shows the futility and pointlessness of
>>this feature. If you have an unlistable file in /tmp, *its name is still
>>determinable*, because other users cannot create files with that
>>name. The concept adds *nothing* over some combination of dirs with the
>>execute bit cleared for some set of users and subdirectories which
>>cannot be read by some set of users. There's no need for this profoundly
>>non-Unixlike permission at all. (As usual, ACLs make managing this on
>>a fine-grained scale rather easier.)
>
> It doesn't really make sense to use the /tmp directory the way Unix
> uses it. Why would you want just anyone to even know the names of the
> temporary files you are using. Users should have their own temp
> directory or create their own directory within /tmp

This is what per-process namespaces are for.

> But - to address your question - if there were an invisible (to you)
> file in a directory that you had create rights to then you would get a
> file creation error.

i.e., the filename is *not* invisible, but trivially determinable by a
sufficiently determined attacker; sticking the file in a non-readable
directory is doable *now*, and *already* lacks this weakness.

i.e., the feature is useless.

>>I think Plan 9 is a better goal than Netware. At least it was designed
>>by people aiming for a better Unix rather than people trying to build a
>>better DOS, and so is more likely to have a compatible philosophy.
>>
> I'm not familiar with Plan 9.

Linux seems to be stealing all its good ideas bit by bit, so you'll
know sooner or later. :)

But per-process namespaces are *wonderful*. Goodbye, PATH, for instance:
just mount every binary this user should see in this user's /bin. He
gets his own /tmp, and /home contains *his home directory*.

(Special considerations have to be made for privileged processes: we
don't want the user to be able to fake them out by fooling with /etc,
say, or with their shared libraries. Perhaps setuid programs revert to a
standard namespace, and can see the user's one in
/proc/self/nonprivileged-root or something.)

-- 
`Next: FEMA neglects to take into account the possibility of
fire in Old Balsawood Town (currently in its fifth year of drought
and home of the General Grant Home for Compulsive Arsonists).'
            --- James Nicoll
