Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWJJUyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWJJUyq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 16:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWJJUyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 16:54:46 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:62402 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1030354AbWJJUyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 16:54:45 -0400
From: "=?iso-8859-9?q?S=2E=C7a=F0lar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: Ondemand/Conservative not working with 2.6.18
Date: Tue, 10 Oct 2006 23:54:42 +0300
User-Agent: KMail/1.9.5
Cc: "Dave Jones" <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <EB12A50964762B4D8111D55B764A8454B6B4F1@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454B6B4F1@scsmsx413.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1289007.QoBqDNZ3GS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610102354.48789.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1289007.QoBqDNZ3GS
Content-Type: text/plain;
  charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

10 Eki 2006 Sal 02:35 tarihinde, Pallipadi, Venkatesh =FEunlar=FD yazm=FD=
=FEt=FD:=20
> What CPU is this? Pentium M?

Yes it is.

caglar@zangetsu ~ $ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.73GHz
stepping        : 8
cpu MHz         : 1733.000
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
=20
cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx up est tm2
bogomips        : 3460.59


> What driver was getting used in 2.6.16 kernel to change freqency?
> Acpi-cpufreq?

No, i used speedstep-centrino with 2.6.16.

> Can you please make sure you have configured in both speedstep-centrino a=
nd
> acpi-cpufreq drivers. Things should work with both these drivers so that
> the best one will be used based on your BIOS support.

I tried acpi-cpufreq but it didnt create /sys/devices/system/cpu/cpu0/cpufr=
eq=20
directory and there is no warning/error exists on dmesg.

zangetsu cpu0 # lsmod | grep acpi
acpi_cpufreq            7620  0
freq_table              4640  1 acpi_cpufreq
processor              30920  2 acpi_cpufreq,thermal
zangetsu cpu0 # lsmod | grep ondemand
cpufreq_ondemand        6604  0
zangetsu cpu0 # cd /sys/devices/system/cpu/cpu0/
zangetsu cpu0 # ls
crash_notes  topology

zangetsu cpu0 # rmmod cpufreq_ondemand
zangetsu cpu0 # rmmod acpi_cpufreq
zangetsu cpu0 # modprobe speedstep-centrino
zangetsu cpu0 # lsmod | grep speed
speedstep_centrino      8768  0
freq_table              4640  1 speedstep_centrino
processor              30920  2 speedstep_centrino,thermal
zangetsu cpu0 # lsmod | grep ondemand
cpufreq_ondemand        6604  0
zangetsu cpu0 # cd /sys/devices/system/cpu/cpu0/
zangetsu cpu0 # ls
cpufreq  crash_notes  topology
zangetsu cpu0 # cd cpufreq/
zangetsu cpufreq # echo "ondemand" > scaling_governor
zangetsu cpufreq # cat scaling_governor
ondemand
zangetsu cpufreq # cat scaling_available_frequencies
1733000 1333000 1067000 800000
zangetsu cpufreq # cat scaling_cur_freq
1733000

But frequency never changes and stays at 1.73ghz

zangetsu cpufreq # echo "powersave" > scaling_governor
zangetsu cpufreq # cat scaling_cur_freq
800000
zangetsu cpufreq # echo "performance" > scaling_governor
zangetsu cpufreq # cat scaling_cur_freq
1733000

Cheers=20
=2D-=20
S.=C7a=F0lar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart1289007.QoBqDNZ3GS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFLAiYy7E6i0LKo6YRAjovAKDH6A4dauj0NOY+A5ZM8qSGpKiYaQCfcncZ
5RyGHkMJedjRBNROTK8c8jM=
=pgTs
-----END PGP SIGNATURE-----

--nextPart1289007.QoBqDNZ3GS--
