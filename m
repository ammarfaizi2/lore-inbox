Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbTH1JAH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 05:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263948AbTH1I7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 04:59:18 -0400
Received: from [213.69.232.58] ([213.69.232.58]:59658 "HELO
	flapp.schottelius.org") by vger.kernel.org with SMTP
	id S263913AbTH1I5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 04:57:54 -0400
Date: Thu, 28 Aug 2003 10:55:49 +0200
From: Nico Schottelius <nico-linux-admin-ml@schottelius.org>
To: Ross Clarke <encrypted@geekz.za.net>
Cc: Linux-Admin <linux-admin@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Crazy load average & unkillable processes
Message-ID: <20030828085549.GB264@schottelius.org>
References: <3F4D339A.8010907@geekz.za.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <3F4D339A.8010907@geekz.za.net>
User-Agent: Mutt/1.4i
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux flapp 2.6.0-test4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Very interesting..
with the test4 I experiene the same/similar problems on my laptop..
all of sudden yesterday several programs died -> Out of Memory.
I ran
   Xfree
   dhcpcd
   opera=20
   several xterms (about 6)
   qmail
   named

first opera was Out of Memory, then died the whole X system with all
xterms and X beeing Out of Memory.

MemTotal:       385600 kB

which should be more than enough!

Nico


Ross Clarke [Thu, Aug 28, 2003 at 12:41:30AM +0200]:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Brandon wrote:
>=20
> |Hi Everyone,
> |
> |    I'm having some bothersome problems with a couple servers of
> |mine.  I'm hoping some of you have some advice on how to trouble shoot
> |this, because my little brain is running out of ideas.
> |
> |All the servers are running Redhat 7.3, 2.4.20-19smp kernels,
> |apache-1.3.27, and Soft Raid-1.
> |
> |Here is what is happening, all of  a sudden the server load average
> |climbs real high.  It climbs to 100+ within a few minutes, then
> |constantly grows after that.  The last server that had this happen was
> |at 375 avg when I rebooted it, which always needs to be a hard reboot -
> |because the shutdown -r now command doesn't do anything.
> |
> |While this is happening, I can not run commands like 'ps fax', 'pstree',
> |'top', 'killall' etc without them hanging .  Most other commands work. I
> |can SSH to the server no problem.  If I do a 'ps ax' I can see a list of
> |processes, but it always hangs before displaying them all. I narrowed it
> |down to anything that needs a full process list hangs.
> |
> |I wrote a script that runs 'ls -la /proc/$P', and 'cat /proc/$P/cmdline'
> |on each process in /proc.
> |
> |What I found is the processes that hang ps and whatnot are all owned by
> |apache.  The script hangs on the ls -la /proc/$P whenever it hits an
> |apache process.  The processes it hangs on can not be killed with kill
> |-9.  The number of apache owned processes was at 250, while on a regular
> |server it is only at 20 or so.
> |
> |Running sar -v shows the dentunusd grow huge at about the time of the
> |issues:
> |
> |04:30:00 PM dentunusd   file-sz  %file-sz  inode-sz  super-sz %super-sz
> |dquot-sz %dquot-sz  rtsig-sz %rtsig-sz
> |05:30:00 PM     38823     25900     12.35     24755         0      0.00
> |0      0.00         7      0.68
> |05:40:00 PM     39757     25854     12.33     25054         0      0.00
> |0      0.00         7      0.68
> |05:50:00 PM 4294967057     23526     11.22      4303         0      0.00
> |0      0.00        18      1.76
> |
> |Also, the number of sockets grows by about 3X:
> |
> |4:30:00 PM    totsck    tcpsck    udpsck    rawsck   ip-frag
> |04:40:00 PM       136        60         5         0         0
> |04:50:00 PM       112        35         5         0         0
> |05:00:00 PM       121        40         7         0         0
> |05:10:00 PM       126        44         5         0         0
> |05:20:00 PM       115        38         5         0         0
> |05:30:00 PM       119        36         8         0         0
> |05:40:00 PM       120        42         6         0         0
> |05:50:00 PM       526       236         5         0         1
> |06:00:00 PM       531       224         5         0         0
> |06:10:00 PM       535       224         5         0         0
> |
> |
> |That is just about all I have come up so far.  If anyone has seen this,
> |or can recommend on what steps I should take next, I could certainly us
> |the advice.
> |
> |Thank you all
> |
> |Brandon Belshaw
> |
> |
> |
> |
> |
> |-
> |To unsubscribe from this list: send the line "unsubscribe linux-admin" in
> |the body of a message to majordomo@vger.kernel.org
> |More majordomo info at  http://vger.kernel.org/majordomo-info.html
> |
>=20
> I just had the same similiar problem twice with 2.6.0-test4, I also used
> to experience it on 2.4.18. I managed to get ps to list tho, before all
> commands stopped working, and I noticed many of the proccesses went into
> D and Z states. I beleive they were getting stuck in the I/O subsystem,
> my other filesystems were still responding since my XMMS didnt die till
> it hit an mp3 on my main filesystem, which was about 30 minutes after
> the problem started. Any currently open application was still working,
> until I tried to do anything that required I/O, then  they died aswell.
> That last happened to me about 12 hours ago, and I had to recover my
> entire /home directory. I couldnt find out what cuased it, the first
> time it was MozillaFirebird that died first, the 2nd time it was vim.
> Also both times I tried hitting the power button to see if I could get
> any form of shutdown where the data would sync, both times the kernel
> OOPS'ed on the apmd event.
>=20
> Anybody got any ideas?
>=20
> Regards,
> Ross Clarke
>=20
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
> Comment: Using GnuPG with Mozilla Thunderbird - http://enigmail.mozdev.org
>=20
> iD8DBQE/TTOa1+7fkD/L8TgRAkmdAJ9ciSYT6tAQGT0Uk+RD7Y8gkbmEIwCffLIT
> z2SGntQl8+1sI1QRVFZtxho=3D
> =3DutNU
> -----END PGP SIGNATURE-----
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-admin" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
quote:   there are two time a day you should do nothing: before 12 and afte=
r 12
         (Nico Schottelius after writin' a very senseless email)
cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.=
new
url:     http://nerd-hosting.net - domains for nerds (from a nerd)

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/TcOVzGnTqo0OJ6QRAtFUAJ0QCvTQAQkO3VUuiybqhjjS+dwZIQCfXdig
7yAWlIP03E9blXAXHOWFHbw=
=m1jH
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
