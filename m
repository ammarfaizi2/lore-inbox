Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283006AbRK1CtZ>; Tue, 27 Nov 2001 21:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283008AbRK1CtQ>; Tue, 27 Nov 2001 21:49:16 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:32009 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S283006AbRK1CtG>; Tue, 27 Nov 2001 21:49:06 -0500
Message-ID: <3C045072.36455C6F@zip.com.au>
Date: Tue, 27 Nov 2001 18:48:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <20011128013129Z281843-17408+21534@vger.kernel.org> <3C044855.3CF2DCA3@zip.com.au>,
		<3C044855.3CF2DCA3@zip.com.au> <20011127183429.B862@mikef-linux.matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> >       echo file_readahead:N > /proc/ide/ide0/hda/settings
> >
> > where N is in kilobytes in 2.4.16 kernels.
> 
> Any idea which drivers it will/won't work on?  ie, "almost all ide" or
> "almost none of the ide driers"?

It appears that all IDE is controlled with /proc/ide/ide0/hda/settings

> >In earlier kernels
> > it's kilopages (!).
> 
> Isn't this part of the max-readahead patch?

No, that fix went in separately.  Roger Larsson created it, then
I hit the same problem and forwarded Roger's patch to the relevant
parties.
 
> Does /proc/sys/vm/max_readahead affect scsi in any way?

Well, `grep -r max_readahead drivers/scsi' comes up blank,
so it looks like the scsi drivers don't implement the
driver-specific readhead tunable, and so they will fall back
to the /proc/sys/vm/max_readahead global.  I guess.

> What layer does /proc/sys/vm/max_readahead affect?  Block? FS?

The generic filesystem library code.  The bit which sits
on top of the block layer and gets its block mappings from the
filesystem and does generic_file_readahead().  Variously
referred to as VFS or VM.  It's neither, and both, really.
