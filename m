Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSJNLGY>; Mon, 14 Oct 2002 07:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSJNLGJ>; Mon, 14 Oct 2002 07:06:09 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:20100 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S264624AbSJNLFN>; Mon, 14 Oct 2002 07:05:13 -0400
From: Erich Focht <efocht@ess.nec.de>
Subject: [PATCH] node affine NUMA scheduler 4/5
Date: Mon, 14 Oct 2002 13:09:50 +0200
User-Agent: KMail/1.4.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_EOXY8INGVPIE72IA5P7U"
Message-Id: <200210141309.50652.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_EOXY8INGVPIE72IA5P7U
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

----------  Resent Message  ----------

Subject: [PATCH] node affine NUMA scheduler 4/5
Date: Fri, 11 Oct 2002 20:01:39 +0200

Ooops, this went out empty. It's so simple, anyway. Sorry...

On Friday 11 October 2002 19:59, Erich Focht wrote:
> And here comes the fourth part...
>
> > 04-alloc_on_homenode.patch :
> >        Coupling with the memory allocator: for user tasks allocate me=
mory
> >        from the homenode, no matter on which node the task is schedul=
ed.

Erich

--------------Boundary-00=_EOXY8INGVPIE72IA5P7U
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="04-alloc_on_homenode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="04-alloc_on_homenode.patch"

diff -urNp 2.5.39-disc-na/include/linux/gfp.h 2.5.39-disc-nac/include/linux/gfp.h
--- 2.5.39-disc-na/include/linux/gfp.h	Fri Sep 27 23:49:16 2002
+++ 2.5.39-disc-nac/include/linux/gfp.h	Tue Oct  8 16:16:04 2002
@@ -51,9 +51,13 @@ extern struct page * alloc_pages_node(in
  */
 static inline struct page * alloc_pages(unsigned int gfp_mask, unsigned int order)
 {
-	pg_data_t *pgdat = NODE_DATA(numa_node_id());
+	pg_data_t *pgdat;
 	unsigned int idx = (gfp_mask & GFP_ZONEMASK);
 
+	if (current->active_mm == &init_mm)
+		pgdat = NODE_DATA(numa_node_id());
+	else
+		pgdat = NODE_DATA(current->node);
 	if (unlikely(order >= MAX_ORDER))
 		return NULL;
 

--------------Boundary-00=_EOXY8INGVPIE72IA5P7U--

