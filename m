Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262445AbRFDWwk>; Mon, 4 Jun 2001 18:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbRFDWwa>; Mon, 4 Jun 2001 18:52:30 -0400
Received: from cuda.sx.nec.com ([207.253.213.164]:52487 "HELO cuda.sx.nec.com")
	by vger.kernel.org with SMTP id <S262445AbRFDWwZ>;
	Mon, 4 Jun 2001 18:52:25 -0400
Message-ID: <3B1C0EE9.9F8F58A4@ludusdesign.com>
Date: Mon, 04 Jun 2001 18:42:49 -0400
From: Pierre Phaneuf <pp@ludusdesign.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: disk-based fds in select/poll
In-Reply-To: <E157277-000603-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > I am thinking that a read() (or sendfile()) that would block because the
> > pages aren't in core should instead post a request for the pages to be
> > loaded (some kind of readahead mecanism?) and return immediately (maybe
> > having given some data that *was* in core). A subsequent read() could
> 
> reads posts a readahead anyway so streaming reads tend not to block much

Ok, so while knowing about select "lying" about readability of a file
fd, if I would stick a file fd in my select-based loop anyway, but would
only try to read a bit at a time (say, 4K or 8K) would trigger
readahead, yet finish quickly enough that I can get back to processing
other fds in my select loop?

Wouldn't that cause too many syscalls to be done? Or if this is actually
the way to go without an actual thread, how should I go determining an
optimal block size?

Was there anything new on the bind_event/get_events API idea that Linus
proposed a while ago? That one had got me foaming at the mouth... :-)

-- 
Pierre Phaneuf
