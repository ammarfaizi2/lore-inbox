Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135251AbRDZJrN>; Thu, 26 Apr 2001 05:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135263AbRDZJqw>; Thu, 26 Apr 2001 05:46:52 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:17925 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S135251AbRDZJqp>; Thu, 26 Apr 2001 05:46:45 -0400
Message-ID: <3AE7EE6F.28446A2C@idb.hist.no>
Date: Thu, 26 Apr 2001 11:46:23 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: imel96@trustix.co.id
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
In-Reply-To: <20010425120319Z135634-682+3531@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

imel96@trustix.co.id wrote:

> so when everybody suggested playing with login, getty, etc.
> i know you have got the wrong idea. if i wanted to play
> on user space, i'd rather use capset() to set all users
> capability to "all cap". that's the perfect equivalent.
> 
The linux kernel ought to be flexible, so most people can use
it as-is.  It can be used as-is for your purpose, and
it have been shown that this offer more security _without_
inconvenience.  Your patch however removes multi-user security
for the many who needs it - that's why it never will get accepted.
Feel free to run your own patched kernels - but your
patch will never make it here.

> so the user space solution (capset()) works, but then came
> the idea to optimize away. that's what blow everybody up.
> don't get me wrong, i always agree with rik farrow when he
> wrote in ;login: that we should build software with security
> in mind.
> 
If you really want optimization, remove all security instead of
merely killing a few basic tests.

> but i also hate bloat. lets not go to arm devices, how about
> a notebook. it's a personal thing, naturally to people who
> doesn't know about computer, personal doesn't go with multi
> user. by that i mean user with different capabilities, not
> different persons.
The notebook user might not care or understand about 
multi-user security, but it is still useful.  The user
have several daemons running that he don't know about,
they were installed by the distribution. 
The security system can protect files from buggy
or cracked daemons.

And protecting the
configuration (and essential stuff like the user's GUI) from
being deleted by user accident is still a good thing.  

The user who don't need password security can still have a "safe"
SUID admin program for necessary tasks like changing the
dialup phone number even though it resides in a protected
file.  So you definitely want the protection system, even
in a "personal" appliance running linux.  Because it
protects against stupid mistakes like experimenting
with editing files in the /etc directory on the notebook with
a word processor.  Users don't understand why saving in
word processor format might be bad....

A notebook is a particularly bad example.  Those with notebooks
might not want to use passwords all the time, but it is
very convenient if you have to leave a notebook with sensitive data
with someone you don't trust.  Business secrets or something
as simple as a diary.  This kind of users can be logged in
all the time, mostly avoiding passwords.  And log out
in those few cases they need to leave the machine in
unsafe places.


> 
> i haven't catch up with all my mails, but my response to
> some:
> - linux is stable not only because security.
Sure, but security definitely adds to its stability.
Instead of nuking it all, just remove what bothers you.
The security system has plenty to offer even when you
skip the password part.

> - linux was designed for multi-user, dos f.eks. is designed
>   for personal use, so does epoc, palmos, mac, etc.
> - i even use plan9 with kfs restrictions disabled sometimes,
>   cause i don't have cpu server, auth server, etc.

> - with that patch, people will still have authentication.
>   so ssh for example, will still prevent illegal access, if
Nope.  Someone ssh'ing into your system still
cannot guess someone elses password.  They can log in 
into their own account though, and abuse other
users accounts or the machine configuration because
there is no protection.  Unprotected accounts only means
you get your own account _by default_, you have the
power to trash all the others.  A malicious user could
even change the other users passwords and re-enable the
security system so they loose.

>   you had an exploit you're screwed up anyway.
Many exploits are limited.  Cracking a damenon running
as "nobody" or some daemon user may not be all that
satisfying - you might be unable to take over the machine.
An exploit doesn't necessarily give root access.

> so i guess i deserve opinions instead of flames. the
You get a lot of opinions.  Don't mistake them for flames
just because they disagree with everything you say.

> approach is from personal use, not the usual server use.
> if you think a server setup is best for all use just say so,
> i'm listening.
Multi-user security is useful for much more than server use.
A good "personal" setup includes at least 3 users:
* root - for administration
* the user - for running the programs the user himself use.
  I.e. the word processor on a notebook, the user inteface
  on a linux phone, and so on.
* a nobody user, for safer daemons.  If any kind of daemon
  is used at all.  Surprisingly many appliances might
  run a daemon - a snmp daemon, or a webserver serving
  the same purpose (So your can check your home 
  appliance from work perhaps)

Of course passwords can be skipped - maybe you don't worry
about guests messing up your phone settings.  Still, a buggy
phone program shouldn't mess up other things.  You don't want
the browser on those fancy web-enabled cellphones to
accidentally delete the address book due to some oddball
bug or exploit. 
 
> i did say it clearly that i have other changes which i know
> won't be a clean patch (too many #ifdefs). f.eks. on my
> computer i didn't even compile user.c in, i don't have
> user_struct. filesystem and vfs code are affected by that
> patch already. memory access is important of course.
> 
> > Then you can try to show a measurable performance
> difference.
> 
> nah, performance was never my consideration. i do save about
> 3kb from my zImage, but i'm not interested.

You don't want the performance _or_ less memory used.  Why then do
you want to optimize away the security system instead of merely
changing the userspace configuration a bit?  

If you optimize away security then you probably want to
optimize away things like "login" as they are useless anyway
with such a kernel.  Much simpler to remove only "login"
then.

Helge Hafting
