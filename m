Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTKNAEZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 19:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264464AbTKNAEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 19:04:25 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:36367 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S264463AbTKNAEU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 19:04:20 -0500
Date: Thu, 13 Nov 2003 16:04:16 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031114000416.GC29500@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1068512710.722.161.camel@cube> <20031111133859.GA11115@bitwizard.nl> <20031111085323.M8854@devserv.devel.redhat.com> <bp0p5m$lke$1@cesium.transmeta.com> <20031113233915.GO1649@x30.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031113233915.GO1649@x30.random>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may contain content offensive to the humour impaired.  Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 12:39:15AM +0100, Andrea Arcangeli wrote:
> On Thu, Nov 13, 2003 at 12:22:14PM -0800, H. Peter Anvin wrote:
> > Followup to:  <20031111085323.M8854@devserv.devel.redhat.com>
> > By author:    Jakub Jelinek <jakub@redhat.com>
> > In newsgroup: linux.dev.kernel
> > > > 
> > > > Actually, I think we should have a: 
> > > > 
> > > > 	long copy_fd_to_fd (int src, int dst, int len)
> > > > 
> > > > type of systemcall. 
> > > 
> > > We have one, sendfile(2).
> > > 
> > 
> > It would be very nice if we could (a) expand the uses of sendfile(2),
> > and (b) have the libc do the fallback to read/write/mmap as needed.
> 
> I actually hacked cp for a while and it improved cp some point percent
> on normal machines.
> 
> See ftp://ftp.suse.com/pub/people/andrea/cp-sendfile/
> 
> the main downside and the reason it wasn't applied IIRC is the lack of
> interruption of sendfile, basically for an huge file it would take a
> while before C^c has any effect. The kernel isn't interrupting the
> syscall.  This is no different from a huge read or write syscall (but
> read/write are never huge or the buffer would need to be huge too, not
> the case for sendfile that works zerocopy), so in theory we could
> workaround it by entering/exiting kernel multiple times just to allow
> the signal to be handled like in the read/write case.

Until interrupt and restart (as has been discussed
here for other syscalls) handling is improved there could be
a sanity check with an E2BIG or something if the size is
insane.  I dislike the thought of sendfile going sitting in D
state on a multi-gigabyte file.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
