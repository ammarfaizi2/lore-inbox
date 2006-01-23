Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWAWVVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWAWVVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWAWVVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:21:24 -0500
Received: from mail.gmx.de ([213.165.64.21]:21135 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964773AbWAWVVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:21:24 -0500
X-Authenticated: #428038
Date: Mon, 23 Jan 2006 22:21:19 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: CD writing in future Linux (stirring up a hornets' nest) (was: Rationale for RLIMIT_MEMLOCK?)
Message-ID: <20060123212119.GI1820@merlin.emma.line.org>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <20060123105634.GA17439@merlin.emma.line.org> <1138014312.2977.37.camel@laptopd505.fenrus.org> <20060123165415.GA32178@merlin.emma.line.org> <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org> <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1138048255.21481.15.camel@mindpipe>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006, Lee Revell wrote:

> You will be happy to know that in future Linux distros, cdrecord will
> not require setuid to mlock() and get SCHED_FIFO - both are now
> controlled by rlimits, so if the distro ships with a sane PAM/group
> configuration, all you will need to do is add cdrecord users to the
> "realtime" or "cdrecord" or "audio" group.

Sounds really good. Can you give a pointer as to the detailed rlimit
requirements?

Anyways, this seems like a very good point in time to pick up the old
discussion of ide-scsi, ide-cd and thereabouts, because your
announcement met Jörg's criterion that Linux had to make a step forward
in his direction before he'd try to negotiate again.

I'm more of a user who is annoyed by this war of warning messages
(ide-scsi claiming it's unsuitable for CD writing, cdrecord calling
/dev/hd* badly designed, and all that), and I'd appreciate if people
could just

1. compile a list of their requirements,

2. find out the current state of affairs,

3. match the lists found in 1 and 2

4. ONLY AFTER THAT negotiate who is going to change what to make things
   work better for us end users.

Of course, I think it's sensible to expect that Linux should adhere to
standards (POSIX) as far as possible, and if any precedent
implementations that are standards-conformant are found, I'd suggest
that Linux adheres to their interpretation, too, to reduce the clutter
and make applications more easily ported to Linux. We'll all benefit.

LIST 1 # REQUIREMENTS

R1 I'll just say we all want cdrecord, dvd recording applications and
similar to work without setuid root flags or sudo or other excessive
privilege escalation. (This needs to be split up into I/O access
privileges, device enumeration, buffer allocation, real-time
requirements such as locking buffers into memory, scheduling and so on.)

LIST 2 # CURRENT STATE

S1 Jörg is unhappy with /dev/hd* because he says that it is inferior to
the sg-access via ide-scsi. (I believe the original issues were
DMA-based, and I don't know the details.) I hope Jörg will fill in the
operations that ide-cd (/dev/hd*) lacks. (Jörg, please don't talk about
layer violations here).

S2 Jörg is concerned about the SCSI command filter being too
restrictive. I'm not sure if it still applies to 2.6.16-rc and what the
exact commands in question were. I'll let Jörg complete this list.

S3 Device enumeration/probing is a sore spot. Unprivileged "cdrecord
dev=ATA: -scandisk" doesn't work, and recent discussions on the cdwrite@
list didn't make any progress. My observation is that cdrecord stops
probing /dev/hd* devices as soon as one yields EPERM, on the assumption
"if I cannot access /dev/hda, I will not have sufficient privilege to
write a CD anyways". I find this wrong, Jörg finds it correct and argues
"if you can access /dev/hdc as unprivileged user, that's a security
problem".

These topics I brought up are my recollections from memory, without
archive research, that I deem worth developing into either requirements
or "state-of-the-art" assertions of the "we're already there" kind.

Please, everybody, ONLY list what you would like to do, why, why it
doesn't work. Please DO NOT TELL THE OTHER SIDE HOW they are supposed to
do it, unless it's worded as a polite and patient question. We've been
there, and it didn't work.

I hope this is getting a more fruitful discussion than last time.

-- 
Matthias Andree
