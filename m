Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135268AbRDRThA>; Wed, 18 Apr 2001 15:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135269AbRDRTgu>; Wed, 18 Apr 2001 15:36:50 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:20202 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S135268AbRDRTgh>;
	Wed, 18 Apr 2001 15:36:37 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Kravetz <mkravetz@sequent.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.LNX.4.31.0104171200220.933-100000@penguin.transmeta.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 18 Apr 2001 12:35:47 -0700
In-Reply-To: Linus Torvalds's message of "Tue, 17 Apr 2001 12:48:48 -0700 (PDT)"
Message-ID: <m33db680h8.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

Sounds good so far.  Some comments.

>  - FS_create is responsible for allocating a shared memory region
>    at "FS_create()" time.

This is not so great.  The POSIX shared semaphores require that an
pthread_mutex_t object placed in a shared memory region can be
initialized to work across process boundaries.  I.e., the FS_create
function would actually be FS_init.  There is no problem with the
kernel or the helper code at user level allocating more storage (for
the waitlist of whatever) but it must not be necessary for the user to
know about them and place them in share memory themselves.

The situation for non-shared (i.e. intra-process) semaphores are
easier.  What I didn't understand is your remark about fork.  The
semaphores should be cloned.  Unless the shared flag is set there
should be no sharing among processes.


The rest seems OK.  Thanks,

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
