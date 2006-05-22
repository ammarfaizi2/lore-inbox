Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWEVQlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWEVQlV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 12:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWEVQlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 12:41:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52706 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750980AbWEVQlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 12:41:21 -0400
To: Sam Vilain <sam@vilain.net>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, ebiederm@xmission.com, xemul@sw.ru,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Cedric Le Goater <clg@fr.ibm.com>, serue@us.ibm.com
Subject: Re: [PATCH] namespaces: uts_ns: make information visible via
 /proc/PID/uts directory
References: <20060522052425.27715.94562.stgit@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 22 May 2006 10:39:08 -0600
In-Reply-To: <20060522052425.27715.94562.stgit@localhost.localdomain> (Sam
 Vilain's message of "Mon, 22 May 2006 17:24:25 +1200")
Message-ID: <m11wumm2tv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain <sam@vilain.net> writes:

> From: Sam Vilain <sam.vilain@catalyst.net.nz>
>
> Export the UTS information to a per-process directory /proc/PID/uts,
> that has individual nodes for hostname, ostype, etc - similar to
> those in /proc/sys/kernel
>
> This duplicates the approach used for /proc/PID/attr, which involves a
> lot of duplication of similar functions.  Much room for maintenance
> optimisation of both implementations remains.
> ---
> Sorry for the duplication of this to the list, stuffed up the stgit
> command.
>
> After doing this I noticed that the whole way this is done via sysctls
> in /proc/sys is much, much nicer.  I was going there to make
> /proc/sys/kernel/osname -> /proc/self/uts/sysname (etc), but it seems
> that symlinks from /proc/sys are not a done thing.
>
> Is there an argument here perhaps for some integration between the way
> this is done for /proc/sys and /proc/PID/xxx ?
>
>  fs/proc/base.c |  236 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 236 insertions(+), 0 deletions(-)

Good intentions :)
But since this doesn't actually fix /proc/sys/kernel/osname and friends.
I would call this implementation a failure.

Let's first fix /proc/sys/kernel/osname to be sensitive to the caller,
and then see if we can make /proc/sys a symlink to /proc/<pid>/sys


Eric
