Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132492AbRCZQwD>; Mon, 26 Mar 2001 11:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132488AbRCZQvy>; Mon, 26 Mar 2001 11:51:54 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9965 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S132492AbRCZQvp>;
	Mon, 26 Mar 2001 11:51:45 -0500
Message-ID: <3ABF7376.D6F79A4B@mandrakesoft.com>
Date: Mon, 26 Mar 2001 11:51:02 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: wing tung Leung <tg@skynet.be>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
        urban@svenskatest.se
Subject: Re: via-rhine driver: wicked 2005 problem
In-Reply-To: <3ABEEAFE.81CA76A3@colorfullife.com> <20010326185641.A19619@skynet.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wing tung Leung wrote:
> It doesn't solve the (less urgent) problem of not being able the use the
> NIC after a warm boot in M$ Windows. As I said, pulling the power cord from
> the ATX power supply and reinserting it, makes it go away.

Would it be possible for you to re-run your tests against kernel
2.4.3-pre8?  (ftp://ftp.us.kernel.org/pub/linux/kernel/testing/)

This is the "official" latest version of the via-rhine driver, and it
includes Manfred's patch, as well as a pci_enable_device movement might
solve your problem.

If the problem is still not solved, could you download via-diag.c and
libmii.c from ftp://www.scyld.com/pub/diag/   Compile instructions are
at the bottom of via-diag.c.  I'm interested in seeing two via-diag
register snapshots, one from a cold boot (where it is working), and one
from a warm boot.

  ./via-diag -maaavvveef > via-diag-cold.txt
	and
  ./via-diag -maaavvveef > via-diag-warm.txt
	then
   diff -u v*cold.txt v*warm.txt | send mail...

And to see if the PCI configuration registers change between warm boot
and cold boot, run lspci from pciutils:

  lspci -vvvxxx > lspci-cold.txt
	and
  lspci -vvvxxx > lspci-warm.txt
	then
  diff -u l*cold.txt l*warm.txt | send mail...

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
