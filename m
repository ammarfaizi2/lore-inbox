Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUD1T4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUD1T4b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUD1Tyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:54:31 -0400
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:41667 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S265043AbUD1Sdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 14:33:38 -0400
Subject: Re: [BUG] DVD writing in 2.6.6-rc2
From: Kenneth Johansson <ken@kenjo.org>
To: Jens Axboe <axboe@suse.de>
Cc: Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>,
       linux-kernel@vger.kernel.org, cw@f00f.org
In-Reply-To: <20040428113056.GA2150@suse.de>
References: <1083088772.2679.11.camel@tiger> <20040427183607.GA3011@suse.de>
	 <8n23m1-g22.ln1@legolas.mmuehlenhoff.de>  <20040428113056.GA2150@suse.de>
Content-Type: text/plain
Message-Id: <1083176956.2679.19.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Apr 2004 20:29:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 13:30, Jens Axboe wrote:
> On Wed, Apr 28 2004, Moritz Muehlenhoff wrote:
> > Jens Axboe wrote:
> > >> I have a problem when using growisofs version 5.19.
> > >> 
> > >> The problem is that in the very end when gowisofs tries to flush the
> > >> cache. When stracing the process I can see it sits in a call to poll
> > >> that never returns. 
> > >
> > > I noted the same thing yesterday with cdrdao, so yours is not an
> > > isolated incident. I'll debug it tomorrow.
> > 
> > I can confirm this bug for kernel 2.6.3-rc4 as well, so it's not too recent.
> > I found the following on my console after quitting k3b ungracefully, maybe
> 
> This is really strange, I haven't been able to locate a kernel problem.
> Looking at command traces, cdrdao issues two FLUSH_CACHE commands when
> ending the writes. The last commands are:
> 
> 0x2a (last real write)
> 0x35 (first flush cache) (takes about 10 seconds to complete)
> 0x00 (test unit ready)
> 0x51 (read disc info, length 4)
> 0x35 (2nd flush cache) -> never completes
> 
> That last sync cache never generates an interrupt, so cdrdao gets stuck
> forever waiting on it. I cannot even reproduce this with a test case

My problem was in growisofs itself. They use poll to wait instead of
using nanosleep and totally confusing me. It did not help that strace do
not print out the arguments until the syscall return so I never saw the
input to poll. 



