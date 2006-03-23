Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422700AbWCWVMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422700AbWCWVMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWCWVMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:12:44 -0500
Received: from smtp04.auna.com ([62.81.186.14]:52666 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S964943AbWCWVMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:12:43 -0500
Date: Thu, 23 Mar 2006 22:12:41 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use const* parameters in mm.h
Message-ID: <20060323221241.719662a8@werewolf.auna.net>
In-Reply-To: <20060323220711.28fcb82f@werewolf.auna.net>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<20060323220711.28fcb82f@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 2.0.0cvs160 (GTK+ 2.8.16; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_1l9uFAenjLXePbchBOw/Oe3";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Thu, 23 Mar 2006 22:12:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_1l9uFAenjLXePbchBOw/Oe3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Mar 2006 22:07:11 +0100, "J.A. Magallon" <jamagallon@able.es> wr=
ote:

> On Thu, 23 Mar 2006 01:40:46 -0800, Andrew Morton <akpm@osdl.org> wrote:
>=20
> >=20
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.=
6.16-mm1/
> >=20
>=20

As they are inline, this gives the compiler wide space for optmizations.

--- linux-2.6.15-rc5-mm2.orig/include/linux/mm.h	2005-12-12 09:10:34.000000=
000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/mm.h	2005-12-14 14:39:50.000000000 -=
0800
@@ -464,7 +464,7 @@ void put_page(struct page *page);
 #define SECTIONS_MASK		((1UL << SECTIONS_WIDTH) - 1)
 #define ZONETABLE_MASK		((1UL << ZONETABLE_SHIFT) - 1)
=20
-static inline unsigned long page_zonenum(struct page *page)
+static inline unsigned long page_zonenum(const struct page *page)
 {
 	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
 }
@@ -472,20 +472,20 @@ static inline unsigned long page_zonenum
 struct zone;
 extern struct zone *zone_table[];
=20
-static inline struct zone *page_zone(struct page *page)
+static inline struct zone *page_zone(const struct page *page)
 {
 	return zone_table[(page->flags >> ZONETABLE_PGSHIFT) &
 			ZONETABLE_MASK];
 }
=20
-static inline unsigned long page_to_nid(struct page *page)
+static inline unsigned long page_to_nid(const struct page *page)
 {
 	if (FLAGS_HAS_NODE)
 		return (page->flags >> NODES_PGSHIFT) & NODES_MASK;
 	else
 		return page_zone(page)->zone_pgdat->node_id;
 }
-static inline unsigned long page_to_section(struct page *page)
+static inline unsigned long page_to_section(const struct page *page)
 {
 	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
 }
@@ -519,7 +519,7 @@ static inline void set_page_links(struct
 extern struct page *mem_map;
 #endif
=20
-static __always_inline void *lowmem_page_address(struct page *page)
+static __always_inline void *lowmem_page_address(const struct page *page)
 {
 	return __va(page_to_pfn(page) << PAGE_SHIFT);
 }
@@ -561,7 +561,7 @@ void page_address_init(void);
 #define PAGE_MAPPING_ANON	1
=20
 extern struct address_space swapper_space;
-static inline struct address_space *page_mapping(struct page *page)
+static inline struct address_space *page_mapping(const struct page *page)
 {
 	struct address_space *mapping =3D page->mapping;
=20
@@ -572,7 +572,7 @@ static inline struct address_space *page
 	return mapping;
 }
=20
-static inline int PageAnon(struct page *page)
+static inline int PageAnon(const struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_ANON) !=3D 0;
 }
@@ -581,7 +581,7 @@ static inline int PageAnon(struct page *
  * Return the pagecache index of the passed page.  Regular pagecache pages
  * use ->index whereas swapcache pages use ->private
  */
-static inline pgoff_t page_index(struct page *page)
+static inline pgoff_t page_index(const struct page *page)
 {
 	if (unlikely(PageSwapCache(page)))
 		return page_private(page);
@@ -598,7 +598,7 @@ static inline void reset_page_mapcount(s
 	atomic_set(&(page)->_mapcount, -1);
 }
=20
-static inline int page_mapcount(struct page *page)
+static inline int page_mapcount(const struct page *page)
 {
 	return atomic_read(&(page)->_mapcount) + 1;
 }
@@ -606,7 +606,7 @@ static inline int page_mapcount(struct p
 /*
  * Return true if this page is mapped into pagetables.
  */
-static inline int page_mapped(struct page *page)
+static inline int page_mapped(const struct page *page)
 {
 	return atomic_read(&(page)->_mapcount) >=3D 0;
 }


--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam20 (gcc 4.0.3 (4.0.3-1mdk for Mandriva Linux release 2006.1=
))

--Sig_1l9uFAenjLXePbchBOw/Oe3
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEIw9JRlIHNEGnKMMRAvI+AJ9QA1tnnXh7GYlBS+vz2z7R16ce3QCePw2B
2D8/YVHq25J/A0bUFyvmags=
=nxU7
-----END PGP SIGNATURE-----

--Sig_1l9uFAenjLXePbchBOw/Oe3--
