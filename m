Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbTJHVyZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 17:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTJHVyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 17:54:25 -0400
Received: from mail.inter-page.com ([12.5.23.93]:34572 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261234AbTJHVyX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 17:54:23 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'bert hubert'" <ahu@ds9a.nl>, "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: Wed, 8 Oct 2003 14:54:02 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAVDpoTOBv7UOXEobzssb2gwEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <20031008104726.GA4655@outpost.ds9a.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, the pthread library is at a higher level than the clone() system
call (where I was phrasing my debate.)

That library already does "the right thing" by requesting that the file
descriptors be shared explicitly.  It must for the pthread paradigm to work.
Therefore it presumably still will.

That is libpthread "does" and "should" make the requests for new OS threads
with the unified file descriptor table case.  So the below will keep working
as expected.

I was barking up a different tree with my arguments.  (e.g. what is the
minimal definition of thread in the mind of the kernel.)

So unless the pthread implementer makes a mistake, the POSIX level of
abstraction will be right regardless.

Rob.

-----Original Message-----
From: bert hubert [mailto:ahu@ds9a.nl] 
Sent: Wednesday, October 08, 2003 3:47 AM
To: Linus Torvalds
Cc: Robert White; 'Albert Cahalan'; 'Ulrich Drepper'; 'Mikael Pettersson';
'Kernel Mailing List'
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?

On Tue, Oct 07, 2003 at 05:54:35PM -0700, Linus Torvalds wrote:

> But the same isn't true of file descriptors or a lot of other software-
> level abstractions. There are no inherent advantages to sharing, and in
> fact sharing just gives more opportunity for race conditions, bad
> interaction etc.

I may be missing something, I'm all for the ability to have threads with
their own fd namespace, but will NPTL/Linux retain the capability to pass
fd's to other threads?

One thing I've used in tens of programs is:

void *session(void *p)
{
	int fd=(int)p;
	...
}
...

for(;;) {
	fd=accept();
	pthread_create_thread(session,(void*)fd);
}

I'd like to continue to have that ability.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO


