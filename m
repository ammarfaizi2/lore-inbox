Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278526AbRJSP6p>; Fri, 19 Oct 2001 11:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278528AbRJSP6f>; Fri, 19 Oct 2001 11:58:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35599 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278527AbRJSP60>; Fri, 19 Oct 2001 11:58:26 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Poor floppy performance in kernel 2.4.10
Date: Fri, 19 Oct 2001 15:57:40 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9qpihk$23p$1@penguin.transmeta.com>
In-Reply-To: <20011018194415.S12055@athlon.random> <XFMail.20011019095006.pochini@shiny.it>
X-Trace: palladium.transmeta.com 1003507109 4721 127.0.0.1 (19 Oct 2001 15:58:29 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 19 Oct 2001 15:58:29 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <XFMail.20011019095006.pochini@shiny.it>,
Giuliano Pochini  <pochini@shiny.it> wrote:
>
>> Indeed, only 2.2 trusted the check media change information and left the
>> cache valid on top of the floppy across close/open of the blkdev.
>
>Which is not a bad thing IMHO, but it can cause problems with
>some broken SCSI implementation where the drive doesn't send
>UNIT_ATTENTION after a media change (like my MO drive when I
>misconfigured the jumpers, damn :-((( ).

Well, the original reason to not trust the media-change signal is that
some floppy drives simply do not implement the signal at all. Don't ask
me why. So a loong time ago Linux had the problem that when you changed
floppies you wouldn't see the new information - or you'd see _partially_
new and old information depending on what your access patterns were and
what the caches contained.

So it's pretty much across the board - broken SCSI, broken floppies,
just about any changeable media tends to have _some_ bad cases. And with
the floppy case, there was no way to notice at run-time whether the unit
was broken or not - the floppy drives have no ID's to blacklist etc. So
either you tell people to flush their caches by hand (which we did), or
you just always flush it between separate opens (which we later did).

			Linus
