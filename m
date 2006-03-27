Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWC0Jiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWC0Jiw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 04:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWC0Jiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 04:38:52 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:29578 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750807AbWC0Jiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 04:38:51 -0500
Message-ID: <4427B292.3080204@bull.net>
Date: Mon, 27 Mar 2006 11:38:26 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: unlock_buffer() and clear_bit()
References: <44247FAB.3040202@free.fr>	<20060325040233.1f95b30d.akpm@osdl.org>	<4427A817.4060905@bull.net> <20060327010739.027d410d.akpm@osdl.org>
In-Reply-To: <20060327010739.027d410d.akpm@osdl.org>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 27/03/2006 11:40:43,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 27/03/2006 11:40:49,
	Serialize complete at 27/03/2006 11:40:49
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> This is, I think, a rather inefficient thing we're doing there.  For most
> architectures, that amounts to:
> 
> 	mb();
> 	clear_bit()
> 	mb();
> 
> which is probably more than is needed.  We'd need to get some other
> architecture people involved to see if there's a way of improving this, and
> unlock_page().

This is why I proposed also:

>>> Or a new bit clearing service needs to be added that includes
>>>   the "rel" semantics, say "release_N_clear_bit()"

The architecture dependent "release_N_clear_bit()" should include what
is necessary for the correct unlocking semantics (and it leaves the freedom
for the "stand alone" bit operations implementations).

Note that "lock_buffer()" works on ia64 "by chance", because all the
atomic bit operations are implemented "by chance" by use of the "acq"
semantics.

I'd like to split the bit operations according to their purposes:
- e.g. "test_and_set_bit_N_acquire()" for lock acquisition
- "test_and_set_bit()", "clear_bit()" as they are today
- "release_N_clear_bit()"...

Thaks,

Zoltan
