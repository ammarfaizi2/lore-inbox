Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264825AbTGBIbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 04:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbTGBIbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 04:31:44 -0400
Received: from ganon.smb.utfors.se ([195.58.112.27]:41351 "EHLO
	ganon.smb.utfors.se") by vger.kernel.org with ESMTP id S264825AbTGBIbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 04:31:43 -0400
Date: Wed, 02 Jul 2003 10:46:05 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH RFC] 2.5.73 zlib #2 codefold
In-reply-to: <20030701161637.GC25363@wohnheim.fh-wedel.de>
To: =?UNKNOWN?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Reply-to: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLIEODFNAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch folds three calls to memmove_update into one.  This is the
> same structure that was in the 1.1.3 version of the zlib as well.  The
> change towards 1.1.4 was mixed with a real bugfix, so it slipped
> through my brain.
>
> Jörn
[SNIP]

Looks fine to me.

Here is another one in gen_bitlen():
Replace:
  for (bits = 0; bits <= MAX_BITS; bits++) s->bl_count[bits] = 0;
with:
  memset(&s->bl_count[0], 0, MAX_BITS * sizeof(s->bl_count[0]));

Also the following could should be replaced(in defutil.h):
/* ===========================================================================
 * Reverse the first len bits of a code, using straightforward code (a faster
 * method would use a table)
 * IN assertion: 1 <= len <= 15
 */
static inline unsigned bi_reverse(unsigned code, /* the value to invert */
				  int len)       /* its bit length */
{
    register unsigned res = 0;
    do {
        res |= code & 1;
        code >>= 1, res <<= 1;
    } while (--len > 0);
    return res >> 1;
}

Anybody have a table version handy?

 Joakim


