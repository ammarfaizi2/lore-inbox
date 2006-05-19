Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWESRhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWESRhX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWESRhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:37:23 -0400
Received: from xenotime.net ([66.160.160.81]:7056 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751406AbWESRhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:37:23 -0400
Date: Fri, 19 May 2006 10:39:52 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, akpm@osdl.org, clg@fr.ibm.com
Subject: Re: [PATCH 4/9] namespaces: utsname: switch to using uts namespaces
Message-Id: <20060519103952.10cdae1e.rdunlap@xenotime.net>
In-Reply-To: <m1lksy1j1o.fsf@ebiederm.dsl.xmission.com>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518154936.GE28344@sergelap.austin.ibm.com>
	<20060518170234.07c8fe4c.rdunlap@xenotime.net>
	<m1lksy1j1o.fsf@ebiederm.dsl.xmission.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2006 03:05:23 -0600 Eric W. Biederman wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> 
> > On Thu, 18 May 2006 10:49:36 -0500 Serge E. Hallyn wrote:
> >
> >> Replace references to system_utsname to the per-process uts namespace
> >> where appropriate.  This includes things like uname.
> >> 
> >> Changes: Per Eric Biederman's comments, use the per-process uts namespace
> >> 	for ELF_PLATFORM, sunrpc, and parts of net/ipv4/ipconfig.c
> >> 
> >> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> 
> >
> > OK, here's my big comment/question.  I want to see <nodename> increased to
> > 256 bytes (per current POSIX), so each field of struct <variant>_utsname
> > needs be copied individually (I think) instead of doing a single
> > struct copy.
> 
> Where is it specified?  Looking at the spec as SUSV3 I don't see a size
> specified for nodename.

It's actually for hostname.  It looks to me like they are used
interchangeably.  yes/no?

gethostname:
http://www.opengroup.org/onlinepubs/009695399/functions/gethostname.html
sysconf:
http://www.opengroup.org/onlinepubs/009695399/functions/sysconf.html
unistd.h:
http://www.opengroup.org/onlinepubs/009695399/basedefs/unistd.h.html
limits.h:
http://www.opengroup.org/onlinepubs/009695399/basedefs/limits.h.html

>From the latter:
{HOST_NAME_MAX}
    Maximum length of a host name (not including the terminating null) as returned from the gethostname() function.
    Minimum Acceptable Value: {_POSIX_HOST_NAME_MAX}
(and)
{_POSIX_HOST_NAME_MAX}
    Maximum length of a host name (not including the terminating null) as returned from the gethostname() function.
    Value: 255



> > I've been working on this for the past few weeks (among other
> > things).  Sorry about the timing.
> > I could send patches for this against mainline in a few days,
> > but I'll be glad to listen to how it would be easiest for all of us
> > to handle.
> >
> > I'm probably a little over half done with my patches.
> > They will end up adding a lib/utsname.c that has functions for:
> >   put_oldold_uname()	// to user
> >   put_old_uname()	// to user
> >   put_new_uname()	// to user
> >   put_posix_uname()	// to user
> 
> Sounds reasonable, if we really need a 256 byte nodename.
> 
> As long as they take a pointer to the appropriate utsname
> structure these patches should not fundamentally conflict.


---
~Randy
