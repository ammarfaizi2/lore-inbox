Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291269AbSBGUOE>; Thu, 7 Feb 2002 15:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291266AbSBGUNr>; Thu, 7 Feb 2002 15:13:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:65410 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291267AbSBGUNc>;
	Thu, 7 Feb 2002 15:13:32 -0500
Date: Thu, 7 Feb 2002 23:09:16 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: yodaiken <yodaiken@fsmlabs.com>
Cc: Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@zip.com.au>,
        torvalds <torvalds@transmet.com>, rml <rml@tech9.net>,
        nigel <nigel@nrg.org>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <20020207125601.A21354@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0202072305480.2976-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Feb 2002, yodaiken wrote:

> So what's the difference between combi_spin and combi_mutex?
> combi_spin becomes
> 	if not mutex locked, spin
> 	else sleep
> Bizzare

no, the real optimization is that when spin meets spin, they will not
mutex. If a mutex-user has it then spins turn into mutex, but that (is
supposed to) happen rarely.

i think one example *could* be to turn inode->i_sem into a combi-lock. Eg.
generic_file_llseek() could use the spin variant.

this is a real performance problem, i've seen scheduling storms in
dbench-type runs due to llseek taking the inode semaphore.

whether combi-locks truly bring performance benefits remains to be seen,
but the patch definitely needs to provide some working example and some
hard numbers for some real workload.

	Ingo

