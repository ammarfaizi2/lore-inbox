Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVGKUnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVGKUnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVGKUm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:42:28 -0400
Received: from scrat.hensema.net ([62.212.82.150]:19122 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S262655AbVGKUkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:40:22 -0400
From: Erik Hensema <erik@hensema.net>
Subject: Re: reiser4 vs politics: linux misses out again
Date: Mon, 11 Jul 2005 20:40:20 +0000 (UTC)
Message-ID: <slrndd5m9k.2qu.erik@bender.home.hensema.net>
References: <slrndd4dau.bct.erik@bender.home.hensema.net> <200507111815.j6BIFgc6002696@laptop11.inf.utfsm.cl>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.8.0 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand (vonbrand@inf.utfsm.cl):
> Erik Hensema <erik@hensema.net> wrote:
>> Horst von Brand (vonbrand@inf.utfsm.cl):
>> [on reiserfs4]
>> >> >>                                                   and _can_ do things
>> >> >> no other FS can
>
>> > Mostly useless things...
>
>> Depends on your point of view. If you define things to be useful
>> only when POSIX requires them, then yes, reiser4 contains a lot
>> of useless stuff.
>
> That isn't my definition.

Ok. It seems to be the definition of some people over here tough.

>> However, it's the 'beyond POSIX'-stuff what makes reiser4
>> interesting.
>
> I haven't seen a shred of evidence of that up to here. Just redoing
> in-kernel (for completely inscrutable reasons) stuff that has been
> confortably done in userland for many years isn't "Interesting", quite the
> contrary.

Some things simply need to be done inside the kernel for
atomicity, especially when mixing 'normal' posix applications
with apps using extended semantics.

>> Multistream files have been useful on other OSses for years.
>
> I only have seen other OSes moving away from such stuff...

That would be OSX I guesss.
>>                                                              They
>> might be useful on Linux too (Samba will surely like them).
>
> OK, if you think Windows is a good idea all around...

Windows is a fact of life, like it or not. Every Linux+Samba
server replacing a Win2k3 server is a win, IMHO.

>> The plugin architecture is very interesting.
>
> Again: It isn't "plugins", it's "kernel configuration options redefining
> the filesystem layout". And that is extremely toxic: If the claims are to
> be believed, somebody using ReiserFS 4 could end up using filesystems as
> widely different as ext3 and ufs today. Both called the same. Or everybody
> will end up using the exact same set of "plugins", so they make no sense as
> configuration options. Sure, it is nice to have different versions of the
> same filesystem (in a way, ext3 is a version of ext2; in ext3 there are
> some options that where introduced later, and some of which aren't
> backwards-compatible), but this is not something I would want each
> individual user screw around with willy-nilly. So the whole "plugin" idea
> is very questionable to me.

Not every plugin changes the filesystem layout. Plugins can also
change higher level APIs. 

Changing the filesystem layout is quite dangerous indeed. Hans,
is a list of required plugins stored in the superblock?

>> need files to be in the POSIX namespace.
>
> The POSIX namespace /is/ the namespace for files.

It doesn't need to be the namespace for _all_ files.

>>                                          Why would you want to
>> store a mysql database in files?
>
> Because it is the abstraction of permanent storage that the OS gives me. Or
> I could write them directly on a raw block device for performance (by
> cutting out a middleman).

Reiser4 could offer you a differend kind of abstraction. I don't
know if it would be useful in the mysql case, I don't write
database software.
Mysql is just a random example of software needing to store data
somewhere. The data is only accessable through the mysql api.
Backing up the files is useles when the server is running.

>
>>                                  Why not skip the overhead of the
>> VFS and POSIX rules and just store them in a more efficient way?
>
> Exactly. Cut out the filesystem.
>
>> Maybe you can create a swapfile plugin.
>
> The kernel manages swapping on files and devices just fine, thank you.

Just a random example.

>>                                         No need for a swapfile to
>> be in the POSIX namespace either.
>
> And how do you handle it if it has no filename?!

mkswap --kind=reiser4fsswap --operation=create

whatever.

>> It's just a fun thing to experiment with.
>
> Noone here is stopping you from experimenting.
>
>>                                           It's not always
>> nescesary to let the demand create the means. Give programmers
>> some powerful tools and wait and see what wonderful things start
>> to evolve.
>
> The sad truth is that if you give a random collection of people powerful
> tools they misuse them more often than not, creating a huge mess in the
> process. That is why it is so hard to design good tools.

Agreed. That's why you need to experiment.

>> And yes, maybe in ten years time POSIX is just a subsystem in
>> Linux. Maybe commerciale Unix vendors will start following Linux
>> as 'the' standard instead of the other way around. Seems fun to
>> me :-)
>
> To me too. But forcing Linux today to be as non-POSIX as possible, just so
> it will be prepared for 10 years in the future makes no sense, because you
> break it /now/.

Linux will still be posix. video4linux isn't posix either. I
don't see why access to data stores should be posix all the time.

>> I think this debate will mostly boil down to 'do we want to
>> experiment with beyond-POSIX filesystems in linux?'.
>
> You (and some others) clearly want to. More power to the bunch that comes
> up with clean semantics that can be implemented efficiently and are useful
> in real life (as opposed to "it would be oh-so-nice to also have $FEATURE
> for my pet $NICHE_CASE, feature for which I just can't be bothered
> considering ramifications at all"). Before going off look up "featuritis"
> (and consider how it all but killed off a lot of OSes, even many Unix
> variants, and uncountable other things too).

Extending a filesystem beyond the standard POSIX semantics is a
huge step. Not even a company as large as Microsoft can make the
next step in filesystem design (WinFS). It must be done in small
steps. Reiser4 is one of these small steps. Maybe the step isn't
quite in the right direction, but I don't think it will be a
detour either.

>> Clearly we don't _need_ it now. There simply are no users. But
>> will users come when reiser4 is merged? Nobody knows.
>
> Probably a tiny minority. Something like the following ReiserFS 3 has
> today.

Do you include Reiser3 users in the tiny minority? Both SuSE and
Gentoo use reiser3 as their default filesystem. Both distro's are
huge.
Both ext3 and reiser3 have a huge number of users. Both
filesystems also have got a number of religious followers. Ignore
them. Religion is no basis for a healty debate.

>> IMHO reiser4 should be merged and be marked as experimental.
>
> IMHO ReiserFS 4 should not be merged into Linus' kernel. So what? It is not
> my call (nor yours).

By having this discussion we shape our opinions. We inspire
others to form their own opinion. Maybe we even inspire Linus to
have an opinion on the matter. Who knows.

>> should probably _always_ be marked as experimental, because we
>> _know_ we're going to need some other -- more generic -- API when
>> we decide we like the features of reiser4. The reiser4 APIs
>> should probably be implemented as generic VFS APIs. But since we
>> don't know yet what features we're going to use, let reiser4 be
>> self contained. Maybe reiser5 or reiser6 will follow standard
>> VFS-beyond-POSIX rules, with ext4 and JFS2 also implementing them.
>
> If is is /that/ experimental, it has no place in Linus' kernel at all. It
> is not (and has not been for a half dozen years at least) a playground for
> random experiments. Sure, you can fork off a branch for fooling around, you
> are even wellcome to keep your laboratory synched up with the version
> everybody is using, if that serves your needs.

I don't think it's a random experiment. Sure, it *is* an
experiment. IPv6 has been an experiment for some time too.

Sometimes you simply need to experiment on a larger scale than
possible simply in a private kernel fork. Why would Samba support
multi-fork files when almost nobody has access to kernels
supporting those files? Why would INN store its newsspool in
reiser4? Why would people think about the possibilities when the
standard kernel doesn't offer them?

>> It's just too damn hard to predict the future.
>
> Right. Instead of gambling it will turn out just as you think (why should I
> give /your/ view more weight than mine? or prefer views which have shown to
> be erroneous over the view of people who /have/ shaped the present we are
> in today?), why not wait and see?

Wait and see what others do? Clone their inventions? Chasing
taillights? Isn't Open Source the place where innovation is
supposed to happen?

>>                                                IMHO better just
>> merge reiser4 and let it be clear to everybody that reiser4 is an
>> experiment.
>
> IMHO much simpler just leaving experiments to experimental branches.

The simplest option is to stop developing linux, except for new
hardware drivers.

>> As long as it doesn't affect the rest of the kernel
>
> Impossible.

Then make sure those effects are positive. If you can say
'reiser4 got $feature wrong and I can do better' then that's a
win.

>>                                                      and it's
>> clear to the users that reiser4 is *not* going to be the
>> standard, it's fine with me.
>
> Now I'm at a complete loss... Why should it be placed in the standard
> kernel then?

Scale. Small experiments are fun, large experiments are even more
fun ;-)

-- 
Erik Hensema <erik@hensema.net>
