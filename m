Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291306AbSBMB6a>; Tue, 12 Feb 2002 20:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291305AbSBMB6T>; Tue, 12 Feb 2002 20:58:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47624 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291306AbSBMB6H>;
	Tue, 12 Feb 2002 20:58:07 -0500
Message-ID: <3C69C7E9.E01C3532@zip.com.au>
Date: Tue, 12 Feb 2002 17:56:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: What is a livelock? (was: [patch] sys_sync livelock fix)
In-Reply-To: <3C69A18A.501BAD42@zip.com.au>,
		<3C69A18A.501BAD42@zip.com.au> (Andrew Morton's message of
	 "Tue, 12 Feb 2002 15:13:14 -0800") <87y9hyw4b6.fsf@tigram.bogus.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche wrote:
> 
> Andrew Morton <akpm@zip.com.au> writes:
> 
> > The get_request fairness patch exposed a livelock
> > in the buffer layer.  write_unlocked_buffers() will
> > not terminate while other tasks are generating write traffic.
> 
> The subject says it: what is a livelock? How is it different
> from a deadlock?
> 

http://www.huis.hiroshima-u.ac.jp/jargon/LexiconEntries/Livelock.html

livelock

/li:v'lok/ n. A situation in which some critical stage of a task is
unable to finish because its clients perpetually create more work
for it to do after they have been serviced but before it can clear its
queue. Differs from {deadlock} in that the process is not blocked or
waiting for anything, but has a virtually infinite amount of work to
do and can never catch up. 


This exactly describes the sync problem.  But we also use the
term `livelock' to describe one of the Linux VM's favourite
failure modes: madly spinning on page lists and not finding
any useful work to do.  Which is slightly different.

-
