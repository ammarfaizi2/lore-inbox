Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVDENo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVDENo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 09:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVDENof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 09:44:35 -0400
Received: from orb.pobox.com ([207.8.226.5]:29363 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261758AbVDENoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 09:44:15 -0400
Date: Tue, 5 Apr 2005 06:44:08 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405134408.GB10733@ip68-4-98-123.oc.oc.cox.net>
References: <20050405000524.592fc125.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 12:05:24AM -0700, Andrew Morton wrote:
> - Nobody said anything about the PM resume and DRI behaviour in
>   2.6.12-rc1-mm4.  So it's all perfect now?

No, I just didn't get a chance to send mail yet.

Compared to 2.6.11-ac5, I'm seeing one regression: the part of the
resume where it says something like:

swsusp: reading slkf;jalksfsadflkjas;dlfasdfkl (12345 pages): 34%
[sorry, I just got up so my short-term memory isn't working that well
yet]

takes 10-30 minutes (depending on whether it's closer to 11000 pages or
20000) rather than the 5-10 seconds or so that it takes under 2.6.11-ac5
(or mainline 2.6.11 if I remember correctly).

However, this is not vanilla 2.6.12-rc1-mm4. It has my own modified
version of the Win4Lin patch applied; this is GPL, but the userspace
program that uses this patch (Win4Lin 5.1) isn't, nor is the software
ultimately executed by this patch via Win4Lin (Microsoft Windows
Millennium Edition[*]). And I didn't try swsusp on any kernels between
2.6.11 and 2.6.12-rc1-mm4.

I'll try to do some more testing to see (a) when this problem started
and (b) whether it still exists in 2.6.12-rc2 or later. This is going to
be ridiculously difficult for me to fit into my schedule right now, but
I'll try....

BTW, ieee1394 is still broken after resume (impossible to rmmod, too) and
snd_cmipci (but this can be resurrected by quitting anything that uses
sound, rmmod snd_cmipci, then modprobe snd_cmipci). But these are
long-standing issues, and under 2.6.12-rc1-mm4, ieee1394/sbp2 can at
least stay up indefinitely as long as I don't suspend -- that's a
tremendous improvement over 2.6.11.

-Barry K. Nathan <barryn@pobox.com>
