Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbUD2B4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUD2B4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUD2B4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:56:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:37266 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262897AbUD2ByU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:54:20 -0400
Date: Wed, 28 Apr 2004 18:53:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040428185342.0f61ed48.akpm@osdl.org>
In-Reply-To: <16528.23219.17557.608276@cargo.ozlabs.ibm.com>
References: <409021D3.4060305@fastclick.com>
	<20040428170106.122fd94e.akpm@osdl.org>
	<409047E6.5000505@pobox.com>
	<40905127.3000001@fastclick.com>
	<20040428180038.73a38683.akpm@osdl.org>
	<16528.23219.17557.608276@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> Andrew Morton writes:
> 
> > My point is that decreasing the tendency of the kernel to swap stuff out is
> > wrong.  You really don't want hundreds of megabytes of BloatyApp's
> > untouched memory floating about in the machine.  Get it out on the disk,
> > use the memory for something useful.
> 
> What I have noticed with 2.6.6-rc1 on my dual G5 is that if I rsync a
> gigabyte or so of data over to another machine, it then takes several
> seconds to change focus from one window to another.  I can see it
> slowly redraw the window title bars.  It looks like the window manager
> is getting swapped/paged out.
> 
> This machine has 2.5GB of ram, so I really don't see why it would need
> to swap at all.  There should be plenty of page cache pages that are
> clean and not in use by any process that could be discarded.  It seems
> like as soon as there is any memory shortage at all it picks on the
> window manager and chucks out all its pages. :(
> 

I suspect rsync is taking two passes across the source files for its
checksumming thing.  If so, this will defeat the pagecache use-once logic. 
The kernel sees the second touch of the pages and assumes that there will
be a third touch.

I use scp ;)
