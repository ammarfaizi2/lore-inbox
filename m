Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291732AbSBNQBX>; Thu, 14 Feb 2002 11:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291736AbSBNQBN>; Thu, 14 Feb 2002 11:01:13 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:45533 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291732AbSBNQAz>; Thu, 14 Feb 2002 11:00:55 -0500
Date: Thu, 14 Feb 2002 10:00:47 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
cc: drepper@redhat.com, torvalds@transmeta.com
Subject: Re: setuid/pthread interaction broken? 'clone_with_uid()?'
Message-ID: <38300000.1013702447@baldur>
In-Reply-To: <20020214165143.A16601@outpost.ds9a.nl>
In-Reply-To: <20020214165143.A16601@outpost.ds9a.nl>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, February 14, 2002 16:51:43 +0100 bert hubert <ahu@ds9a.nl>
wrote:

> When a process first issues setuid() and then goes on to create threads,
> those threads run under the setuid() uid - all is well. 
> 
> However,  once the first thread is created, only the thread calling
> setuid() gets setuid in fact. All new threads continue to be created as
> root.
> 
> This behaviour exists under 2.2.18 with glibc 2.1.3 and under 2.4.17 with
> glibc 2.2.5, and is shown using the brief program attached.
> 
> Is this by design? It appears that all threads created get the uid of the
> thread manager process.

It's the expected behavior for a task-based model like Linux.  Each task is
independent and inherits the uid/gid from whoever called clone().  It's
just one of several resources that are specified as process-wide in POSIX,
but are per-task in Linux.

I've been working on a patch to allow clone() to specify shared
credentials, but it's been on the back burner.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

