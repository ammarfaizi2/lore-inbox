Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUH3G5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUH3G5U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 02:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUH3G5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 02:57:20 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:39366
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S266244AbUH3G5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 02:57:17 -0400
Message-Id: <s132dddc.001@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Mon, 30 Aug 2004 08:57:31 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <pavel@ucw.cz>
Cc: <mochel@digitalimplant.org>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Fw: x86 build issue with software suspend code
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> A piece of code most like "copy-and-paste"d from x86_64 to i386
caused
>> the section named .data.nosave in arch/i386/power/swsusp.S to
become
>> named .data.nosave.1 in arch/i386/power/built-in.o (due to an
attribute
>> collision with an identically named section from
>> arch/i386/power/cpu.c),
>
>I can't find anything about nosave section in cpu.c... Can you quote
it?

Ah, I see. This is the only piece I didn't double-check against the
2.6.8.1 sources (I found the problem originally in the SuSE 2.6.5
derivate, where the kernel.org version didn't have swsusp_pg_dir at all,
yet), and indeed in the kernel.org version swsusp_pg_dir lives in
arch/i386/mm/init.c (one might argue which of the placements is the
better one).

Still, to prevent issues in the future as well as such like seen with
SuSE, the patch seems necessary to me.

Thanks, Jan
