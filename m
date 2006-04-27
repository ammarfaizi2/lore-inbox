Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWD0JfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWD0JfL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 05:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWD0JfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 05:35:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56116 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965043AbWD0JfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 05:35:07 -0400
Date: Thu, 27 Apr 2006 11:35:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-ID: <20060427093540.GB23137@suse.de>
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org> <Pine.LNX.4.64.0604261144290.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604261144290.3701@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 26 2006, Linus Torvalds wrote:
> It would be interesting to see where doing gang-lookup moves the target, 
> but on the other hand, with smaller files (and small files are still 
> common), gang lookup isn't going to help as much.

Here is the graph for:

- 2.6.17-rc3 + splice reada fix (vanilla-no-gang)

vs

- 2.6.17-rc3 + splice reada fix + gang lookup (vanilla)

vs

- 2.6.17-rc3 + splice reada fix + lockless page cache (lockless-no-gang)

Average of 3 runs graphed, the lockless run didn't use the batch lookup
as that is a lot slower since it basically defeats the purpose of the
lockless page cache until Nick patches it up :-)

Conclusion: the gang lookup makes things faster for the vanilla kernel,
but it only makes it scale marginally (if at all) better.

-- 
Jens Axboe


--mP3DRpeJDSE+ciuQ
Content-Type: image/png
Content-Disposition: attachment; filename="lockless-4.png"
Content-Transfer-Encoding: base64

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
AAAAAElFTkSuQmCC

--mP3DRpeJDSE+ciuQ--
