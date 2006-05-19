Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWESMAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWESMAN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 08:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWESMAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 08:00:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5290 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932292AbWESMAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 08:00:11 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       xemul@sw.ru, haveblue@us.ibm.com, akpm@osdl.org, clg@fr.ibm.com
Subject: Re: [PATCH 4/9] namespaces: utsname: switch to using uts namespaces
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518154936.GE28344@sergelap.austin.ibm.com>
	<20060518170234.07c8fe4c.rdunlap@xenotime.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 19 May 2006 05:58:22 -0600
In-Reply-To: <20060518170234.07c8fe4c.rdunlap@xenotime.net> (Randy Dunlap's
 message of "Thu, 18 May 2006 17:02:34 -0700")
Message-ID: <m1r72qz0o1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> OK, here's my big comment/question.  I want to see <nodename> increased to
> 256 bytes (per current POSIX), so each field of struct <variant>_utsname
> needs be copied individually (I think) instead of doing a single
> struct copy.
>
> I've been working on this for the past few weeks (among other
> things).  Sorry about the timing.
> I could send patches for this against mainline in a few days,
> but I'll be glad to listen to how it would be easiest for all of us
> to handle.
>
> I'm probably a little over half done with my patches.
> They will end up adding a lib/utsname.c that has functions for:
>   put_oldold_unmame()	// to user
>   put_old_uname()	// to user
>   put_new_uname()	// to user
>   put_posix_uname()	// to user

Looking 256 at least makes sense to hold a dns fully qualified domain
name.  So even if it isn't specified by posix is make sense.

Can we please make the structure we return to user space look something
like:

struct long_utsname {
	char *sysname;
	char *nodename;
	char *release;
	char *version;
	char *machine;
        char *domainname;
        char buf[0];
}

int sys_long_uname(char *buf, size_t bufsz);

So we don't hard code the maximum length of these strings into the user
interface, and can just return more by increasing our buffer size.

Eric
