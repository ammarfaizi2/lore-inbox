Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135991AbRD0JcR>; Fri, 27 Apr 2001 05:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135992AbRD0JcI>; Fri, 27 Apr 2001 05:32:08 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:28428 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S135991AbRD0Jbv>; Fri, 27 Apr 2001 05:31:51 -0400
Message-ID: <3AE93C6E.F271DAFA@idb.hist.no>
Date: Fri, 27 Apr 2001 11:31:26 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre7 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: imel96@trustix.co.id
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.33.0104261730510.1677-100000@tessy.trustix.co.id>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

imel96@trustix.co.id wrote:
> i don't understand, that patch is configurable with 'n' as
> default, marked "dangerous". so somebody who turned on that
> option must be know what he's doing, doesn't understand english,
> or has a broken monitor.

This is a very marginal thing that very few people will want or need.
(You may think it is nifty - but we disagree on that)
If everybody get their favourite patch in with a config option
then we get a huge amount of config options, and maintainig the kernel
will be much harder because there is thousands of ifdefs for
all sorts of rare stuff.  There will be your 5 ifdefs, and
26000 other people's 5 ifdefs.  Someone making a change will have 
to check if it works, but will it work with all sorts of combinations
of config options?  What if someone makes a change that works fine,
but makes the kernel uncompileable if your option is turned on?
This guy didn't check your config option because he never use it
himself...
 
The maintainability issue is why kernel patches usually aren't accepted
when the problem can be solved by changing the userspace
configuration instead. (In your case by sybstituting "bash" for "getty"
in /etc/inittab)  This is the case even with very good things -
fsck is a userspace program even though it is necessary for any system
with
a writeable filesystem.  
You have another problem with the way all the leading developers
dislike your idea - buteven trying to convince them is useless as
you _still_ run up against "this feature is _easily_ done in userspace"

> > If you really want optimization, remove all security instead of
> > merely killing a few basic tests.
> 
> those tests responsible for almost all EACCESS & EPERM.
Sure, but now you have a lots of if(1) {something} else {other thing}
and a better optimization would be to get rid of the entire test.
There is a lot of errors that can't happen with your patch, so
you really ought to remove the error handling cases too if
optimization is what drives you.

> 
> > The notebook user might not care or understand about
> > multi-user security, but it is still useful.  The user
> > have several daemons running that he don't know about,
> > they were installed by the distribution.
> > The security system can protect files from buggy
> > or cracked daemons.
> 
> must be a devil cursed distro, distributing "single-user"
> kernel with live daemons. a division of redmon?

Is there something you don't understand, or do you really 
want to run one process at a time? 

You were talking about how a notebook is a personal thing,
with only one user.  Well, the notebook user do of course want to
do a bunch of nifty things like read email on the thing.  Guess what,
you need an email daemon for that!  And many users don't want to know
the details of setting up an email daemon, so the distribution
install one by default.  This kind of users would be outraged if
the distribution didn't - "what - I have to install more stuff just to
get my mail! windows do that out of the box why is this so difficult..."

There are several other examples of things users _expect_ from
a notebook, which just happens to include a daemon process running
under a different user-id for safety reasons.  (For example
the print spooler daemon.  Users want to print, and unix is nice
in that you don't have to wait for the printer - you can go
on editing something else while the printer slowly does
its work thanks to the print spooler daemon.  This one is
installed by default too.)

They only ever _log in_ as one user, so the login prompt
can safely be eliminated in order to avoid the password hassle.
But you still want the multi-user security.

Please try to understand that the kernels concept of a "user"
don't mean a "person"!  There is only one "person" using his/her
very personal device - the unix concept of users is a file
security thing.  You don't want an error in the mail
software to use up all the diskspace or overwrite your
word processing files.  And you don't want a printer driver
problem to mess up your mail or your personal files.

All these little things is included in good distributions, and
they don't cause serious trouble because they are all
protected against each other.  Your machine is multi-user
even if it is strictly single-person!

If all this is new to you, please read up on unix before 
suggesting too much.  _Uninformed_ patches easily becomes
a nuance, good patches is usually written by people who
know very well what they work on.  Excellent knowledge
of C isn't enough.
> 
> > And protecting the
> > configuration (and essential stuff like the user's GUI) from
> > being deleted by user accident is still a good thing.
> >
> > The user who don't need password security can still have a "safe"
> > SUID admin program for necessary tasks like changing the
> > dialup phone number even though it resides in a protected
> > file.  So you definitely want the protection system, even
> > in a "personal" appliance running linux.  Because it
> > protects against stupid mistakes like experimenting
> > with editing files in the /etc directory on the notebook with
> > a word processor.  Users don't understand why saving in
> > word processor format might be bad....
> 
> hmm, the other thing i hate is policy. ever consider that
> you're talking policy? maybe reboot() should sync() first?

Reboot does indeed sync on my machine.  That isn't the problem
here.  The problem I described is that a clueless user might
try to change a config file with his word processor and save
it in word-processor format.  This renders the file useless
as the programs who depend on config files don't understand
word processor format.  A "nice synced reboot" won't help here,
as the ruined file is then saved properly, but the 
contents are wrong.  
A good security system fixes this though - a user simply isn't
allowed to mess up the config files in arbitrary ways.  The
user is protected against his own lack of knowledge
or common sense.  Similiar, a car engine don't explode if you
press the accelerator too hard at low RPM's.  (A racing
car might - but racers _know_ how to handle such cars)
Unix appliances and personal  computers need similiar
protection and the security system is used for that.

So what if the user _need_ to change the configuration?
Experts do this by using the root password.  Non-experts
do this by running a safe config program.  The config program
is SUID (it is privileged and auto-switch to the root user)
and it contains all sorts of undo options and safety checks
so the user cannot screw things up badly.

> > A notebook is a particularly bad example.  Those with notebooks
> > might not want to use passwords all the time, but it is
> > very convenient if you have to leave a notebook with sensitive data
> > with someone you don't trust.  Business secrets or something
> > as simple as a diary.  This kind of users can be logged in
> > all the time, mostly avoiding passwords.  And log out
> > in those few cases they need to leave the machine in
> > unsafe places.
> 
> and that someone who had the notebook can't access sensitive
> data without a passwd?
> that's what i'm trying to say. if you carried your server,
> and leave it in unsafe places, why would anybody try to crack
> it? just get the harddisks put it in another computer, voila.
> so much for security.
An encrypted filesystem prevents even this - a cracker _can't_
read that disk without the password.  Because there
is no workaround even with a purpose-built "nasty" kernel.

This is usually overkill though.  Normal users worry about
things like your sister taking a sneak look at your diary
(stored in a word processor file).  Or in a business
setting:  A visitor taking a look at your business documents
while you fetch the coffee for the meeting.  He don't have time
for disassembling the computer, but he have time
for reading a few documents.  A simple password
protect against this.
 
What I do here is providing a few (of many) examples
of why passwords sometimes is a good idea even on
personal machines.

> > > - linux is stable not only because security.
> > Sure, but security definitely adds to its stability.
> 
> i don't know what you mean by stability. if you meant
> linux can run a year without a reboot, what security
> has anything to do with stability? the kernel is stable,
> yes, do we here linux server got cracked yes, it's still
> stable though.
> 
> > > - with that patch, people will still have authentication.
> > >   so ssh for example, will still prevent illegal access, if
> > Nope.  Someone ssh'ing into your system still
> > cannot guess someone elses password.  They can log in
> > into their own account though, and abuse other
> > users accounts or the machine configuration because
> > there is no protection.  Unprotected accounts only means
> > you get your own account _by default_, you have the
> > power to trash all the others.  A malicious user could
> > even change the other users passwords and re-enable the
> > security system so they loose.
> 
> i didn't disable password! if someone got into a personal
> machine through ssh by guessing, most likely that account
> is the owner's. who else?

Yeah, but what if there are several accounts? 
I have an account on my machine where strangers can log in in order
to play network games.  There is a password, but it is handed out
to a bunch of strangers I have no particular reason to trust.
This is not a problem as my machine has multi-user security.
They cannot delete _my_ files, or even read them, even though
they can log into the machine.  They cannot even run other
programs than the games, as they have no permission.

That wouldn't work with your patch.  They would still only
be able to log into their own game account because of 
the password security in ssh, but they definitely _would_
be able to delete _my_ personal account without
logging into it - because you disabled security.  And they
could delete the email software so I don't get mail.  And they
could delete the system software and the kernel, so the
machine goes down and remains down.  Security prevents all that.

> 
> >
> > >   you had an exploit you're screwed up anyway.
> > Many exploits are limited.  Cracking a damenon running
> > as "nobody" or some daemon user may not be all that
> > satisfying - you might be unable to take over the machine.
> > An exploit doesn't necessarily give root access.
> 
> that line was still about ssh. besides, if someone would
> run a server for the world, then he must had drain bamage.
> 
Not at all.  There are many game servers out there where
people all over the world can log in and run games.
But security prevents them for doing anything _but_ running
games, so there is no problem.  And there are anonymous
ftp server where anybode can log in...

> > You get a lot of opinions.  Don't mistake them for flames
> > just because they disagree with everything you say.
> 
> you haven't seen my inbox.
No, I just see the replies on the linux kernel list.
A few flames, and lots of people who merely disagree and try
to tell why they thing your patch and the idea behind
it is no good.  
 
> > Multi-user security is useful for much more than server use.
> > A good "personal" setup includes at least 3 users:
> > * root - for administration
> > * the user - for running the programs the user himself use.
> >   I.e. the word processor on a notebook, the user inteface
> >   on a linux phone, and so on.
> > * a nobody user, for safer daemons.  If any kind of daemon
> >   is used at all.  Surprisingly many appliances might
> >   run a daemon - a snmp daemon, or a webserver serving
> >   the same purpose (So your can check your home
> >   appliance from work perhaps)
> 
> but think about the idea of multi-user. it means protection
> for the system and other users. that's a typical server needs.
> 
> and how about notebook? i can see that it need authentication
> to use the system. does the user need to be protected from
> other users? there's nobody else. well, maybe, like we all
> used to, that user needed to protect him from himself.
>
> so, system authentication is needed for both single-user and
> multi-user. (let alone physical access)
> user account authentication is certainly not needed for single-
> user case.

As I have said already in this mail - a single-user computer
need the security system to protect the _system software_ from
the (single) user, and to protect the _users_ files from
possible bugs in various system software like mail software,
printer drivers and various other things the user
might want to run.  Some people thinks it is cool to
run a webserver on their office machine, even if it only servers
one page.  Security makes things like that safer too.

You may or may not need authentication.  But you definitely
want security. 
A newbie experimenting might stumble upon the command that
deletes all files on the system.  That won't kill a unix system,
the user will merely loose his own personal files, because
he has no permission for deleting system files.  

Try this on a windows 98 box (which don't have security, exactly
the way you tried to patch the kernel) and everything goes,
or at least a lot of things until the system crashes due
to a missing system file.  The system migh be unable
to delete everything, but it will certainly manage
to delete enough to amke the machine unuseable and in need
of a reinstall.  

This protection system ensures that you typically never need to
reinstall linux due to user mistakes.  (You may want to
upgrade often to get the latest software - but you don't
need to reinstall to get a upgrade.)
 
> > Of course passwords can be skipped - maybe you don't worry
> > about guests messing up your phone settings.  Still, a buggy
> > phone program shouldn't mess up other things.  You don't want
> > the browser on those fancy web-enabled cellphones to
> > accidentally delete the address book due to some oddball
> > bug or exploit.
> 
> and you're hoping program with root suid will run perfectly?
> 
> > You don't want the performance _or_ less memory used.  Why then do
> > you want to optimize away the security system instead of merely
> > changing the userspace configuration a bit?
> >
> > If you optimize away security then you probably want to
> > optimize away things like "login" as they are useless anyway
> > with such a kernel.  Much simpler to remove only "login"
> > then.
> 
> i wish it was only "a bit". what i want is to have all process
> flags have PF_SUPERPRIV, but users still own their own uid.
> doing it in userspace means i had to change this login, my
> friend had to change that login, maybe this shell, that shell...
> 
> that's my setup. i still use login, so only those who i trust
> can use my machine, yes my trusted user can do anything, but
> hey it isn't a server. it's a workstation.

I wonder what you want different UID's for then.  Why not set all the
UID's to 0, you'll still have separate usernames, and separate
home directories so you can have different setups and so on.
I cannot really see what you use the UID's for?

But still, if you want everybody to be able to do anything _and_
have separate UIDS, try userspace options. Possible ways:

1.  A single chmod command can make all files available.
   Something like "chmod -R /* oug+rwx"  You may have to
   do that as root - you won't need root later.

2. Or run a similiar chmod on /bin, /sbin and /usr/bin
   that makes all executables SUID.  power to the users!

3. Or let everybody be members of group 0 and run 
   "chmod g+rwx /* -R"

There's a multitude of easy ways to achieve the behavior you
want without patching the kernel.  That alone _ensures_
it won't get into the kernel.  They way people dislike
your idea don't make it better, but it wouldn't help
even if you could convince them.

Many newbie ideas are met with "no, the idea is bad but
you can achieve what you want another way, like this:"

Smart people learn from such things.  Some other
keep arguing when there is nothing to achieve.
If you're a unix newbie, please consider the option that
the other people may have a point.  They know things you don't,
so asking "why" is a much better idea than insisting on
an unpopular idea.  They don't all take the time
to explain why they don't like your patch, that don't mean
they don't have solid reasons.

Helge Hafting
