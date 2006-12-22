Return-Path: <linux-kernel-owner+w=401wt.eu-S965189AbWLVPVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbWLVPVT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 10:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWLVPVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 10:21:19 -0500
Received: from lilly.ping.de ([83.97.42.2]:3024 "HELO lilly.ping.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965189AbWLVPVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 10:21:18 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 10:21:18 EST
Date: Fri, 22 Dec 2006 16:01:17 +0100
From: Patrick Mau <mau@oscar.ping.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061222150117.GA21557@oscar.prima.de>
References: <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com> <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org> <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> <20061221012721.68f3934b.akpm@osdl.org> <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com> <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org> <20061222100004.GC10273@deprecation.cyrius.com> <20061222021714.6a83fcac.akpm@osdl.org> <1166790275.6983.4.camel@localhost> <20061222123249.GG13727@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222123249.GG13727@deprecation.cyrius.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 01:32:49PM +0100, Martin Michlmayr wrote:
> * Andrei Popa <andrei.popa@i-neo.ro> [2006-12-22 14:24]:
> > With all three patches I have corruption....
> 
> I've completed one installation with Linus' patch plus the two from
> Andrew successfully, but I'm currently trying again... but I really
> need a better testcase since an installation takes about an hour.
> Andrei, which torrent do you download as a testcase?  It would be good
> if someone could suggest a torrent which is legal and not too large.

Hi everyone,

I have been reading this thread for the last few days, but have been
silent. I have 3 torrents here for testing, if you want.

You can easily reproduce with "rtorrent", if you:

- Have a completly downloaded one, no matter what size
- Corrupt the download with
  dd if=/dev/zero of=download.file bs=16k count=1
- Restart 'rtorrent', hash-check fails
- It will download 1 piece that was corrupted.

The important part here is that rtorrent transfers one piece,
using its own code sequence to write to the file.

Let me offer to test until Saturday afternoon CET,
I have a cloned git repository, downloaded torrent files and "apt".

My systems that are affected are:

Linux oscar 2.6.18 SMP (2x450Mhz Intel P3)
(rolled back to 2.6.18 but can boot latest git)

Linux tony 2.6.20-git UP
(can be tested using all kinds of "apt" operations)

Both machines are using:
IDE  -> MD-RAID1 -> LVM -> EXT3 (data=ordered)
SCSI -> MD-RAID5 -> .....

I don't want to disturb your technical discussion,
just offering some help in testing.

Regards,
Patrick

