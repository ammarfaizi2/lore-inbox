Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262986AbVAFSVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbVAFSVR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbVAFSU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 13:20:59 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:64128 "EHLO vana")
	by vger.kernel.org with ESMTP id S262951AbVAFSTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 13:19:48 -0500
Date: Thu, 6 Jan 2005 19:19:47 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Andi Kleen <ak@suse.de>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, greg@kroah.com
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106181947.GJ5772@vana.vc.cvut.cz>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org> <20050106163559.GG5772@vana.vc.cvut.cz> <20050106165715.GH1830@wotan.suse.de> <20050106172613.GI5772@vana.vc.cvut.cz> <20050106175342.GA28889@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106175342.GA28889@wotan.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 06:53:42PM +0100, Andi Kleen wrote:
> [cc list trimmed]
> > 
> > * floppy:  it is actually different from examples above, as FDRAWCMD command is
> > supported by 32->64 layer, but it is supported incorrectly.  Due to this all above
> > started, as we had to make application aware of kernel it runs on, as FDRAWCMD on 32bit
> > kernel returns 80 byte structure, while 104 byte on 64bit kernel, and you do not now
> > which one you'll get until you call this ioctl...  And once we had code in place,
> > it was reused for USB and later for ppdev & serial.
> 
> Did you submit a patch for that?  If not you should.

I hoped that floppies will die before...  FDRAWCMD receives array
of floppy_raw_cmd structures, and to find how many of these structures
you have to peek into every of them to find whether there is next one or
not, and structures itself contain pointers to other memory...  I'll code up
something during weekend.
 
> > So we added simple wrapper to vmmon which just gets {64bit-ioctl-number, 64bit-arg-argument}
> > and passes it down to 64bit sys_ioctl:
> 
> The magic 64bit interface isn't a very good interface, don't expect
> that to be supported in the future.

With per-file compat_ioctl ipx ioctls (using SIOCPRIVATE+X range) could
be made to work too, so only thing left for me is USB.
								Petr Vandrovec

