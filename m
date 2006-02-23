Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751725AbWBWKwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbWBWKwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 05:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWBWKwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 05:52:39 -0500
Received: from mail-gw-2.br-online.de ([195.37.215.44]:61922 "EHLO
	mail-gw-2.br-online.de") by vger.kernel.org with ESMTP
	id S1751725AbWBWKwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 05:52:38 -0500
Message-ID: <43FD93E4.8010405@ii-consult.com>
Date: Thu, 23 Feb 2006 11:52:20 +0100
From: Badri Pillai <badri@ii-consult.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Martin Drab <drab@kepler.fjfi.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM [ATI fglrx 2.6.15 put_page BUG]
References: <43E34662.1000704@ii-consult.com> <Pine.LNX.4.61.0602031340350.11546@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0602031340350.11546@goblin.wat.veritas.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi all,

Thanks again for prompt replies.

To be honest, due to time factor I couldn't try the patches.

But the latest?? 8.22.5 Linux driver from ATI works fine
with 2.6.15.2.

Except for the follwoing error---in /var/log/Xorg.0.log
(II) fglrx(0): Kernel Module Version Information:
(II) fglrx(0):     Name: radeon
(II) fglrx(0):     Version: 1.19.0
(II) fglrx(0):     Date: 20050911
(II) fglrx(0):     Desc: ATI Radeon
(WW) fglrx(0): Kernel Module version does *not* match driver.
(EE) fglrx(0): incompatible kernel module detected - HW accelerated
OpenGL will not work
(II) fglrx(0): [drm] removed 1 reserved context for kernel
(II) fglrx(0): [drm] unmapping 8192 bytes of SAREA 0xe0ae5000 at 0xb7a55000
(WW) fglrx(0): ***********************************************
(WW) fglrx(0): * DRI initialization failed!                  *
(WW) fglrx(0): * (maybe driver kernel module missing or bad) *
(WW) fglrx(0): * 2D acceleraton available (MMIO)             *
(WW) fglrx(0): * no 3D acceleration available                *
(WW) fglrx(0): ********************************************* *
- -----------------------------

But since I don't use my laptop for plaing games, I can live with it.

Kind Regards and happy hacking,

Badri
Hugh Dickins wrote:
> On Fri, 3 Feb 2006, Badri Pillai wrote:
> 
>>Problem summary: after upgrading to from 2.6.15.1 -> 2.6.15.2
>>the system dumps following trace, when trying to reboot through KDE 3.5:
> 
> 
> I doubt it's anything new in 2.6.15.2.
> 
> 
>>- ------------[ cut here ]------------
>>kernel BUG at mm/swap.c:49!
>>invalid operand: 0000 [#2]
> 
> 
> That's #2 so there should have been an earlier one, but never mind...
> 
> 
>>SMP
>>Modules linked in: nls_utf8 ntfs snd_rtctimer ipv6 fglrx ....
> 
> 
> ATI's fglrx is Tainting your kernel.
> 
> 
>>EIP:    0060:[<c013fbce>]    Tainted: P    B VLI
>>EFLAGS: 00013256   (2.6.15.2_DL6)
> 
> 
> I don't know 2.6.15.2_DL6, but never mind...
> 
> 
>>EIP is at put_page+0x4a/0x66
>>Process X (pid: 1682, threadinfo=db55e000 task=c17fe570)
> 
> 
> And further down...
> 
> 
>> [<c013fbce>] put_page+0x4a/0x66
>> [<c01ba078>] avc_has_perm_noaudit+0x37/0xe3
>> [<e1c93717>] drm_free+0xb7/0x150 [fglrx]
>> [<e1c93717>] drm_free+0xb7/0x150 [fglrx]
>> [<c0103273>] error_code+0x4f/0x54
>> [<e1c9007b>] FGLDRM__vm_info+0xa0/0x16b [fglrx]
>> [<e1c9007b>] FGLDRM__vm_info+0xa0/0x16b [fglrx]
>> [<c013fbce>] put_page+0x4a/0x66
>> [<c0143a8b>] zap_pte_range+0x172/0x236
>> [<c0143bf8>] unmap_page_range+0xa9/0xf8
>> [<c0143d48>] unmap_vmas+0x101/0x1e2
>> [<c0147606>] unmap_region+0x92/0xf8
>> [<c0147877>] do_munmap+0xd9/0xef
>> [<c01478dd>] sys_munmap+0x50/0x68
>> [<c0102717>] sysenter_past_esp+0x54/0x75
> 
> 
> Yes, fglrx definitely looks implicated.  ATI were carefully coding
> around an anomaly in our page count handling, then 2.6.15 removed
> that anomaly, so their wrapper code needs an additional #ifdef on
> Linux kernel version.  I'll forward you offline what Martin Drab
> posted a few weeks back.
> 
> Hugh
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD/ZPkgNsg6g2ylScRApypAJ9lJp+T5ljBPPwxbOoU6Hb6300FygCfTGmk
V1uzgSNSNw73gmEF6sFTdlo=
=qu/m
-----END PGP SIGNATURE-----
