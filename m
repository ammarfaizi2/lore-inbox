Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263152AbUJ2AES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbUJ2AES (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263108AbUJ2AEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:04:12 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:671 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263152AbUJ2ACk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:02:40 -0400
Message-ID: <4181888D.8020908@comcast.net>
Date: Thu, 28 Oct 2004 20:02:21 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: michael@optusnet.com.au
CC: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
References: <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>	<200410261719.56474.edt@aei.ca>	<Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt>	<417F315A.9060906@comcast.net> <m1sm7znxul.fsf@mo.optusnet.com.au>	<41811AF2.2000503@comcast.net> <m1oeimo2hi.fsf@mo.optusnet.com.au>
In-Reply-To: <m1oeimo2hi.fsf@mo.optusnet.com.au>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



michael@optusnet.com.au wrote:
| John Richard Moser <nigelenki@comcast.net> writes:
|
|>michael@optusnet.com.au wrote:
|
| [...]
|
|>| There seems to be a lot of strange notions on this concept of 'stable'.
|>| The only thing that makes a kernel 'stable' is time. Not endless
|>| bugfixes. Just time. The idea of stable software is software that not
|>| going to give you any suprises, software that you can trust.
|>|
|>
|>Right.  Bugfixing the "Stable" branch ONLY will make sure it does not
|>surprise you with sudden new features (which may surprise you by. . .
|>breaking your own patches!).
|
|
| You've missed the point. 'Bugfixing' introduces code changes, and new
| bugs.


introduces a minimal amount of new code in most cases, makes up-porting
through the bugfixes a 5 minute job.

[...]

|
|>| Now you've got a kernel that tests clean with your app. DON'T
|>| CHANGE IT!!
|>|
|>| Ta-Dah! You've got a stable kernel.
|>|
|>
|>That if I keep my realtime patches or my security enhancements or my new
|>drivers or my new filesystems on and don't continuously upgrade will
|>cause me to stagnate and be left behind and ignored.
|
|
| Ahh. Now I get it. You don't want a stable kernel at all. You
| just want to pick and chose which new features you get.
|
| In what way is 'security enchancements', or 'new drivers', or 'new
| filesystems' not the very feature enchancements you're complaining
| about in 2.6?
|

You try maintaining a feature patched kernel using things not in
mainline and you'll see.  Try grsecurity and reiser4.  You'll quickly
find Reiser4 to be at 2.6.8.1-2.6.9 (it's in 2.6.9 mainline right?), and
grsecurity at 2.6.7.

Now here's a real trick.  Try pulling it back out of 2.6.10-rcX, and
into 2.6.7.  You'll have to grab the fs/reiser4 directory, plus muddle
out what changes happened in VFS relating to reiser4, plus try to fix
whatever you just made explode.

Now as you'll notice, I've created a very shabby issue here; obviously
if I'm using 2.6.7+grsecurity, I'm not concerned with reiser4, as it
wasn't stable until 2.6.8.  What about if I'm implementing added
security using grsecurity/pax among others?  In fact, what if I'm a
distribution maintainer doing this?  New installs may use Reiser4; I'm
about to break them terminally.  PR for said distribution falls through
the floor, nobody uses it.

This may seem moot, but let's take a step back and say that 2.6 was
frozen at 2.6.7, and 2.6.10 is just 2.6.7 + bug fixes.  2.7 is in this
scenario taking on new features, but sanely, as 2.6 is now.  Some
adventurous users will use 2.7 and reiser4, others will use just 2.6.
Now I'll just patch grsec into 2.6, do whatever polish is needed if the
authors haven't taken the 5 minutes to keep up with mainline, rebuild
the base pie/ssp, set up pax flags so ~20 packages don't die from PaX,
and distribute.  PR goes up; and in 6 months a new stable kernel is
forked anyway, a few weeks later there's a new grsec, my distro upgrades.

As you can probably tell by now, my goals are very defined.  I have a
narrow focus here, which is why I really did lose interest in arguing
this a while back; but you're all so persistant to argue with me.  Even
so, my intentions are and have been to create a solution that's
simultaneously identical to and the antithesis of the current solution,
so that everyone (including me) can shut up and be happy.  The effects
are largely psychological and a simple display of macromanagment; and
all opposition has been visually simple obsessive resistance to change.

Unless you want to stop bickering about this and start working out a
clear definition of a better model, stop arguing with me.  It does no
good in either direction, as we can't change the model anyway until
we've developed a *better* one; so efforts should be focused there
rather than at the self-answering argument of whether or not it should
be done.

| Michael.
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBgYiMhDd4aOud5P8RAnyvAJ0VK9ayhrO7Gv5NOX4WXN7ZPjNCywCfVWhO
L/0b1kQ8CT4ktlxyKWxS+o8=
=CI/N
-----END PGP SIGNATURE-----
