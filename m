Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbUCaAbo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 19:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbUCaAbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 19:31:44 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58828 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262952AbUCaAbm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 19:31:42 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Clay Haapala <chaapala@cisco.com>
Subject: Re: [PATCH] lib/libcrc32c
Date: Tue, 30 Mar 2004 21:49:59 +0200
User-Agent: KMail/1.5.3
Cc: James Morris <jmorris@redhat.com>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>, <Matt_Domsch@dell.com>
References: <Xine.LNX.4.44.0403261134210.4331-100000@thoron.boston.redhat.com> <200403302043.22938.bzolnier@elka.pw.edu.pl> <yqujwu52ywsy.fsf@chaapala-lnx2.cisco.com>
In-Reply-To: <yqujwu52ywsy.fsf@chaapala-lnx2.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403302149.59364.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 of March 2004 21:11, Clay Haapala wrote:
> On Tue, 30 Mar 2004, Bartlomiej Zolnierkiewicz outgrape:
> > +
> > +static u32 crc32c_table[256] = {
> >
> > Tables are build time generated in case of CRC32
> > (lib/gen_crc32table.c) so you can trade some performance for smaller
> > size of the table.
> >
> > [ However I don't know how useful is this. ]
>
> As the table was statically in code in sctp and in the iSCSI driver
> where it originally came from, I left it that way.  Why would the
> table be of a different size?

See lib/crc32defs.h and lib/gen_crc32table.c.

lib/crc32defs.h:

/* How many bits at a time to use.  Requires a table of 4<<CRC_xx_BITS bytes. */
/* For less performance-sensitive, use 4 */
#ifndef CRC_LE_BITS 
# define CRC_LE_BITS 8
#endif
#ifndef CRC_BE_BITS
# define CRC_BE_BITS 8
#endif

lib/gen_crc32table.c:

#define LE_TABLE_SIZE (1 << CRC_LE_BITS)
#define BE_TABLE_SIZE (1 << CRC_BE_BITS)

static u_int32_t crc32table_le[LE_TABLE_SIZE];
static u_int32_t crc32table_be[BE_TABLE_SIZE];


Regards,
Bartlomiej

