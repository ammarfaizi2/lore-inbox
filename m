Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292383AbSBBUu5>; Sat, 2 Feb 2002 15:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292386AbSBBUuq>; Sat, 2 Feb 2002 15:50:46 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:710 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S292383AbSBBUub>;
	Sat, 2 Feb 2002 15:50:31 -0500
Date: Sat, 2 Feb 2002 15:50:28 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Stephen Lord <lord@sgi.com>
Cc: Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
        Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@zip.com.au>,
        Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT fails in some kernel and FS
Message-ID: <20020202155028.B26147@havoc.gtf.org>
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es> <3C5AFE2D.95A3C02E@zip.com.au> <1012597538.26363.443.camel@jen.americas.sgi.com> <20020202093554.GA7207@tapu.f00f.org> <234710000.1012674008@tiny> <20020202205438.D3807@athlon.random> <242700000.1012680610@tiny> <3C5C4929.5080403@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C5C4929.5080403@sgi.com>; from lord@sgi.com on Sat, Feb 02, 2002 at 02:16:41PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 02:16:41PM -0600, Stephen Lord wrote:
> Can't you fall back to buffered I/O for the tail? OK it complicates the
> code, probably a lot, but it keeps things sane from the user's point of
> view.

For O_DIRECT, IMHO you should fail not fallback.  You're simply lying
to the underlying program otherwise.

In the ibu fs I am hacking on, the idea for O_DIRECT is to fail a read
if the file is small enough to fit in the inode.  If the O_DIRECT
action is a write, then I will invalidate the data in the inode,
then follow the standard path (which eventually calls get_block()).

For file tails (a different case from small-file-in-inode), I
imagine it would be prudent to support O_DIRECT for all actions
except reading the file tail.  If you want to be complicated, you
could provide userspace with a way to say "this is a dense file"
and/or simply not create a tail at all...

	Jeff



