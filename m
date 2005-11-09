Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVKIQzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVKIQzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVKIQzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:55:47 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:52704 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932087AbVKIQzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:55:46 -0500
Date: Wed, 9 Nov 2005 17:55:39 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS information leak during crash
Message-ID: <20051109165539.GC2572@fi.muni.cz>
References: <20051102212722.GC6759@fi.muni.cz> <20051103101107.O6239737@wobbly.melbourne.sgi.com> <20051102233629.GD6759@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102233629.GD6759@fi.muni.cz>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
: Nathan Scott wrote:
: : 
: : This issue affects every filesystem, right?  Or are you claiming its
: : only XFS affected here?  Have you run your parallel-buffered-writers
: : test case on any other filesystems?  I'd be interested in the results,
: : in particular, with all of the data=xxx modes of other filesystems.
: : 
: 	I will do this tomorrow or the day after and post the results.
:
	Sorry for the delay - I did the test on other filesystems
as well: "random" (i.e. not rewritten) data after the hard reset were
inside the files in the following filesystems:

XFS
ext3 data=writeback
JFS

and my test program did not manage to put those "random" blocks into the
files when running on ext3 with data=ordered mode (as expected).

	I have tried ReiserFS as well, with mixed results:

- when I hit "reset" soon enough (but well after the HDD LED starts
	blinking), I end up with an empty directory after the reboot.
	It seems ReiserFS caches the filesystem operations much longer
	than other filesystems.
- I have not seen truly random data in the files on ReiserFS after the
	hard reset, but I have seen blocks of zeros instead of either
	old or new data. This may be a pure coincidence, so ReiserFS
	may belong to the same group as ext3 with data=writeback mode,
	but I was not able to make the files contain truly random
	blocks by hitting the reset button.

	So, does ReiserFS do some kind of data journaling/ordering as well?

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> Specs are a basis for _talking_about_ things. But they are _not_ a basis <
> for implementing software.                              --Linus Torvalds <
