Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265472AbRF2OLM>; Fri, 29 Jun 2001 10:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266087AbRF2OLC>; Fri, 29 Jun 2001 10:11:02 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:25834 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265472AbRF2OKx>; Fri, 29 Jun 2001 10:10:53 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 29 Jun 2001 07:10:51 -0700
Message-Id: <200106291410.HAA10170@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	The Config.in files in linux-2.4.6-pre6 have at least 28 cases
where a dep_bool or dep_tristate of the following form:

	dep_bool CONFIG_SOMETHING $CONFIG_ARCH_somearch

	The problem with this is that, unlike most configuration variables,
the $CONFIG_ARCH_xxxx variables are often not set to "n" when they are
not selected (they are often just not defined, for example, when they
are archectures for a completely different CPU type).  When those variables
are not defined, that is essentially equivalent to passing "y" to dep_bool,
and the user is incorrectly asked about these facilities.

	I will put together patch to convert this to ugly but correct
"if then; ... ; fi" statements later today if nobody has any better
suggestions.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
