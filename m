Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032399AbWLGQuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032399AbWLGQuL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032401AbWLGQuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:50:10 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:38657 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032399AbWLGQuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:50:07 -0500
Date: Thu, 7 Dec 2006 11:47:56 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [Fastboot] [PATCH] free initrds boot option
Message-ID: <20061207164756.GA13873@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <4410.1165450723@neuling.org> <20061206163021.f434f09b.akpm@osdl.org> <4577624A.6010008@zytor.com> <13639.1165462578@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13639.1165462578@neuling.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 02:36:18PM +1100, Michael Neuling wrote:
> > I would have to agree with this; it also seems a bit odd to me to have
> > this at all (kexec provides a new kernel image, surely it also
> > provides a new initrd image???)
> 

Yes, kexec provides the option --initrd, so that a user can supply an
initrd image to be loaded along with kernel.

> The first boot will need to hold a copy of the in memory fs for the
> second boot.  This image can be large (much larger than the kernel),
> hence we can save time when the memory loader is slow.  Also, it reduces
> the memory footprint while extracting the first boot since you don't
> need another copy of the fs.
> 

Is there a kexec-tools patch too? How does second kernel know about
the location of the first kernel's initrd to be reused?

In general kexec can overwrite all the previous kernel's memory. It
just knows about the segments the user has passed to it and it will
place these segments to their destination locations. There are no
gurantees that in this process some data from first kernel will not
be overwritten. So it might not be a very safe scheme.

Thanks
Vivek
