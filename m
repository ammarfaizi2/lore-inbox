Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265598AbTFNBc7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 21:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265599AbTFNBc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 21:32:59 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:20754 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S265598AbTFNBc6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 21:32:58 -0400
Date: Fri, 13 Jun 2003 20:46:46 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: Microstar MS-6163 blacklist
Message-ID: <20030614014646.GD1010@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In other news, I noticed recently that the IO-APIC on my MS-6163
BX-Master was being disabled at boot by the kernel, due to a recently
introduced blacklist:

{ apm_kills_local_apic, "Microstar 6163",
	{ MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
	  MATCH(DMI_BOARD_NAME, "MS-6163"),
	  NO_MATCH, NO_MATCH } },

Consulting mailing list archives indicated that there is some sort of
problem with the IO-APIC on the MS-6163 Pro and APM events.  However,
this seems a rather clumsy fix to the problem, since it disabled the
IO-APIC on _all_ MS-6163 boards rather than just the Pro, and also
regardless of whether APM support is even enabled (I don't enable it and
don't use it at all).

The DMI string for my board is:
Board Information Block
	Vendor: MICRO-STAR INTERNATIONAL CO., LTD
	Product: MS-6163 (i440BX)
	Version: 3.X
	Serial Number:

It would seem that if a closer match were performed, using the version
number of the board (3.X in my case, likely 2.X in the case of the
broken Pro), it would be a better idea.  Perhaps another alternative
solution would be to only disable the IO-APIC if CONFIG_APM is defined.
(?)

Thoughts?
	  
-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253
