Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316134AbSETRBG>; Mon, 20 May 2002 13:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316136AbSETRBF>; Mon, 20 May 2002 13:01:05 -0400
Received: from holomorphy.com ([66.224.33.161]:43143 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316134AbSETRBF>;
	Mon, 20 May 2002 13:01:05 -0400
Date: Mon, 20 May 2002 10:00:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Todd R. Eigenschink" <todd@tekinteractive.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: kswapd OOPS under 2.4.19-pre8 (ext3, Reiserfs + (soft)raid0)
Message-ID: <20020520170059.GA2046@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Todd R. Eigenschink" <todd@tekinteractive.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205160528.g4G5S631019167@sol.mixi.net> <15587.42492.25950.446607@rtfm.ofc.tekinteractive.com> <15592.62193.715212.569689@rtfm.ofc.tekinteractive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 07:58:25AM -0500, Todd R. Eigenschink wrote:
> Since the particular snippet of code at the point of oops in the last
> one I posted was P3-specified, I recompiled for 586.  The oops remains
> the same, although the call stack happens to be a lot longer this
> time.

I suspect the lowest parts of the call chain are being handed bad data.


On Mon, May 20, 2002 at 07:58:25AM -0500, Todd R. Eigenschink wrote:
> I'm going to run memtest86 on it for a while after it gets done with
> its morning processing, although this failure seems a little too
> consistent to be memory related.

I hope I didn't say that.


On Mon, May 20, 2002 at 07:58:25AM -0500, Todd R. Eigenschink wrote:
> Trace; c0129b39 <unlock_page+81/88>
> Trace; c0139179 <end_buffer_io_async+8d/a8>
> Trace; c01b6f45 <end_that_request_first+65/c8>
> Trace; c01c1c3c <ide_end_request+68/a8>
> Trace; c01c806a <ide_dma_intr+6a/ac>
> Trace; c01c38ad <ide_intr+f9/164>
> Trace; c01c8000 <ide_dma_intr+0/ac>
> Trace; c010a1e1 <handle_IRQ_event+59/84>
> Trace; c010a3d9 <do_IRQ+a9/f4>
> Trace; c010c568 <call_do_IRQ+5/d>
> Trace; c0154b07 <statm_pgd_range+133/1a8>
> Trace; c0154c43 <proc_pid_statm+c7/16c>
> Trace; c015279e <proc_info_read+5a/118>
> Trace; c0137497 <sys_read+8f/104>
> Trace; c0108a43 <system_call+33/40>

The __wake_up()/unlock_page() isn't the interesting part of the call
chain, the parts from end_buffer_io_async() to ide_dma_intr() are.

Any chance you can list them in gdb?


Cheers,
Bill
