Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264462AbTKMXjw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 18:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264464AbTKMXjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 18:39:52 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19355
	"EHLO x30.random") by vger.kernel.org with ESMTP id S264462AbTKMXjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 18:39:46 -0500
Date: Fri, 14 Nov 2003 00:39:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031113233915.GO1649@x30.random>
References: <1068512710.722.161.camel@cube> <20031111133859.GA11115@bitwizard.nl> <20031111085323.M8854@devserv.devel.redhat.com> <bp0p5m$lke$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bp0p5m$lke$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 12:22:14PM -0800, H. Peter Anvin wrote:
> Followup to:  <20031111085323.M8854@devserv.devel.redhat.com>
> By author:    Jakub Jelinek <jakub@redhat.com>
> In newsgroup: linux.dev.kernel
> > > 
> > > Actually, I think we should have a: 
> > > 
> > > 	long copy_fd_to_fd (int src, int dst, int len)
> > > 
> > > type of systemcall. 
> > 
> > We have one, sendfile(2).
> > 
> 
> It would be very nice if we could (a) expand the uses of sendfile(2),
> and (b) have the libc do the fallback to read/write/mmap as needed.

I actually hacked cp for a while and it improved cp some point percent
on normal machines.

See ftp://ftp.suse.com/pub/people/andrea/cp-sendfile/

the main downside and the reason it wasn't applied IIRC is the lack of
interruption of sendfile, basically for an huge file it would take a
while before C^c has any effect. The kernel isn't interrupting the
syscall.  This is no different from a huge read or write syscall (but
read/write are never huge or the buffer would need to be huge too, not
the case for sendfile that works zerocopy), so in theory we could
workaround it by entering/exiting kernel multiple times just to allow
the signal to be handled like in the read/write case.
