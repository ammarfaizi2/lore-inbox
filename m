Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161247AbWASPyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161247AbWASPyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWASPyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:54:05 -0500
Received: from rtr.ca ([64.26.128.89]:20894 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161247AbWASPyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:54:04 -0500
Message-ID: <43CFB60B.2090703@rtr.ca>
Date: Thu, 19 Jan 2006 10:53:47 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Cynbe ru Taren <cynbe@muq.org>, linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <E1EywcM-0004Oz-IE@laurel.muq.org>	<43CE1E52.3030907@aitel.hist.no>	<43CE6997.6090005@rtr.ca> <17358.53535.449726.814333@cse.unsw.edu.au>
In-Reply-To: <17358.53535.449726.814333@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
>
> Very recent 2.6 kernels do exactly this.  They don't drop a drive on a
> read error, only on a write error.  On a read error they generate the
> data from elsewhere and schedule a write, then a re-read.

Well done, then.  Further to this:

Pardon me for not looking at the specifics of the code here,
but experience shows that rewriting just the single sector
is often not enough to repair an error.  The drive often just
continues to fail when only the bad sector is rewritten by itself.

Dumb drives, or what, I don't know, but they seem to respond
better when the entire physical track is rewritten.

Since we rarely know what a physical track is these days,
this often boils down to simply rewriting a 64KB chunk
centered on the failed sector.  So far, this strategy has
always worked for me.

Cheers
