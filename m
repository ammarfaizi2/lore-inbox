Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVDZTwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVDZTwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 15:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVDZTwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 15:52:31 -0400
Received: from ns1.suse.de ([195.135.220.2]:20916 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261758AbVDZTw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 15:52:27 -0400
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 15:52:23 -0400
User-Agent: KMail/1.8
Cc: Mike Taht <mike.taht@timesys.com>, Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504260939440.18901@ppc970.osdl.org> <200504261339.34680.mason@suse.com>
In-Reply-To: <200504261339.34680.mason@suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504261552.24100.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 April 2005 13:39, Chris Mason wrote:

> As an example, here's the time to apply 300 patches on ext3.  This was with
> my packed patches applied, but vanilla git should show similar percentage
> differences.
>
> data=writeback  32s
> data=ordered    44s
>
> With a long enough test, data=ordered should fall into the noise, but 10-40
> second runs really show it.

I get much closer numbers if the patches directory is already in 
cache...data=ordered means more contention for the disk when trying to read 
the patches.  

If the patches are hot in the cache data=writeback and data=ordered both take 
about 30s.  You still see some writes in data=writeback, but these are mostly 
async log commits.  

The same holds true for vanilla git as well, although it needs 1m7s to apply 
from a hot cache (sorry, couldn't resist the plug ;)

-chris
