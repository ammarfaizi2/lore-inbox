Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318013AbSIER6Y>; Thu, 5 Sep 2002 13:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318014AbSIER6Y>; Thu, 5 Sep 2002 13:58:24 -0400
Received: from tank.panorama.sth.ac.at ([193.170.53.11]:22219 "EHLO
	tank.panorama.sth.ac.at") by vger.kernel.org with ESMTP
	id <S318013AbSIER6T>; Thu, 5 Sep 2002 13:58:19 -0400
Date: Thu, 5 Sep 2002 20:02:53 +0200
From: Peter Surda <shurdeek@panorama.sth.ac.at>
To: linux-kernel@vger.kernel.org
Subject: odd network freezing, reboot fixed
Message-ID: <20020905180253.GC2567@noir.cb.ac.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux noir 2.4.9-31
X-Editor: VIM - Vi IMproved 6.0 (2001 Sep 26, compiled Jan 28 2002 06:08:06)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear kernel developers and other guys with deep linux knowledge,

I am posting here because I think this is an interesting story, and even if
noone can find a answer now, maybe this can serve as a reference for future.

I am not sure what information is relevant to the story, so I'll try to
mention anything I consider relevant.

The story is about what happened yesterday to one of our servers,
morpheus.panorama.sth.ac.at (picture here:
http://morpheus.panorama.sth.ac.at/morpheus.jpg). The machine is a P166/48MB
RAM, 2*13GB Quantum on Soft-Raid-1 (hda and hdc), 2*ne2kpci (Realtech 8029
chip), 3*parallel port, some isa VGA (unused, no X, no fbdev). The board is a
(according to lspci): Host bridge: Intel Corporation 430HX - 82439HX TXC
[Triton II] (rev 03). It runs on RH6.2 with latest updates, however, when the
story was happening, it wasn't running the latest kernel available from RH,
but 2.2.19-6.2.1. (the latest kernel, 2.2.19-6.2.16, was installed but there
was no reboot in between).

There are printers on all 3 LPTs, but only eth1 is connected to the network
(eth0 has no cable connected to it).

The machine runs mainly bind, apache, dhcpd, postgres, sendmail, imapd/ipop3d,
aprwatch, samba and lpd.

Sometime the day before yesterday, its uptime reached 497 days + something and
the uptime counter rolled over. I read about this limit before so I was
expecting that this happens. I know this may be totally unrelated to the whole
phenomenon, but I think I should mention it.

Suddenly, several hours after this rollover happened, following symptoms have
been happening for about 6 hours: for a couple of minutes, the network was
failing completely, and then after some more minutes, it magically "appeared"
again.

Description of what I mean with "failing completely": Active connections
froze, I couldn't even ping and tcpdump on a second computer (actually I tried
several) didn't show any packets from the network card. It may be that there
were SOME packets which a switched ethernet would filter, but at least then
there wouldn't be dozens of
arp who has morpheus tell machine1
arp who has morpheus tell machine1
arp who has morpheus tell machine1
arp who has morpheus tell machine1
arp who has morpheus tell machine1
arp who has morpheus tell machine1
arp who has morpheus tell machine1
arp who has morpheus tell machine1
, would there? (same with machine2 and ...., the name machine is just a bogus
one to demonstrate)

I wasn't present on site during the time, so I was instructing a colleague
over a phone what to do and was trying to ssh into it. He was sitting in front
of the machine and looking at it when this odd stuff was happning. There were
no suspicious physical activities. He also tried replugging the ether cable
(without any effect). There are several more computers connected to the same
switch, all in the same room, and the computers were working normally and
there was nobody playing with the switch.

After an hour I couldn't figure out WTF was happening, I told the guy to pull
the power plug (ctrl-alt-del is disabled, so are the reset and power buttons
and I didn't want to tell the root password over phone). The machine then
loaded the new kernel, after about 10 minutes of fscking started up and since
then there were no problems, the raid arrays took a couple of hours to resync
but didn't report any errors.

So, now to the details on what DIDN'T cause the problem. The machine collects
quite a lot of statistics, and you can check it out under
http://morpheus.panorama.sth.ac.at/mrtg/
(ignore the "ADSL" statistics, they don't have any mean anything useful).
The odd stuff was happening about between about 12:00 and 18:00 local time
yesterday.
As you see:
- no large network activity (the router statistics concur,
  http://router.panorama.sth.ac.at/morpheus.html)
- no odd load peaks (those you see are caused by secondary mx flushing queue
  when the connection was working temporarily).
- no overly swap usage
- no overly disk or CPU activity

Furthermore, I found out that
- there was plenty of disk space available
- ifconfig didn't show any errors (to be more precise the counters of
  errors/overruns/carrier didn't change between the outages).
- there was noone logged on besides me (I also checked this interactively
  during the short times the network connection was working).
- other than network outages, the machine was working as usual.

I also checked the logs for hardware failure or intrusion activity (actually I
check them regularly at least once a day) and didn't find anything odd. The
machine is IMHO secured pretty good: all packages updated (I don't think the
old kernel had remotely expoitable bugs), firewall both locally and on the
router, logcheck, viperdb. I don't claim it's 100% secure, just that a real
cracker probably wouldn't cause problems like this and a script kiddie
probably wouldn't get in at all, and if, (s)he'd be detected.

My conclusion is that the most probable cause is a bug in kernel, because I
think the other causes are less probable. Hardware problems wouldn't be fixed
by reboot and there would be something in logs. Userspace programs are
unlikely to cause this. Unauthorised access is also not very likely.

Now that the server works flawlessly again, I don't need to actually "repair"
this, but I think this should be researched in order to prevent it. If it was
you-know-what-operating-system, I'd find it normal that reboot fixes things,
but this is linux and it shouldn't be like this, "what, you mean you had to
reboot your server only after 497 days? that sucks." :-)

If needed I can provide full logs for the last 6 months and logcheck/viperdb
reports from roughly the last 2 years. I can also provide any additional
information if needed.

Please comment on this. I'd also like to ask you to cc me, as I'm not on the
list (I could look up the answers on some web archives but all I found take a
day to update).

Oh, and by "yesterday" I mean 4th September 2002, and by local time CEST.

Bye,

Peter Surda (Shurdeek) <shurdeek@panorama.sth.ac.at>, ICQ 10236103, +436505122023

--
            It is easier to fix Unix than to live with NT.

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9d5xNzogxsPZwLzcRAnUDAJ95r7p0f9bc3tcMo5fLBedtqO+zWQCggd6f
+chWkudLwBwVYl8a9vaFniM=
=DvE/
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
