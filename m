Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLATZ4>; Fri, 1 Dec 2000 14:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130109AbQLATZq>; Fri, 1 Dec 2000 14:25:46 -0500
Received: from zeus.kernel.org ([209.10.41.242]:42502 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129431AbQLATZg>;
	Fri, 1 Dec 2000 14:25:36 -0500
Date: Fri, 1 Dec 2000 18:47:46 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Eric Lowe <elowe@myrile.madriver.k12.oh.us>
Cc: andrea@suse.de, sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Updated: raw I/O patches (v2.2)
Message-ID: <20001201184746.R4978@redhat.com>
In-Reply-To: <Pine.BSF.4.10.10011211115140.79234-100000@myrile.madriver.k12.oh.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.BSF.4.10.10011211115140.79234-100000@myrile.madriver.k12.oh.us>; from elowe@myrile.madriver.k12.oh.us on Tue, Nov 21, 2000 at 11:18:15AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 21, 2000 at 11:18:15AM -0500, Eric Lowe wrote:
> 
> I have updated raw I/O patches with Andrea's and my fixes against 2.2.
> They check for CONFIG_BIGMEM so they can be applied and compiled
> without the bigmem patch.

I've just posted an assembly of all of the outstanding raw IO bugfixes
I know of, to 

	ftp.uk.linux.org:/pub/linux/sct/fs/raw-io
and	ftp.*.kernel.org:/pub/linux/kernel/people/sct/raw-io

in kiobuf-2.2.18pre24.tar.gz.  README is appended below.

Eric, this contains at least one bug fix that was missing from your
patch set --- we need a flush_dcache_page() after obtaining the
mapping on some CPUs (spotted by davem).

I've kept the bigmem and non-bigmem versions separate.  Your
CONFIG_BIGMEM code did some rather weird (though not strictly buggy)
things in the case of a non-bigmem-enabled kernel.

Linus and co are doing a set of cleanups for 2.4 dirty page handling,
and I'll redo all of the fixes here for 2.4 once that is in place.
The really important bugfix is the fault-handling one, and we can't do
that reliably without the VM changes in place.

Cheers,
 Stephen

00README:
This directory contains the following files:

raw-2.2.18pre24.00.new-rawio		: Old (2.2.17, buggy) raw IO patches

raw-2.2.18pre24.01.fix-ENXIO		: Fix return value at end of device
raw-2.2.18pre24.02.fix-exports		: Export kiobuf symbols to modules
raw-2.2.18pre24.03.fix-freebuf		: Fix freeing of bh'es on error
raw-2.2.18pre24.04.fix-mapcopy		: Fix expanding of kiobuf lists
raw-2.2.18pre24.05.fix-faultin		: Fix faulting/pinning of user pages
raw-2.2.18pre24.06.fix-freebuf		: Wakup tasks when we free bh'es
raw-2.2.18pre24.07.fix-dcache		: Flush cpu dcache
raw-2.2.18pre24.08.fix-retry		: Fix error recovery on fault failure

raw-2.2.18pre24.99.new-bigmem		: Support for bigmem configurations

You can either apply all of these patches in order (the bigmem one is
optional), or --- preferably --- just apply the ONE of the combined
patches:

raw-2.2.18pre24.FULL.diff		: raw IO for non-bigmem kernels
raw-2.2.18pre24.FULL:BIGMEM.diff	: raw IO for bigmem kernels

--Stephen Tweedie <sct@redhat.com>, 1 Dec 2000

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
