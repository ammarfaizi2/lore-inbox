Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312570AbSDJOrd>; Wed, 10 Apr 2002 10:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313175AbSDJOrc>; Wed, 10 Apr 2002 10:47:32 -0400
Received: from [195.157.147.30] ([195.157.147.30]:53514 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S312570AbSDJOrb>; Wed, 10 Apr 2002 10:47:31 -0400
Date: Wed, 10 Apr 2002 15:49:38 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Christoph Rohland <cr@sap.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        Geoffrey Gallaway <geoffeg@sin.sloth.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Ramdisks and tmpfs problems
Message-ID: <20020410154938.G4493@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Christoph Rohland <cr@sap.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Geoffrey Gallaway <geoffeg@sin.sloth.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020409144639.A14678@sin.sloth.org> <20020410084505.A4493@dev.sportingbet.com> <200204101028.g3AAS2X05866@Port.imtp.ilyichevsk.odessa.ua> <20020410114521.C4493@dev.sportingbet.com> <m3662zzs6y.fsf@linux.wdf.sap-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 01:52:37PM +0200, Christoph Rohland wrote:
> Hi Sean,
> 
> On Wed, 10 Apr 2002, Sean Hunter wrote:
> >> /dev is for devices, why do you use it for mounting filesystems?
> > 
> > Normally yes, but the tmpfs provides posix shared memory semantics
> > and thus /dev/shm is the "normal" place to mount it.  Don't blame
> > me.
> 
> Yes, and he does not want to use it for POSIX shared mem, but as a
> local filesystem. So he should mount it where he needs it and
> definitely not misunse the posix mount for different things.

The whole point was that he was doing extra copies and mount/unmounts that he
didn't need.   He couldn't just mount it in /etc/ in the first place because he
needed to copy stuff from the underlying fs that was there onto the tmpfs.

point -------------------------->
<------------- Christoph Rohland

Which is why I proposed two mounts:

(1) A mount under /dev/shm reflecting its nature and role as providing posix
shared mem (convenient because its not /etc where he already _has_ files)

(2) A bind mount under /etc reflecting its nature and role as providing a
ram-based file system (convenient because that's where he actually wants the fs
to be)

I just suggested that by mounting it what has been established as the canonical
place for mounting tmpfs and using a bind mount he doesn't need the extra
copies/mounts.

Sheesh.  Next thing you'll be asking if a filesystem can have buddha nature.

Sean "Mu" Hunter
