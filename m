Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291746AbSBNQUF>; Thu, 14 Feb 2002 11:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291756AbSBNQTy>; Thu, 14 Feb 2002 11:19:54 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:5371 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S291746AbSBNQTr>;
	Thu, 14 Feb 2002 11:19:47 -0500
Date: Thu, 14 Feb 2002 10:19:43 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org, drepper@redhat.com, torvalds@transmeta.com
Subject: Re: setuid/pthread interaction broken? 'clone_with_uid()?'
Message-ID: <46860000.1013703583@baldur>
In-Reply-To: <20020214170748.B17490@outpost.ds9a.nl>
In-Reply-To: <20020214165143.A16601@outpost.ds9a.nl>
 <38300000.1013702447@baldur> <20020214170748.B17490@outpost.ds9a.nl>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, February 14, 2002 17:07:48 +0100 bert hubert <ahu@ds9a.nl>
wrote:

>> It's the expected behavior for a task-based model like Linux.  Each task
>> is independent and inherits the uid/gid from whoever called clone().
>> It's just one of several resources that are specified as process-wide in
>> POSIX, but are per-task in Linux.
> 
> Could this also be solved by making threads call 'clone' themselves? 

The only workaround I can think of is, as you discovered, to do the
setuid() call before you create any threads, and thus create underlying
kernel tasks.  Once the kernel tasks have been created each one has its own
credentials and has to be changed separately.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

