Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317464AbSGVPbh>; Mon, 22 Jul 2002 11:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317469AbSGVPbh>; Mon, 22 Jul 2002 11:31:37 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:25739 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317464AbSGVPbf>; Mon, 22 Jul 2002 11:31:35 -0400
Date: Mon, 22 Jul 2002 10:34:37 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: modutils 2.4.18 is available 
In-Reply-To: <29877.1027323947@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44.0207221009350.28150-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, Keith Owens wrote:

> Changelog extract
> 
> 	* Optionally only check the numeric part of the kernel and module
> 	  version, insmod -N.  This option is always set for kernel >= 2.5, it
> 	  defaults to off for earlier kernels.
> 
> This change should have been in modutils 2.4.17 but it slipped through
> my TODO list.  This patch goes with the 2.5 kernel change
> http://marc.theaimsgroup.com/?l=linux-kernel&m=102595659604735&w=2
> 
> Checking the complete version string (including EXTRAVERSION) is a
> waste of time.  For historical reasons, insmod only checks the first
> 32 characters of the version string, many users have longer version
> strings.  Users make significant changes to their config and kernel but
> do not change the version string, as a test for compatibility this is
> pointless.  Above all, storing the full string in kernel module.h
> forces a complete rebuild when you change one character in
> EXTRAVERSION.  So you have a test that is incomplete, unreliable and
> has horrible side effects, time to kill it.
> 
> As always, the default for modutils on stable kernels is no change to
> existing behaviour, unless the user requests it.
> 
> For kernel 2.5 and later, insmod only checks the numeric version
> number.  With modutils 2.4.18 and the above kernel patch, changing
> EXTRAVERSION no longer forces a complete kernel rebuild.

Look, what am I supposed to make out of this? I posted to lkml that I
think it is worth discussing if the removal of the EXTRAVERSION check is
worth the drawbacks (pro: much fewer recompiles only because EXTRAVERSION
changes, con: No error/warning when insmoding modules compiled for a
different EXTRAVERSION). I did mention that modutils would need to be
adapted in case the change goes in.

Now, you don't care to reply to that mail, but instead you just go ahead 
and release a new version of modutils. Obviously, you don't care about 
discussing the idea at all, you just put forward the facts - now 
modutils don't check EXTRAVERSION no matter if the patch goes into the 
kernel or not.

Personally, I don't care much about the issue at all, I think I can handle
insmoding the right modules even without the check (still, who of the
people here hasn't seen the error "foo.o was compiled for kernel A but
this is kernel B" before). But I think there are people who do care
(probably those having to do with distribution kernels and lots of
non-developers).  I may be wrong, and nobody cares about the change, then
it's fine with me.

Anyway, if your argument was true, why don't you kill the check of the
numeric part as well? You say the check isn't completely reliable, as it
only compares 32 chars. As you're patching modutils anyway, you could BTW
as well correct that behavior. The only thing I agree with is that it has
side-effects, i.e. causing recompiles only to update the version string.

W.r.t reliability, as I'm just thinking about learning to fly, I may have
something (rather obvious) to contribute from there. The trick is
minimizing risk is not so much minimizing the failure rate of one
component, but rather building the system in a way that it needs multiple
problems to cause a fatal failure. E.g., your engine has two magnetos.
Even if the chance of one of them failing is 1:1000, the chance of both of
them failing at the same time and thus taking your engine down is
1:1000000. You argued against modversions since it's not 100% reliable,
and now against the EXTRAVERSION for the same reason. But if you have
multiple of these not 100% reliable tests, the combination will get you
very close to 100% reliability. Which is good enough even for flying.

--Kai


