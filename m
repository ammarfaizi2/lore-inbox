Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWECGfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWECGfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 02:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWECGfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 02:35:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14307 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965100AbWECGfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 02:35:38 -0400
Date: Wed, 3 May 2006 16:35:18 +1000
From: Nathan Scott <nathans@sgi.com>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT, ext3fs, kernel 2.4.32... again
Message-ID: <20060503163518.A1929541@wobbly.melbourne.sgi.com>
References: <20060427063249.GH761@DervishD> <20060501062058.GA16589@dmt> <20060501112303.GA1951@DervishD> <20060502072808.A1873249@wobbly.melbourne.sgi.com> <20060502172411.GA6112@DervishD> <20060503060336.A1918058@wobbly.melbourne.sgi.com> <20060503052752.GA20657@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060503052752.GA20657@DervishD>; from lkml@dervishd.net on Wed, May 03, 2006 at 07:27:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 07:27:52AM +0200, DervishD wrote:
> ...
>  Are the differences too large?

Yep.

>     I know that this change would be intrusive and probably large,
> but IMHO is a quite important bug, because it prevents apps to
> selectively disable O_DIRECT (the flag is accepted by open(), so
> there's no reason the app should bother about which caused the
> read()/write() failures. In fact, is very difficult to know that
> those failures are caused by partial/buggy support of O_DIRECT flag).

You could open for direct, do a direct read, and see if it fails.
If it fails, clear O_DIRECT on the fd via fcntl(F_SETFL) then do
regular buffered IO instead... a bit hacky, but should work fine
I think.

cheers.

-- 
Nathan
