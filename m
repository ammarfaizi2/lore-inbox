Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265576AbUAZKhJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 05:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265573AbUAZKhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 05:37:09 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:25740 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S265576AbUAZKg7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 05:36:59 -0500
Date: Mon, 26 Jan 2004 11:36:54 +0100
From: Tim Cambrant <tim@cambrant.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.2-rc2
Message-ID: <20040126103654.GA32762@cambrant.com>
References: <Pine.LNX.4.58.0401251844440.32583@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401251844440.32583@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2004 at 06:48:24PM -0800, Linus Torvalds wrote:
> Summary of changes from v2.6.2-rc1 to v2.6.2-rc2

Hello Linus,

2.6.2-rc2 doesn't compile cleanly with the latest GCC 3.4 with my
configuration, because of several extern inline declarations in
include-files. The same problem existed in 2.6.2-rc1-mm2 and earlier,
and was fixed in -mm3. The fix is to simply remove 'inline' from the
funcion declaration. Andrew Morton has confirmed this and has applied
patches like this into his tree. Here are patches to fix the errors:


--- linux-2.6.2-rc2/include/linux/efi.h.orig    Mon Jan 26 11:09:08 2004
+++ linux-2.6.2-rc2/include/linux/efi.h Mon Jan 26 11:09:18 2004
@@ -297,8 +297,8 @@ extern u64 efi_mem_attributes (unsigned=20
 extern void efi_initialize_iomem_resources(struct resource *code_resource,
                                        struct resource *data_resource);
 extern efi_status_t phys_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
-extern inline unsigned long __init efi_get_time(void);
-extern inline int __init efi_set_rtc_mmss(unsigned long nowtime);
+extern unsigned long __init efi_get_time(void);
+extern int __init efi_set_rtc_mmss(unsigned long nowtime);
 extern struct efi_memory_map memmap;
=20
 /*


-------


--- linux-2.6.2-rc2/include/linux/sched.h.orig  Mon Jan 26 11:17:39 2004
+++ linux-2.6.2-rc2/include/linux/sched.h       Mon Jan 26 11:18:35 2004
@@ -670,7 +670,7 @@ static inline int capable(int cap)
 extern struct mm_struct * mm_alloc(void);
=20
 /* mmdrop drops the mm and the page tables */
-extern inline void FASTCALL(__mmdrop(struct mm_struct *));
+extern void FASTCALL(__mmdrop(struct mm_struct *));
 static inline void mmdrop(struct mm_struct * mm)
 {
        if (atomic_dec_and_test(&mm->mm_count))


-------


--- linux-2.6.2-rc2/include/linux/bio.h.orig    Mon Jan 26 11:22:45 2004
+++ linux-2.6.2-rc2/include/linux/bio.h Mon Jan 26 11:23:05 2004
@@ -231,8 +231,8 @@ extern void bio_put(struct bio *);
=20
 extern void bio_endio(struct bio *, unsigned int, int);
 struct request_queue;
-extern inline int bio_phys_segments(struct request_queue *, struct bio *);
-extern inline int bio_hw_segments(struct request_queue *, struct bio *);
+extern int bio_phys_segments(struct request_queue *, struct bio *);
+extern int bio_hw_segments(struct request_queue *, struct bio *);
=20
 extern inline void __bio_clone(struct bio *, struct bio *);
 extern struct bio *bio_clone(struct bio *, int);


-------


--- linux-2.6.2-rc2/include/linux/elevator.h.orig       Mon Jan 26 11:25:09=
 2004
+++ linux-2.6.2-rc2/include/linux/elevator.h    Mon Jan 26 11:25:30 2004
@@ -96,9 +96,9 @@ extern elevator_t iosched_as;
=20
 extern int elevator_init(request_queue_t *, elevator_t *);
 extern void elevator_exit(request_queue_t *);
-extern inline int elv_rq_merge_ok(struct request *, struct bio *);
-extern inline int elv_try_merge(struct request *, struct bio *);
-extern inline int elv_try_last_merge(request_queue_t *, struct bio *);
+extern int elv_rq_merge_ok(struct request *, struct bio *);
+extern int elv_try_merge(struct request *, struct bio *);
+extern int elv_try_last_merge(request_queue_t *, struct bio *);
=20
 /*
  * Return values from elevator merger


-------


--- linux-2.6.2-rc2/include/linux/ide.h.orig    Mon Jan 26 11:27:37 2004
+++ linux-2.6.2-rc2/include/linux/ide.h Mon Jan 26 11:28:36 2004
@@ -1417,12 +1417,12 @@ typedef struct pkt_task_s {
        void                    *special;
 } pkt_task_t;
=20
-extern inline u32 ide_read_24(ide_drive_t *);
+extern u32 ide_read_24(ide_drive_t *);
=20
-extern inline void SELECT_DRIVE(ide_drive_t *);
-extern inline void SELECT_INTERRUPT(ide_drive_t *);
-extern inline void SELECT_MASK(ide_drive_t *, int);
-extern inline void QUIRK_LIST(ide_drive_t *);
+extern void SELECT_DRIVE(ide_drive_t *);
+extern void SELECT_INTERRUPT(ide_drive_t *);
+extern void SELECT_MASK(ide_drive_t *, int);
+extern void QUIRK_LIST(ide_drive_t *);
=20
 extern void ata_input_data(ide_drive_t *, void *, u32);
 extern void ata_output_data(ide_drive_t *, void *, u32);


-------

I understand if you won't apply these int your tree. Perhaps the same
fixes are on their way into the vanilla kernel from Andrew's tree. If
that's the case, you can feel free to ignore these patches.


                Tim Cambrant

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAFO3G+p4C2FlRhwIRAnCVAKC6I4VW5t44xgwzX7SZWZbO4ygtcgCfWuvf
CwnuApgo3whRrZnJYY+VUGA=
=EKsQ
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
