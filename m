Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263819AbUC3Sfs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUC3Sfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:35:48 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:44426 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263819AbUC3Sfe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:35:34 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Clay Haapala <chaapala@cisco.com>, James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] lib/libcrc32c
Date: Tue, 30 Mar 2004 20:43:22 +0200
User-Agent: KMail/1.5.3
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
       <Matt_Domsch@dell.com>
References: <Xine.LNX.4.44.0403261134210.4331-100000@thoron.boston.redhat.com> <yqujr7vai6k4.fsf@chaapala-lnx2.cisco.com>
In-Reply-To: <yqujr7vai6k4.fsf@chaapala-lnx2.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403302043.22938.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Tuesday 30 of March 2004 19:32, Clay Haapala wrote:
> On Fri, 26 Mar 2004, James Morris outgrape:
> > These need to be rediffed against the latest Linus kernel.
> >
> > It may be better to wait until 2.6.5 comes out, so we don't have too
> > much new stuff going into the -rc kernels.
> >
> >
> > - James
>
> Rediffed they are!  I see that the digest setkey() api is already part
> of -rc3, so because this code is a simple "add" and I will be
> on vacation next week when 2.6.5 might be cut, I am providing the
> patch now.
>
> This patch agains 2.6.5-rc3 kernel code implements the CRC32C
> algorithm.  The routines are based on the same design as the
> existing CRC32 code.  Licensing is intended to be identical (GPL).

+/*
+ * This is the CRC-32C table
+ * Generated with:
+ * width = 32 bits
+ * poly = 0x1EDC6F41
+ * reflect input bytes = true
+ * reflect output bytes = true
+ */
+
+static u32 crc32c_table[256] = {

Tables are build time generated in case of CRC32 (lib/gen_crc32table.c)
so you can trade some performance for smaller size of the table.

[ However I don't know how useful is this. ]

+/*EXPORT_SYMBOL(crc32c_be);*/
+
+#if CRC_BE_BITS == 1
+u32 attribute((pure))
+crc32_be(u32 crc, unsigned char const *p, size_t len)
+{
+       int i;
+       while (len--) {
+               crc ^= *p++ << 24;
+               for (i = 0; i < 8; i++)
+                       crc =
+                           (crc << 1) ^ ((crc & 0x80000000) ? CRC32C_POLY_BE :
+                                         0);
+       }
+       return crc;
+}
+#endif

Is there any reason in adding crc32_be() until it is finished
(LE version) and/or needed?

Regards,
Bartlomiej

