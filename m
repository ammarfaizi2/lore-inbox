Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317140AbSG1Tk6>; Sun, 28 Jul 2002 15:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317152AbSG1Tk6>; Sun, 28 Jul 2002 15:40:58 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:58343 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S317140AbSG1Tk4>; Sun, 28 Jul 2002 15:40:56 -0400
Date: Sun, 28 Jul 2002 22:39:19 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.29 bad: schedule() with irqs disabled!
Message-ID: <20020728193919.GC683@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2.5.9 (latest bitkeeper, to be precise) dumps this message into
/var/log/messages within a few minutes after startup. Running xmms or
mozilla seems to do the trick. I ran two of the messages through
ksymoops and attach the results here, in case they are meaningful.=20
I'll be happy to help debug it further, if necessary.=20

Here's one such message:=20

Jul 28 22:28:54 tea kernel: bad: schedule() with irqs disabled!
Jul 28 22:28:54 tea kernel: cdf99cb0 c0275680 cf742580 cdf99cd8 c010fbf4 00=
000001 00000082 00000005=20
Jul 28 22:28:54 tea kernel:        c02ffbd8 fffffffa cdf99ce8 c010fc0b cf74=
2580 00000000 00000246 c0117b5f=20
Jul 28 22:28:54 tea kernel:        cdf98000 00000001 00000005 c0226170 c021=
a359 00000000 c032cbf8 cf72ea60=20
Jul 28 22:28:54 tea kernel: Call Trace: [<c010fbf4>] [<c010fc0b>] [<c0117b5=
f>] [<c0226170>] [<c021a359>]=20
Jul 28 22:28:54 tea kernel:    [<c01cf5e2>] [<c022507f>] [<c0226170>] [<c01=
e7195>] [<c01ebad6>] [<c0239488>]=20
Jul 28 22:28:54 tea kernel:    [<c023420c>] [<c0234c77>] [<c022ac87>] [<c01=
257d5>] [<c0110480>] [<c0126500>]=20
Jul 28 22:28:54 tea kernel:    [<c0246428>] [<c020c432>] [<c01103ab>] [<c01=
0ee05>] [<c020c629>] [<c0135886>]=20
Jul 28 22:28:54 tea kernel:    [<c0117dec>] [<c013597a>] [<c0106fff>]=20

And here are two of them passed through ksymoops:=20

mulix@tea:~$ ksymoops -m /boot/2.5-mx/System.map < ~/tmp/oops2
ksymoops 2.4.4 on i686 2.5.29.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.29/ (default)
     -m /boot/2.5-mx/System.map (specified)

cdf99cb0 c0275680 cf742580 cdf99cd8 c010fbf4 00000001 00000082 00000005=20
        c02ffbd8 fffffffa cdf99ce8 c010fc0b cf742580 00000000 00000246 c011=
7b5f=20
        cdf98000 00000001 00000005 c0226170 c021a359 00000000 c032cbf8 cf72=
9660=20
Call Trace: [<c010fbf4>] [<c010fc0b>] [<c0117b5f>] [<c0226170>] [<c021a359>=
]=20
   [<c01cf5e2>] [<c022507f>] [<c0226170>] [<c01e7195>] [<c01ebad6>] [<c0239=
488>]=20
   [<c023420c>] [<c0234c77>] [<c022ac87>] [<c0126500>] [<c0246428>] [<c020c=
432>]=20
   [<c020f7d3>] [<c010ee05>] [<c020c629>] [<c0135886>] [<c0117dec>] [<c0117=
d24>]=20
   [<c0117b1b>] [<c013597a>] [<c0106fff>]=20
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c010fbf4 <try_to_wake_up+144/150>
Trace; c010fc0b <wake_up_process+b/10>
Trace; c0117b5f <do_softirq+8f/a0>
Trace; c0226170 <ip_queue_xmit2+0/210>
Trace; c021a359 <nf_hook_slow+169/190>
Trace; c01cf5e2 <__elv_add_request+12/20>
Trace; c022507f <ip_queue_xmit+45f/4b0>
Trace; c0226170 <ip_queue_xmit2+0/210>
Trace; c01e7195 <ata_set_handler+75/90>
Trace; c01ebad6 <idedisk_do_request+456/670>
Trace; c0239488 <tcp_v4_send_check+78/c0>
Trace; c023420c <tcp_transmit_skb+55c/610>
Trace; c0234c77 <tcp_write_xmit+157/290>
Trace; c022ac87 <tcp_sendmsg+f67/1250>
Trace; c0126500 <filemap_nopage+f0/1e0>
Trace; c0246428 <inet_sendmsg+38/40>
Trace; c020c432 <sock_sendmsg+72/90>
Trace; c020f7d3 <alloc_skb+d3/1a0>
Trace; c010ee05 <do_page_fault+1a5/4b5>
Trace; c020c629 <sock_write+99/b0>
Trace; c0135886 <vfs_write+b6/140>
Trace; c0117dec <bh_action+1c/30>
Trace; c0117d24 <tasklet_hi_action+44/70>
Trace; c0117b1b <do_softirq+4b/a0>
Trace; c013597a <sys_write+2a/40>
Trace; c0106fff <syscall_call+7/b>


1 warning issued.  Results may not be reliable.
mulix@tea:~$ ksymoops -m /boot/2.5-mx/System.map < ~/tmp/oops
ksymoops 2.4.4 on i686 2.5.29.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.29/ (default)
     -m /boot/2.5-mx/System.map (specified)

cdf23cd4 c0275680 cf742580 cdf23cfc c010fbf4 00000001 00000096 00000001=20
c02ffbd0 fffffffc cdf23d0c c010fc0b cf742580 00000000 00000246 c0117b5f=20
cdf22000 00000001 00000003 c0226170 c021a359 00000000 c032cbf8 00000002=20
Call Trace: [<c010fbf4>] [<c010fc0b>] [<c0117b5f>] [<c0226170>] [<c021a359>=
]=20
c022507f>] [<c0226170>] [<c0239488>] [<c0239488>] [<c023420c>] [<c020f7d3>]=
=20
c02366d1>] [<c020f99b>] [<c022be04>] [<c02463d9>] [<c020c481>] [<c01c1ba3>]=
=20
c01c0830>] [<c020c585>] [<c0135746>] [<c0117dec>] [<c013593a>] [<c0106fff>]=
=20
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c010fbf4 <try_to_wake_up+144/150>
Trace; c010fc0b <wake_up_process+b/10>
Trace; c0117b5f <do_softirq+8f/a0>
Trace; c0226170 <ip_queue_xmit2+0/210>
Trace; c021a359 <nf_hook_slow+169/190>


1 warning issued.  Results may not be reliable.

--=20
http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9REhnKRs727/VN8sRAnIVAJ0Yc1BdVwSUJQXpsD38qfjoycNF3QCgpoSb
azndXuao7u76x5HqhkYxyWk=
=rAgE
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
