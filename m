Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbTANQWi>; Tue, 14 Jan 2003 11:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbTANQWd>; Tue, 14 Jan 2003 11:22:33 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:19843 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP
	id <S264699AbTANQWb>; Tue, 14 Jan 2003 11:22:31 -0500
Date: Tue, 14 Jan 2003 16:32:19 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein31.homenet>
To: Christoph Hellwig <hch@lst.de>
cc: Hugh Dickins <hugh@veritas.com>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't create regular files in devfs (fwd)
In-Reply-To: <20030114135033.A15280@lst.de>
Message-ID: <Pine.LNX.4.33.0301141625580.1241-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2003, Christoph Hellwig wrote:
> On Tue, Jan 14, 2003 at 11:48:58AM +0000, Tigran Aivazian wrote:
> > a) if devfs is available it provides a regular file whose size can be
> > examined by applications and content read/written without much "fuss". In
> > particular it is very convenient to say "vi microcode" and examine the
> > content directly. If it was a device node then this would have been
> > impossible.
>
> What do you think about adding a sysvfs attribute for that instead in
> 2.5?  This seems to be the much more logical interface to me..

Ok, that is a reasonable constructive suggestion. The only disadvantage I
see is:

sysfs is mounted under /sys and having two distinct paths (a device node
/dev/cpu/microcode and a regular file somewhere in /sys) does not seem
worthwhile. Not necessarily illogical, just not worth the hassle, imho.

I think one filename is sufficient in this case. The fact that the same
filename may sometimes refer to a device node and other times (if devfs is
present) to a regular file may seem a little odd but it is not harmful and
since it is useful then why remove it or change it?

If you move it all the way to sysfs (i.e. no device node in /dev) then it
seems a bit odd that a device driver entry point is found somewhere other
than the usual /dev.

Regards
Tigran

