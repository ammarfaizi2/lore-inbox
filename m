Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRDYSKZ>; Wed, 25 Apr 2001 14:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130900AbRDYSKP>; Wed, 25 Apr 2001 14:10:15 -0400
Received: from client-141-151-171-161.bellatlantic.net ([141.151.171.161]:2977
	"HELO jmcmullan") by vger.kernel.org with SMTP id <S130768AbRDYSJ6>;
	Wed, 25 Apr 2001 14:09:58 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Jason McMullan <jmcmullan@linuxcare.com>
Newsgroups: local.linux.kernel
Subject: Re: SCSI-Multipath driver for 2.4?
Date: 25 Apr 2001 18:09:07 GMT
Organization: Matrix Fire Systems
Distribution: local
Message-ID: <9c73s3$tve$1@jmcmullan.evillabs.net>
In-Reply-To: <Pine.LNX.4.21.0104251311420.25506-100000@ameise.opto.de> <3AE6F884.6D68304D@redhat.com>
NNTP-Posting-Host: localhost.localdomain
X-Trace: jmcmullan.evillabs.net 988222147 30702 127.0.0.1 (25 Apr 2001 18:09:07 GMT)
X-Complaints-To: news@localhost
NNTP-Posting-Date: 25 Apr 2001 18:09:07 GMT
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.3 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford <dledford@redhat.com> wrote:
> When we reviewed the code, we didn't like it all that much.  It served it's
> purpose on the t3 stuff from Sun, but it wasn't generic enough to suit our
> tastes.

	True, but the MD layer in 2.2.x (at least as of last June, 
when I wrote the T3 SCSI-Alias-Chain failover code) was poorly documented, 
race-prone, and nasty. :^)  My _first_ attempt at multipath was with
the MD layer, but the 2.2.x code was just way too hairy for it to
work by the deadlines Sun had on us.

	So I went into the SCSI block handling layer. Only one
major race I had to avoid, and got the final implementation written 
in a week.

> (for instance, there
> are horribly stupid devices out there that support what is called
> "Active-Passive" multipath, where if you write to the passive path, it makes
> the active path error out, which makes the device 100% useless for
> multi-initiator, shared SCSI/FC environments, and makes the device total junk
> in my opinion, but if we are going to support them in a Multipath setup, then
> the multipath driver has to be modified so it doesn't attempt to touch passive
> paths until the active path has already failed, which it doesn't currently
> attempt to do when writing superblocks or reading partition tables).

	Interestingly enough, that is exactly the type of hardware that
the SCSI Alias Chains patch is designed to support - the Sun T3, IBM Shark,
etc. Nasty, evil critters, but supported. I do wish you the best of luck
with the MD layer version, since that's where it should have gone in
the first place.... If the MD layer had been up to snuff. ];^)


-- 
Jason McMullan, Senior Linux Consultant
Linuxcare, Inc. 412.432.6457 tel, 412.656.3519 cell
jmcmullan@linuxcare.com, http://www.linuxcare.com/
Linuxcare. Putting open source to work.
