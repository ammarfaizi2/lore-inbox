Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTHFNvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 09:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTHFNvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 09:51:12 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7305 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262254AbTHFNvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 09:51:09 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 6 Aug 2003 15:51:06 +0200 (MEST)
Message-Id: <UTC200308061351.h76Dp6413498.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, jgarzik@pobox.com
Subject: Re: Add identify decoding 4/4
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Andries.Brouwer@cwi.nl wrote:
	> Here a somewhat uneven commented ide_identify.h.
	> This is part of a larger patch, but suffices for now.

	Do you really want to stick that long function in a header?

	Stick it in ide-lib.c, that's a better place for it, IMO...

No. <linux/ide-identify.h> contains a lot of 1-line static inline
functions, just readable names for current magic bit checks,
and one big function ide_dump_identify_info() that is included as

#ifdef IDE_IDENTIFY_DEBUG
static void
ide_dump_identify_info(const struct hd_driveid *id, const char *name)
{
...
}
#endif

Thus, ide-floppy.c and ide-tape.c and isd200.c can do

#if IDEFLOPPY_DEBUG_INFO
#define IDE_IDENTIFY_DEBUG
#include <linux/ide-identify.h>
#endif

and get this big function, but only when their local debugging option
is set. We would not want to see it in the binary if there were no users.

Andries
