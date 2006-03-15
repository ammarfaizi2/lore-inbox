Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWCOTiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWCOTiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 14:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWCOTiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 14:38:10 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:10221 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751225AbWCOTiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 14:38:09 -0500
X-Sasl-enc: C5PONSTMwO1zw3MS/zCE3jFbdYcjv6K3FB8IQBQm0Uhn 1142451482
Message-ID: <44186D30.4040603@imap.cc>
Date: Wed, 15 Mar 2006 20:38:24 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: i810 framebuffer - BUG: sleeping function called from invalid context
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig44CAB953807ABD4FB88E8913"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig44CAB953807ABD4FB88E8913
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Thought I'd finally report this, seeing it still around with 2.6.16-rc6-mm1.

With every 2.6.16-rc-mm version I can remember (sorry, no precise records)
my development machine (a Dell OptiPlex GX110, Intel P3/933, Intel chipset)
has been producing the following three BUG messages while booting:

<6>[   36.528181] md: Autodetecting RAID arrays.
<3>[   36.528263] BUG: sleeping function called from invalid context at mm/slab.c:2758
<4>[   36.528270] in_atomic():1, irqs_disabled():1
<4>[   36.528277]  <c01503bb> kmem_cache_alloc+0x20/0x77   <c0259356> i810fb_cursor+0x1bd/0x2c9
<4>[   36.528317]  <c01a36ac> search_by_key+0x1a5/0xe04   <c020eec5> bit_cursor+0x467/0x48a
<4>[   36.528357]  <c020c25b> fbcon_cursor+0x226/0x25b   <c020ea5e> bit_cursor+0x0/0x48a
<4>[   36.528373]  <c024db82> hide_cursor+0x1d/0x53   <c0251766> vt_console_print+0x8b/0x21e
<4>[   36.528399]  <c02516db> vt_console_print+0x0/0x21e   <c0117a14> __call_console_drivers+0x34/0x40
<4>[   36.528422]  <c0117c14> release_console_sem+0xeb/0x185   <c011857a> vprintk+0x298/0x2d9
<4>[   36.528439]  <c0168e00> d_splice_alias+0xa5/0xe5   <c0191583> reiserfs_lookup+0xed/0xf8
<4>[   36.528461]  <c01185cd> printk+0x12/0x16   <c029f1bc> md_ioctl+0xc3/0x1289
<4>[   36.528492]  <c030c268> _spin_unlock+0xf/0x23   <c030c268> _spin_unlock+0xf/0x23
<4>[   36.528525]  <c0169453> inode_init_once+0x1a3/0x1cd   <c01f2113> blkdev_driver_ioctl+0x49/0x59
<4>[   36.528557]  <c01f2824> blkdev_ioctl+0x6b6/0x6d6   <c030b84a> __mutex_lock_slowpath+0x2ca/0x39a
<4>[   36.528576]  <c012ac64> debug_mutex_add_waiter+0x14/0x24   <c015aa46> do_open+0x5b/0x32a
<4>[   36.528607]  <c030b84a> __mutex_lock_slowpath+0x2ca/0x39a   <c015aa46> do_open+0x5b/0x32a
<4>[   36.528622]  <c030c268> _spin_unlock+0xf/0x23   <c030c34a> _read_unlock_irq+0x10/0x24
<4>[   36.528638]  <c0138721> find_get_page+0x35/0x3a   <c0139e2f> filemap_nopage+0x1a1/0x31f
<4>[   36.528655]  <c030c268> _spin_unlock+0xf/0x23   <c01436bf> __handle_mm_fault+0x3e5/0x757
<4>[   36.528688]  <c015a361> block_ioctl+0x13/0x16   <c015a34e> block_ioctl+0x0/0x16
<4>[   36.528701]  <c0163510> do_ioctl+0x1c/0x5d   <c01637a6> vfs_ioctl+0x255/0x268
<4>[   36.528727]  <c01637ff> sys_ioctl+0x46/0x5f   <c0102b3b> sysenter_past_esp+0x54/0x75
<6>[   36.682209] md: autorun ...
<6>[   36.689499] md: ... autorun DONE.
<6>[   40.081658] device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
<3>[   40.081742] BUG: sleeping function called from invalid context at mm/slab.c:2758
<4>[   40.081749] in_atomic():1, irqs_disabled():1
<4>[   40.081756]  <c01503bb> kmem_cache_alloc+0x20/0x77   <c0259356> i810fb_cursor+0x1bd/0x2c9
<4>[   40.081802]  <c020eec5> bit_cursor+0x467/0x48a   <c0101d39> __switch_to+0x19/0x1b4
<4>[   40.081835]  <c020c25b> fbcon_cursor+0x226/0x25b   <c020ea5e> bit_cursor+0x0/0x48a
<4>[   40.081851]  <c024db82> hide_cursor+0x1d/0x53   <c0251766> vt_console_print+0x8b/0x21e
<4>[   40.081882]  <c02516db> vt_console_print+0x0/0x21e   <c0117a14> __call_console_drivers+0x34/0x40
<4>[   40.081906]  <c0117c14> release_console_sem+0xeb/0x185   <c011857a> vprintk+0x298/0x2d9
<4>[   40.081925]  <c0263c50> class_device_add+0x234/0x25b   <c01185cd> printk+0x12/0x16
<4>[   40.081956]  <d885f196> dm_interface_init+0x51/0x58 [dm_mod]   <d885f0d2> dm_init+0x12/0x39 [dm_mod]
<4>[   40.082023]  <c012e1d9> sys_init_module+0x1252/0x139e   <c0102b3b> sysenter_past_esp+0x54/0x75
<6>[   41.934599] NTFS driver 2.1.26 [Flags: R/W MODULE].
<3>[   41.934682] BUG: sleeping function called from invalid context at mm/slab.c:2758
<4>[   41.934689] in_atomic():1, irqs_disabled():1
<4>[   41.934697]  <c01503bb> kmem_cache_alloc+0x20/0x77   <c0259356> i810fb_cursor+0x1bd/0x2c9
<4>[   41.934742]  <c013cf66> __alloc_pages+0x2c0/0x2d2   <c020eec5> bit_cursor+0x467/0x48a
<4>[   41.934783]  <c030c268> _spin_unlock+0xf/0x23   <c020c25b> fbcon_cursor+0x226/0x25b
<4>[   41.934816]  <c020ea5e> bit_cursor+0x0/0x48a   <c024db82> hide_cursor+0x1d/0x53
<4>[   41.934845]  <c0251766> vt_console_print+0x8b/0x21e   <c02516db> vt_console_print+0x0/0x21e
<4>[   41.934860]  <c0117a14> __call_console_drivers+0x34/0x40   <c0117c14> release_console_sem+0xeb/0x185
<4>[   41.934886]  <c011857a> vprintk+0x298/0x2d9   <c013c46d> free_pages_bulk+0x27/0x234
<4>[   41.934904]  <c01185cd> printk+0x12/0x16   <d885f00b> init_ntfs_fs+0xb/0x1a1 [ntfs]
<4>[   41.934941]  <c012e1d9> sys_init_module+0x1252/0x139e   <c0102b3b> sysenter_past_esp+0x54/0x75

At first glance, it looks to me like perhaps i810fb_cursor() shouldn't
kmalloc(~, GFP_KERNEL) at drivers/video/i810/i810_main.c:2216 if it may
be called with in_atomic() && irqs_disabled().

Apart from those messages, the system runs fine.

HTH
Tilman

-- 
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
In theory, there is no difference between theory and practice.
In practice, there is.



--------------enig44CAB953807ABD4FB88E8913
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGG05MdB4Whm86/kRAlY8AJ4vRwB/jR3mx1rcsOHWDF5BAlyBUgCfY301
h3LZA7u/Svpk3DNfyyGjP1A=
=zp83
-----END PGP SIGNATURE-----

--------------enig44CAB953807ABD4FB88E8913--
