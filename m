Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWIDHG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWIDHG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWIDHG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:06:58 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:45658 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932398AbWIDHG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:06:57 -0400
Message-ID: <44FBD08A.1080600@tls.msk.ru>
Date: Mon, 04 Sep 2006 11:06:50 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Raid 0 Swap?
References: <44FB5AAD.7020307@perkel.com>
In-Reply-To: <44FB5AAD.7020307@perkel.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel wrote:
> If I have two drives and I want swap to be fast if I allocate swap spam
> on both drives does it break up the load between them? Or would it run
> faster if I did a Raid 0 swap?

Don't do that - swap on raid0.  Don't do that.  Unless you don't care
about your data, ofcourse.  Seriously.

If something with swap space goes wrong, God only knows what will break.
It is trivial to break userspace data this way, when an app is swapped
out and there's an error reading it from swap, its data file very likely
to be corrupt, especially when it is interrupted during file update.
It is probably possible to corrupt the whole filesystem this way too,
when some kernel memory has been swapped out and is needed to write some
parts of filesystem, but it can't be read back.

Ie, your swap space must be reliable.  At least not worse than your memory.
And with striping, you've much more chances of disk failure...

Yes it sounds very promising at first, to let kernel stripe swap space,
for faster operations.  But hell, first, try to avoid swappnig in the
first place, by installing appropriate amount memory which is cheap
nowadays, so there will be just no need for swapping.  And when it's
done, it's not relevant anymore whenever your swap space is fast or
not.  But make it *reliable*.

/mjt

-- 
VGER BF report: U 0.49924
