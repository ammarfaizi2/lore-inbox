Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVCIDiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVCIDiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 22:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVCIDiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 22:38:21 -0500
Received: from mail.joq.us ([67.65.12.105]:17564 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261424AbVCIDhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 22:37:55 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       cfriesen@nortelnetworks.com, chrisw@osdl.org, hch@infradead.org,
       rlrevell@joe-job.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050112185258.GG2940@waste.org>
	<200501122116.j0CLGK3K022477@localhost.localdomain>
	<20050307195020.510a1ceb.akpm@osdl.org>
	<20050308043349.GG3120@waste.org>
	<20050307204044.23e34019.akpm@osdl.org>
	<87acpesnzi.fsf@sulphur.joq.us> <20050308063344.GM3120@waste.org>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 08 Mar 2005 21:39:24 -0600
In-Reply-To: <20050308063344.GM3120@waste.org> (Matt Mackall's message of
 "Mon, 7 Mar 2005 22:33:44 -0800")
Message-ID: <87zmxd4heb.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Andrew Morton <akpm@osdl.org> writes:
>> > Does anyone have serious objections to this approach?

> On Mon, Mar 07, 2005 at 11:30:57PM -0600, Jack O'Quin wrote:
>> 1. is likely to introduce multiuser system security holes like the one
>> created recently when the mlock() rlimits bug was fixed (DoS attacks)

Matt Mackall <mpm@selenic.com> writes:
> I wouldn't say "likely". But anything's possible, so I wouldn't rule
> it out entirely.

I wasn't predicting a bug in your code, just pointing to a known PAM
problem.  The lack of good documentation and overly obscure PAM
interfaces cause some (most?) distributions to ship with broken PAM
configurations.  Debian includes pam_limits.so in seven different
/etc/pam.d files, yet their /etc/security/limits.conf is empty.

When the recent mlock() rlimits bug fix was merged, it had the
unintended effect of suddenly granting almost every user unlimited
mlock() privileges.  I suspect something similar will happen for this
new rlimit.  Mounting a DoS attack becomes child's play for anyone.

This is OK for me, but a disaster for shared system admins.  That is
why these kinds of API changes should be avoided in a stable release.

The big advantage of the LSM approach is that we can be confident it
will have no effect on systems that do not load it.  Further, the
sysadmin can easily check that it's not present.  None of that is true
for this rlimits API change.

>> 2. requires updates to all the shells
>
> Requires update to the PAM distro for our purposes. 

That, too.

>> 3. forces Windows and Mac musicians to learn and understand PAM
>
> Or for the distro (ubuntu or whatever) to catch up. The alternative is
> for the user to compile their own kernel module and mess with its
> arcane interface.

No, this LSM is already included in several distributions.

>> 4. is undocumented and has never been tested in any real music studios
>
> Well you'll have a bit to test it before it goes to Linus.

Only toy tests will be possible without the required userspace tools.
-- 
  joq
