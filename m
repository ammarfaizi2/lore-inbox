Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbSLNUq4>; Sat, 14 Dec 2002 15:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSLNUqz>; Sat, 14 Dec 2002 15:46:55 -0500
Received: from adsl-65-64-152-167.dsl.stlsmo.swbell.net ([65.64.152.167]:25473
	"EHLO base.torri.linux") by vger.kernel.org with ESMTP
	id <S265936AbSLNUqx>; Sat, 14 Dec 2002 15:46:53 -0500
Subject: Re: Unresolved symbols in agpart
From: Stephen Torri <storri@sbcglobal.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021214202636.GA4274@suse.de>
References: <1039896536.963.7.camel@base.torri.linux>
	 <20021214202636.GA4274@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-g1iBvAyw9SxJk5AreSye"
Organization: 
Message-Id: <1039899278.17343.7.camel@base.torri.linux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 14 Dec 2002 14:54:39 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g1iBvAyw9SxJk5AreSye
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-12-14 at 14:26, Dave Jones wrote:
> On Sat, Dec 14, 2002 at 02:08:56PM -0600, Stephen Torri wrote:
>  > I would like to help clear up the module problem in the linux kernel
>  > (2.5.51). The problem I am getting is when I do "make install" there i=
s
>  > a report back that some symbols are unresolved. What I need to know is
>  > how these symbols are supposed to be exported? I can grep the files to
>  > find the symbols and correct this problem.
>=20
> Can you try with the patch at
> ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.51/
>=20
> and let me know if that fixes things ?

It does not appear to be doing so. The version of 2.5.51 that I have is
the bitkeeper version that I grab via bk.=20

Here is the output of "make install" for agpart.ko:

Kernel: arch/i386/boot/bzImage is ready
sh arch/i386/boot/install.sh 2.5.51 arch/i386/boot/bzImage System.map ""
depmod: *** Unresolved symbols in /lib/modules/2.5.51/kernel/agpgart.ko
depmod:         __alloc_pages
depmod:         remap_page_range
depmod:         preempt_schedule
depmod:         misc_deregister
depmod:         pci_find_capability
depmod:         unlock_page
depmod:         inter_module_register
depmod:         pci_bus_read_config_dword
depmod:         kmalloc
depmod:         __up_wakeup
depmod:         __get_free_pages
depmod:         vfree
depmod:         global_flush_tlb
depmod:         __page_cache_release
depmod:         no_llseek
depmod:         pm_unregister_all
depmod:         __might_sleep
depmod:         high_memory
depmod:         panic
depmod:         copy_to_user
depmod:         ioremap_nocache
depmod:         iounmap
depmod:         change_page_attr
depmod:         free_pages
depmod:         smp_call_function
depmod:         zone_table
depmod:         pm_register
depmod:         __PAGE_KERNEL
depmod:         kfree
depmod:         pci_devices
depmod:         misc_register
depmod:         vmalloc
depmod:         contig_page_data
depmod:         mem_map
depmod:         copy_from_user
depmod:         wake_up_process
depmod:         printk
depmod:         inter_module_unregister
depmod:         pci_bus_write_config_dword
depmod:         __down_failed

I grepped for "remap_page_range" found
System.map:c0149bf0 T remap_page_range
System.map:c0413a40 R __ksymtab_remap_page_range
Binary file vmlinux matches

I found that in kernel/ksym.c at line 108 is the line that is suppose to
export the symbol:

EXPORT_SYMBOL(remap_page_range);

Stephen

--=20
Stephen Torri <storri@sbcglobal.net>

--=-g1iBvAyw9SxJk5AreSye
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9+5qOsZ6ZpmJVIPURAjo2AJ4rp3h1Jf1Yv3RiDkJVleseMu6fTACgkxT9
jwmh+zc3fQsqPJmng8lZ/1A=
=Hpgd
-----END PGP SIGNATURE-----

--=-g1iBvAyw9SxJk5AreSye--
