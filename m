Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262650AbTCTWNj>; Thu, 20 Mar 2003 17:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbTCTWNi>; Thu, 20 Mar 2003 17:13:38 -0500
Received: from hera.cwi.nl ([192.16.191.8]:8855 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262284AbTCTWNh>;
	Thu, 20 Mar 2003 17:13:37 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 20 Mar 2003 23:24:33 +0100 (MET)
Message-Id: <UTC200303202224.h2KMOXC01107.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, zippel@linux-m68k.org
Subject: Re: major/minor split
Cc: Joel.Becker@oracle.com, akpm@digeo.com, andrey@eccentric.mae.cornell.edu,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a point I'd like to get clear: where should the
> 16bit<->32bit dev_t conversion happen?

I am not sure I understand the question, but if I do
the answer is "nowhere", there is no conversion
(other than the lengthening that happens when one
casts an unsigned short to an unsigned int).

For dev_t (8,1) is 0x00000801, but (8,256) is 0x00080100.
(In case of a 16+16 split. Not that I advocate that,
it is just easy talking.)

For kdev_t (8,1) is 0x00080001 and (8,256) is 0x00080100.
So kdev_t allows simple fast composition and decomposition,
but is restricted to the kernel.
While dev_t requires a conditional, since it has to remain
compatible with the old 8+8 userspace.

> how can software create nodes for a specific device?

You do not mean using mknod?

Andries
