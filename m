Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280813AbRKYP1u>; Sun, 25 Nov 2001 10:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280872AbRKYP1f>; Sun, 25 Nov 2001 10:27:35 -0500
Received: from smtp02.uc3m.es ([163.117.136.122]:31500 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S280813AbRKYP12>;
	Sun, 25 Nov 2001 10:27:28 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200111251527.QAA05393@nbd.it.uc3m.es>
Subject: Re: Severe Linux 2.4 kernel memory leakage
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <1006699767.1178.0.camel@gandalf.chabotc.com> "from Chris Chabot
 at Nov 25, 2001 03:49:27 pm"
To: Chris Chabot <chabotc@reviewboard.com>
Date: Sun, 25 Nov 2001 16:27:20 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Chris Chabot wrote:"
> The box has ran Redhat 7.1 and 7.2, with plain vanilla linux kernels
> 2.4.9 upto 2.4.15, in all situations the same problem appeared.
> 
> The problem is that when the box boots up, it uses about 60Mb of memory.
> However after only 1 1/2 days, the memory usage is already around 430Mb
> (!!). (this is ofcource used - buffers - cache, as displayed by 'free').

I also have this problem. Unknown circumstances provoke it. Kernel
2.4.9 to 2.4.13.  When it occurs I lose about 30MB a day.

Dual 500MHz i686, 4 scsi disks (adaptec) under raid5 and raid0
with 2 intelpro's and 1 IDE disk (and xfs and lvm).

Right now I'm on 2.4.9 and it's NOT happening. Doing nothing different
to any other day.

> When the box keeps on running for about a month, the memory usage gets
> so high that it turns into a swap-crazy, low-memory and slow server ;-/
> (it does free up cache memory, and swaps stuff out, however the 'leaked'
> memory only grows and is never re-claimed).

Same.

> The box runs dhcpd, bind, fetchmail (cron), pppd (to adsl modem), smb,
> nfs, xinetd (imapd mostly) and sshd.

Only thing in common with me is nfs. Running X 4.1. glibc 2.1.

> based routing) for my cable modem & adsl modem. Also it has a 310Gb raid
> 0 array on 4 IDE disks.

Could be.

> The hardware on the box is : Asus p2b-ds, 2x p3-600, 1Gb (ECC) ram, 3

My mobo is whatever came from dell, and you also are running 2xP3. My
ram is also ECC but there's only 128MB of it.

> network cards (1x Intel EtherExpressPro, 2x 3c905 tx), Internal adaptect

I have 2 network cards, both EEPRO.

> 29xx u2w scsi, internal intel IDE, 2x Seagate Cheetah (u2w) 18 Gb disks

Yep, I have internal adaptec too. Aic7xxx running ultra 160 at 20MHz
on terminated cable.

  Adaptec AIC7xxx driver version: 6.2.1
  aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/255 SCBs

4 WD disks:

Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: WDIGTL   Model: WDE9100 ULTRA2   Rev: 1.21
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: WDIGTL   Model: WDE9100 ULTRA2   Rev: 1.21
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: WDIGTL   Model: WDE9100 ULTRA2   Rev: 1.21
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: WDIGTL   Model: WDE9100 ULTRA2   Rev: 1.21
  Type:   Direct-Access                    ANSI SCSI revision: 02

> (/ and /var), 4x 80 Gb Maxtor IDE disks (raid 0 array) and a NVidia TNT2
> card. This hardware 

Umm .. I think I run ati rage, external card, though there is one on
the mobo.

(--) PCI:*(0:16:0) ATI Mach64 GU rev 154, Mem @ 0xf5000000/24,
0xfe201000/12, I/O @ 0xd400/8
(--) PCI: (1:0:0) ATI Mach64 GW rev 122, Mem @ 0xfc000000/24,
0xfbfff000/12, I/O @ 0xec00/8

> The kernel is compiled with all network- and scsi card and raid0 drivers
> build in, and nfs + iptables as modules. The machine currently uses ext3

I have it all compiled OUT. Including iptables, which I don't use.

> (also build in), however this problem was also present before i
> converted the raid0 volume to ext3, so i do not suspect it to cause this

I am using xfs on top of lvm on top of raid5.

> problem. The kernel is also set for HIGHMEM (4gb) to use the last Mb's
> of the 1Gb of ram (else 127Mb isnt detected).

Mine isn't. Normal setup.

> I do not know which component (iptables / route hack / raid0 / network
> cards / highmem) cause this problem. I run several of these components

Looks from this as though it might be raid5 or 0 + adaptec scsi + SMP.

Peter
