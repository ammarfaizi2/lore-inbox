Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVBZRyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVBZRyf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 12:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVBZRyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 12:54:35 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:27524 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261244AbVBZRyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 12:54:32 -0500
Date: Sat, 26 Feb 2005 17:53:29 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jay Roplekar <jay_roplekar@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bad page state at prep_new_page
In-Reply-To: <200502261048.33591.jay_roplekar@hotmail.com>
Message-ID: <Pine.LNX.4.61.0502261733420.20997@goblin.wat.veritas.com>
References: <200502261048.33591.jay_roplekar@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Feb 2005, Jay Roplekar wrote:
> I have been getting this error off and on  with vendor kernel 2.6.8, I have 
> posted about it on lkml 3/4 times before. Actually I had offered to provide a 
> summary of similar reports from the web with no takers, I can still provide 
> that to somebody if it is useful.

If I had had time to spare, I'd have taken you up on the offer.
Some of those will be ones I've spent hours thinking about without
success, some just gone away, some found guilty by memtest86, some
I probably have overlooked.

>  I had run memtest overnight with no errors, I use DRM etc..  The reason to 
> post this  is  that very first line in the syslog  entries related to this 
> error seems to be different  than before.  {It is typically is kernel BUG at 
> mm/rmap.c or sth similar}.  Thanks, 
> 
> Jay
> 
> P.S. I am getting this error once in 3 days on an average (based on grep of 
> moths worth syslog)  so I might have dubious distinction of being more 
> repeatable.  May be it confirms Hugh's suspicion of hardware misbehaving but 
> I am not ready to accept it yet :-)
> 
> ####
> Feb 26 09:37:03 localhost kernel: mm/memory.c:110: bad pmd 00000500.

Wow.  Just two days ago, in unrelated mail, I asked
"Has anyone _ever_ seen a p??_ERROR message?" and you now show us one!
Thank you - but you do seem to have quite bad memory corruption.

> Feb 26 09:39:58 localhost kernel: Bad page state at prep_new_page (in process 
> 'X', page c12678e0)
> Feb 26 09:39:58 localhost kernel: flags:0x20000004 mapping:0000f700 mapcount:0 
> count:0

Again you have a page mapping which should be NULL here anyway,
and doesn't even look like a pointer which is what goes in there
at other times.

I understand that you have a sentimental attachment to your setup.
And the corruption you're seeing could as well be from software as
hardware - but I don't think anyone else is seeing it on this scale,
which does point to your particular hardware.

But I don't want to close down this thread: if someone else can
suggest something useful to try, please go ahead.

Hugh
