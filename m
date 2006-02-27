Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWB0Ui0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWB0Ui0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWB0Ui0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:38:26 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:61967 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964811AbWB0UiZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:38:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oVwV76DCUHhmO8+Kzg2Cz+ah9R4lYZ4HLYTXuqd3HqJF1JLTAi1wL6BXjMCBShpFzrBngr6TlstSqp31UkRaPnWSwK6DsPb2coxOF2ol/PZgMRXau3qQcLxuAhbIDkOYgL22OkEMHquBsin1DN3mNm0qbB74iglgKgqe5PN31y4=
Message-ID: <d6fe45ba0602271238q10fea0f8tfc29f0d51c4df1c8@mail.gmail.com>
Date: Mon, 27 Feb 2006 21:38:22 +0100
From: "matteo brancaleoni" <mbrancaleoni@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Bio & Biovec-1 increasing cache size, never freed during disk IO
In-Reply-To: <d6fe45ba0602251245h32b9ac5dw65246ed6e1bba607@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d6fe45ba0602251245h32b9ac5dw65246ed6e1bba607@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, this problem on 2.6.14.7 does not happens at all...

anyone has any idea about?

Greetings, Matteo.

On 2/25/06, matteo brancaleoni <mbrancaleoni@gmail.com> wrote:
> Hi.
>
> I'm experiencing a problem with 2.6.15.4 / 2.6.16-rc4, noticed during
> high disk IO (copying a lot of data between 2 machines): the system
> memory get filled up, until the full swap is used and the system must
> be rebooted (or is unusable). Stopping the process does not free the
> memory, and happens not only copying via network, but also with a
> simple
> cp -a dirwithmanybigfiles testdir.
>
> The system is running on athlon64:
> Linux morgor 2.6.16-rc4 #2 SMP Sat Feb 25 19:55:36 CET 2006 x86_64
> x86_64 x86_64 GNU/Linux
> Same issue with 2.6.15.4
>
> The box has a single soft-raid1 device made by 2 sata disk on promise
> controller.
> Attached slabinfo dump and dmesg dump.
>
> Some system informations:
> * This is the modules list:
> Linux morgor 2.6.16-rc4 #2 SMP Sat Feb 25 19:55:36 CET 2006 x86_64
> x86_64 x86_64 GNU/Linux
> [root@morgor ~]# lsmod
> Module                  Size  Used by
> ipv6                  399008  18
> ppdev                  42888  0
> autofs4                55560  1
> nfs                   251224  2
> lockd                  97424  2 nfs
> nfs_acl                37120  1 nfs
> sunrpc                191944  4 nfs,lockd,nfs_acl
> rfcomm                105376  0
> l2cap                  92160  5 rfcomm
> bluetooth             117252  4 rfcomm,l2cap
> dm_mirror              54912  0
> dm_mod                 90192  1 dm_mirror
> video                  50952  0
> button                 41120  0
> battery                43912  0
> ac                     38920  0
> lp                     48208  0
> parport_pc             63144  1
> parport                74636  3 ppdev,lp,parport_pc
> nvram                  42888  0
> ohci1394               67272  0
> ehci_hcd               65160  0
> sg                     69672  0
> ieee1394              392216  1 ohci1394
> uhci_hcd               65952  0
> snd_via82xx            63784  0
> gameport               50832  1 snd_via82xx
> snd_ac97_codec        136536  1 snd_via82xx
> snd_ac97_bus           36224  1 snd_ac97_codec
> snd_seq_dummy          37508  0
> snd_seq_oss            66688  0
> snd_seq_midi_event     41472  1 snd_seq_oss
> snd_seq                90144  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
> snd_pcm_oss            85632  0
> snd_mixer_oss          51328  1 snd_pcm_oss
> snd_pcm               126728  3 snd_via82xx,snd_ac97_codec,snd_pcm_oss
> snd_timer              59656  2 snd_seq,snd_pcm
> snd_page_alloc         44816  2 snd_via82xx,snd_pcm
> snd_mpu401_uart        42112  1 snd_via82xx
> snd_rawmidi            61696  1 snd_mpu401_uart
> snd_seq_device         43280  4 snd_seq_dummy,snd_seq_oss,snd_seq,snd_rawmidi
> i2c_viapro             43160  0
> snd                    97320  11
> snd_via82xx,snd_ac97_codec,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
> i2c_core               57728  1 i2c_viapro
> skge                   72720  0
> soundcore              44576  1 snd
> raid1                  54912  2
> ext3                  163984  2
> jbd                    93480  1 ext3
> sata_promise           45700  6
> sata_via               42500  0
> libata                 93592  2 sata_promise,sata_via
> sd_mod                 50688  8
> scsi_mod              180688  4 sg,sata_promise,libata,sd_mod
>
> * fstab
> [root@morgor ~]# cat /etc/fstab
> /dev/md1                /                       ext3    defaults        1 1
> /dev/md0                /boot                   ext3    defaults        1 2
> devpts                  /dev/pts                devpts  gid=5,mode=620  0 0
> tmpfs                   /dev/shm                tmpfs   defaults        0 0
> proc                    /proc                   proc    defaults        0 0
> sysfs                   /sys                    sysfs   defaults        0 0
> LABEL=SWAP-sda2         swap                    swap    defaults        0 0
> LABEL=SWAP-sdb2         swap                    swap    defaults        0 0
>
> * cpuinfo
> [root@morgor ~]# cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 47
> model name      : AMD Athlon(tm) 64 Processor 3200+
> stepping        : 0
> cpu MHz         : 1800.000
> cache size      : 512 KB
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext
> fxsr_opt lm 3dnowext 3dnow pni lahf_lm
> bogomips        : 3613.48
> TLB size        : 1024 4K pages
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management: ts fid vid ttp tm stc
>
> Thanks a lot,
>
> Matteo Brancaleoni
>
>
>
