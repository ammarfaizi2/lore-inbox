Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272324AbRIEWMr>; Wed, 5 Sep 2001 18:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272341AbRIEWMi>; Wed, 5 Sep 2001 18:12:38 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:20311 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S272324AbRIEWM3>; Wed, 5 Sep 2001 18:12:29 -0400
Date: Wed, 5 Sep 2001 17:12:48 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200109052212.RAA64901@tomcat.admin.navo.hpc.mil>
To: joe@mathewson.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Secure network fileserving Linux <-> Linux
In-Reply-To: <200109051913.f85JD2K01304@ambassador.mathewson.int>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Mathewson <joe@mathewson.co.uk>:
> 
> Sorry to ask another annoying question so quickly after my SCSI problems,
> but
> 
> Does anyone know of/use a secure network filesharing system on a Linux
> network?  We currently have a room of about 10 machines, mostly Linux
> clients (some MacOS X, soon to come Sun and HP-UX boxes) and servers (all
> running Linux).
> 
> For some time now, we've been using NFS for filesharing /home and have been
> extremely concerned about security.  All the clients in theory run the same
> uids/gids, thanks to LDAP, but that doesn't stop someone plugging in an
> unauthorized machine and merrily destroying everyone's home directories.
> 
> Apparently some work was done to Kerberize various bits of NFS, and Sun
> have a secure(r) implementation in Solaris.
> 
> Does anyone know of a free (preferably easy :) way of secure Linux <->
> Linux filesharing?  Apologies if that seems like a flame, maybe I've missed
> the obvious solution.  (Preferably a solution that doesn't involve editing
> /etc/exports to only allow connections from specified IPs, because if
> someone was going to go to the length of destroying our data, they could
> fake that.  Similarly, MAC addresses.)

Free if someone already owns a .357 Magnum.... (well, cost of ammo:)....

First answer:

	Not possible.
	1. You pose an unsecured network (anyone can plug in a host)
	2. Physical access to the hosts (anyone could reconfigure a host)
	3. No physical security (anyone can get in the room, with unauthorized
	   equipment).

Kerberos won't help either - The only parts of NFS that were kerberized
was the initial mount. Everything else uses filehandles/UDP. Encryption
doesn't help either - slows the entire network down too much.

Second answer:

	1. Get physical security over the network. Prevent unauthorized
	   personnel from adding unauthorized equipment.
	2. Now prevent external logical monitoring of the network with a
	   switched environment (prevents one host from seeing traffic
	   targeted at a different host).
	3. Use kerberos for general user logins.
	4. Do not let users have direct physical access to the hosts.

Usually, you don't have enough money invested in a user lab (which is what
it sounds like) to make it worth the effort to apply.

Third answer:

	A more reasonable way is to configure the user accessable systems as
	just X terminals (no MACs though) on a switched ethernet. Configure
	the switch with	a fixed MAC address for each target (prevents hardware
	substitution). Now you can put the actual user work machines as compute
	servers in a different room. The compute servers (the ones users log
	into) can then use a physically isolated network (users can't plug
	things into it) for NFS to a file server.

This is still more extensive (and expensive) than a small lab is usually
willing to accept.

Fourth answer:

	The minimum would be to use a switched ethernet, with fixed MAC
	addressing. This prevents walk-in users from substituting equipement,
	and it limits the ability to sniff the network. Only packets destined
	for one IP would be visible, and the switch should be able to signal
	an alarm if it detects an unauthorized MAC address (as well as refuse
	to work). This still allows for NFS, and a higher throughput as well
	(each node can use the full bandwidth).

The fourth answer is more likely to be acceptable to management and the users
(the carrot is the higher performance). It doesn't help the reconfiguration
possiblity (booting a floppy with a different OS on a host already authorized
to use the network).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
