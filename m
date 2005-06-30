Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262870AbVF3KQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbVF3KQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVF3KQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:16:15 -0400
Received: from aun.it.uu.se ([130.238.12.36]:32644 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262870AbVF3KPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:15:48 -0400
Date: Thu, 30 Jun 2005 12:15:22 +0200 (MEST)
Message-Id: <200506301015.j5UAFMOn023481@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: benh@kernel.crashing.org, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: [RFC][PATCH] ppc misusing NTP's time_offset value
Cc: linuxppc-dev@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005 15:05:51 -0700, john stultz wrote:
>	As part of my timeofday rework, I've been looking at the NTP code and I
>noticed that the PPC architecture is apparently misusing the NTP's
>time_offset (it is a terrible name!) value as some form of timezone
>offset. This could cause problems when time_offset changed by the NTP
>code.
>	
>	This patch changes the PPC code so it uses a more clear local variable:
>timezone_offset.
>
>Could a PPC maintainer verify this is correct?
>
>Let me know if you have any comments or feedback.

arch/ppc/kernel/time.c used to have a 'static long time_offset;'
variable. Ulthough unrelated, this declaration clashed with the
one for kernel/time.c, causing compile-time errors with gcc4.
I submitted a fix for this in February, which renamed ppc's local
variable, and it was ACKed by Tom Rini and queued for 2.6.12.

However, the patch that actually went into 2.6.12 was different:
it just removed ppc's local variable, making arch/ppc/kernel/time.c
now share kernel/time.c's variable. At the time I assumed someone
had proved that the two modules _should_ share state, so I didn't
make a fuss about it.

Your patch brings the semantics back to what it was prior to 2.6.12.

/Mikael
