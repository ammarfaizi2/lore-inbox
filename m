Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269374AbUIYSVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269374AbUIYSVH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 14:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269375AbUIYSVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 14:21:07 -0400
Received: from dp.samba.org ([66.70.73.150]:5269 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269374AbUIYSVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 14:21:03 -0400
Date: Sat, 25 Sep 2004 11:20:21 -0700
From: Jeremy Allison <jra@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeremy Allison <jra@samba.org>,
       YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
Message-ID: <20040925182021.GR580@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org> <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1> <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1> <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org> <Pine.LNX.4.58.0409251108570.2317@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409251108570.2317@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 11:12:04AM -0700, Linus Torvalds wrote:
> 
> Btw, if you want to send bytes instead of blocks, I don't care. The Linux 
> client can easily do
> 
> 	blocks = bytes >> 9;
> 
> and I'll be perfectly happy.

Good - that's all that needs doing.

> But if the "bytes" count you send has no
> actual real-life meaning (ie it didn't actually come from the underlying
> filesystem at all), then don't bother. The client might as well do
> 
> 	blocks = (filesize + 511) >> 9;
> 
> if that's what the server is (badly) mangling.

No, the number does have real life meaning if the underlying
OS supports st_blocks and st_blksize. We test for the presense
of these in configure (as they're not POSIX) and send the
correct values as bytes if they are there. We (smbd) takes care
of scaling them into bytes instead of the client having to
know if it's talking to HPUX in which case it's in 8192
byte units, or to VOS etc. etc.

To recap, if we have st_blocks from the filesystem we use it
and send the value scaled as bytes, if not we send the actual
file size there in bytes (as we know any POSIX system has at
least that).

Happy ?

Jeremy.
