Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWI3A5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWI3A5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWI3A5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:57:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40845 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932384AbWI3A5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:57:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Adrian Bunk <bunk@stusta.de>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, 76306.1226@compuserve.com, ebiederm@xmission.com
Subject: Re: [PATCH] fix EMBEDDED + SYSCTL menu
References: <20060928204251.a20470c5.rdunlap@xenotime.net>
	<20060929160521.GF3469@stusta.de>
	<20060929092446.6e2227b4.rdunlap@xenotime.net>
Date: Fri, 29 Sep 2006 18:55:45 -0600
In-Reply-To: <20060929092446.6e2227b4.rdunlap@xenotime.net> (Randy Dunlap's
	message of "Fri, 29 Sep 2006 09:24:46 -0700")
Message-ID: <m18xk2goku.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@xenotime.net> writes:

> On Fri, 29 Sep 2006 18:05:21 +0200 Adrian Bunk wrote:
>
>> On Thu, Sep 28, 2006 at 08:42:51PM -0700, Randy Dunlap wrote:
>> > From: Randy Dunlap <rdunlap@xenotime.net>
>> > 
>> > SYSCTL should still depend on EMBEDDED.  This unbreaks the
>> > EMBEDDED menu (from the recent SYSCTL_SYCALL menu option patch).
>> > 
>> > Fix typos in new SYSCTL_SYSCALL menu.
>> > 
>> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
>> > ---
>> >  init/Kconfig |   14 +++++++-------
>> >  1 files changed, 7 insertions(+), 7 deletions(-)
>> > 
>> > --- linux-2618-g10.orig/init/Kconfig
>> > +++ linux-2618-g10/init/Kconfig
>> > @@ -257,6 +257,9 @@ config CC_OPTIMIZE_FOR_SIZE
>> >  
>> >  	  If unsure, say N.
>> >  
>> > +config SYSCTL
>> > +	bool
>> > +
>> >  menuconfig EMBEDDED
>> >  	bool "Configure standard kernel features (for small systems)"
>> >  	help
>> > @@ -272,11 +275,8 @@ config UID16
>> >  	help
>> >  	  This enables the legacy 16-bit UID syscall wrappers.
>> >  
>> > -config SYSCTL
>> > -	bool
>> > -
>> 
>> ACK
>> 
>> >  config SYSCTL_SYSCALL
>> > -	bool "Sysctl syscall support"
>> > +	bool "Sysctl syscall support" if EMBEDDED
>> >  	default n
>> >  	select SYSCTL
>> >  	---help---
>> >...
>> 
>> You could achieve the same by removing the option...
>> 
>> Simply move SYSCTL_SYSCALL to the same place you are moving SYSCTL to 
>> without fiddling with the dependencies.
>
> Yes, I realize that (I even had that patch earlier).
> I don't care which way it's done.  Eric, any preference here?

Not really.  The point of this patch is to bring the sys_sysctl discussion
to a conclusion.  Either we don't support it and no one uses it.  Or
someone actually uses it so we need to support it.  The stupid case in
glibc where it tests for an SMP kernel when it should be using uname
and has a fallback into /proc/sys doesn't count.

Eric

p.s.  I'm confused I only saw this message through lkml.  I'm wondering
why haven't I gotten it normally yet.
