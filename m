Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289013AbSBDPN5>; Mon, 4 Feb 2002 10:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289017AbSBDPNr>; Mon, 4 Feb 2002 10:13:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47367 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289013AbSBDPNk>;
	Mon, 4 Feb 2002 10:13:40 -0500
Message-ID: <3C5EA521.B7D2F8C2@mandrakesoft.com>
Date: Mon, 04 Feb 2002 10:13:37 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT fails in some kernel and FS
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es.suse.lists.linux.kernel> <3C5AFE2D.95A3C02E@zip.com.au.suse.lists.linux.kernel> <1012597538.26363.443.camel@jen.americas.sgi.com.suse.lists.linux.kernel> <20020202093554.GA7207@tapu.f00f.org.suse.lists.linux.kernel> <234710000.1012674008@tiny.suse.lists.linux.kernel> <20020202205438.D3807@athlon.random.suse.lists.linux.kernel> <242700000.1012680610@tiny.suse.lists.linux.kernel> <3C5C4929.5080403@sgi.com.suse.lists.linux.kernel> <20020202155028.B26147@havoc.gtf.org.suse.lists.linux.kernel> <p737kpvauvv.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Jeff Garzik <garzik@havoc.gtf.org> writes:
> 
> > On Sat, Feb 02, 2002 at 02:16:41PM -0600, Stephen Lord wrote:
> > > Can't you fall back to buffered I/O for the tail? OK it complicates the
> > > code, probably a lot, but it keeps things sane from the user's point of
> > > view.
> >
> > For O_DIRECT, IMHO you should fail not fallback.  You're simply lying
> > to the underlying program otherwise.
> 
> It's just impossible to write a tail which is smaller than a disk block
> without another buffer.

I argue, for reiserfs:

For O_DIRECT writes, the preferred behavior is to write disk blocks
obtained through the normal methods (get_block, etc.), and fully support
inodes for which file tails do not exist.

For O_DIRECT reads, if the data is determined to be in a file tail,
->direct_IO should either (a) fail or (b) dump the file tail to a normal
disk block before performing ->direct_IO.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
