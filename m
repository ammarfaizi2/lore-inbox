Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWGWWPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWGWWPV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 18:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWGWWPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 18:15:21 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:60357 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751348AbWGWWPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 18:15:20 -0400
Message-ID: <44C3E6EE.8080607@namesys.com>
Date: Sun, 23 Jul 2006 15:15:26 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C26F65.4000103@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com> <44C3E041.1020909@suse.com>
In-Reply-To: <44C3E041.1020909@suse.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney wrote:

>
>
> That particular bug isn't in the bitmap scanning code, it's a side
> effect of the write batching higher up.

Did you write the code that looks for a window of 32
blocks?  If not, and if this code has been around for a long time, I
apologize.   I thought you did write it and added it in recent months.

>
>
> It's a pathological case when the file system is seriously fragmented.

Most bugs are pathological cases.;-)

> A
> quick fix would be to set a flag indicating that future writes shouldn't
> bother trying to find a window that large,

There are lots of quick fixes.  1) The quickest is to not scan for the
window at all.  2) The second quickest is to limit the number of bitmaps
that will be scanned to some number like 3.  3) The not at all quickest
is to track free extents like XFS does, which is not a hack, but it
belongs in a development branch.  I am not sure it is worth the
complexity, but my mind is not closed.

On monday we will do 1) or 2), probably 1).   After the repacker is
done, we should review all our block allocation algorithms.  I have an
idea for how to do things more optimally for streaming media that will
avoid fragmentation over time, and when combined with the repacker may
make 3 not worthwhile.

I am grateful that you and Chris do bug fixes, but when you guys are too
busy, (and that can and will happen to any of us), the baton needs to
get passed.  V3 needs to be a zero defect product, and once we know it
is a bug I don't want bugs in V3 to remain unfixed for more than a day
plus the time it takes to fix it.    If you do add code, I want any bugs
that show up in the aftermath of mainstream merging to get jumped on.

Hans
