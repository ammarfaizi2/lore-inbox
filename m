Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWIWJgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWIWJgr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 05:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWIWJgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 05:36:47 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:3283 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751399AbWIWJgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 05:36:46 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Dave Jones <davej@redhat.com>
Subject: Re: [BUG] warning at kernel/cpu.c:38/lock_cpu_hotplug()
Date: Sat, 23 Sep 2006 12:36:34 +0300
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200609230145.21997.caglar@pardus.org.tr> <20060922231342.GA8414@redhat.com>
In-Reply-To: <20060922231342.GA8414@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1449310.dxxeGCdh2m";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609231236.40547.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1449310.dxxeGCdh2m
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

23 Eyl 2006 Cts 02:13 tarihinde, Dave Jones =C5=9Funlar=C4=B1 yazm=C4=B1=C5=
=9Ft=C4=B1:=20
> On Sat, Sep 23, 2006 at 01:45:16AM +0300, S.=C3=87a=C4=9Flar Onur wrote:
>  > Hi;
>  >
>  > With kernel-2.6.18, "modprobe cpufreq_stats" always (i can reproduce)
>  > gaves following;
>  >
>  > ...
>  > Lukewarm IQ detected in hotplug locking
>  > BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
>  >  [<b0134a42>] lock_cpu_hotplug+0x42/0x65
>  >  [<b02f8af1>] cpufreq_update_policy+0x25/0xad
>  >  [<b0358756>] kprobe_flush_task+0x18/0x40
>  >  [<b0355aab>] schedule+0x63f/0x68b
>  >  [<b01377c2>] __link_module+0x0/0x1f
>  >  [<b0119e7d>] __cond_resched+0x16/0x34
>  >  [<b03560bf>] cond_resched+0x26/0x31
>  >  [<b0355b0e>] wait_for_completion+0x17/0xb1
>  >  [<f965c547>] cpufreq_stat_cpu_callback+0x13/0x20 [cpufreq_stats]
>  >  [<f9670074>] cpufreq_stats_init+0x74/0x8b [cpufreq_stats]
>  >  [<b0137872>] sys_init_module+0x91/0x174
>  >  [<b0102c81>] sysenter_past_esp+0x56/0x79
>
> This should do the trick.
> I'll merge the same patch into cpufreq.git
>
> 		Dave

Ill try

> --- linux-2.6.18.noarch/drivers/cpufreq/cpufreq_stats.c~	2006-09-22
> 19:12:57.000000000 -0400 +++
> linux-2.6.18.noarch/drivers/cpufreq/cpufreq_stats.c	2006-09-22
> 19:13:03.000000000 -0400 @@ -350,12 +350,10 @@ __init
> cpufreq_stats_init(void)
>  	}
>
>  	register_hotcpu_notifier(&cpufreq_stat_cpu_notifier);
> -	lock_cpu_hotplug();
>  	for_each_online_cpu(cpu) {
>  		cpufreq_stat_cpu_callback(&cpufreq_stat_cpu_notifier, CPU_ONLINE,
>  			(void *)(long)cpu);
>  	}
> -	unlock_cpu_hotplug();
>  	return 0;
>  }
>  static void

What about cpufreq_stats_exit, it has same locking? Seems like rmmod may ca=
use=20
same problem or im totaly wrong?

Cheer
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart1449310.dxxeGCdh2m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFFQAoy7E6i0LKo6YRAvkyAJ9f19rUocanH/7GrzKtJE0HIYxP7wCeIjdo
2cHRw5oedb75gYcr9mt8mxk=
=NMJl
-----END PGP SIGNATURE-----

--nextPart1449310.dxxeGCdh2m--
