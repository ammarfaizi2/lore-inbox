Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVGLLGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVGLLGo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVGLLGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:06:43 -0400
Received: from [203.171.93.254] ([203.171.93.254]:25476 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261176AbVGLLFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:05:53 -0400
Subject: Re: [PATCH] [5/48] Suspend2 2.1.9.8 for 2.6.12:
	350-workthreads.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050712105754.GA23947@elf.ucw.cz>
References: <11206164393426@foobar.com> <112061643920@foobar.com>
	 <20050710230441.GC513@infradead.org> <1121150400.13869.22.camel@localhost>
	 <20050712105754.GA23947@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121166456.13869.165.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 21:07:37 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-07-12 at 20:57, Pavel Machek wrote:
> Hi!
> 
> > > Again, why do you think you need this?
> > 
> > 1. If something should be wrong with the freezer, it forms part of a
> > safety net that stops your data on disk being trashed.
> 
> > 2. Separating out threads doing syncing from threads submitting I/O
> > makes the refrigerator much more reliable, even under extreme load.
> 
> This seems to be red herring. Sometimes sync took way too long (like
> hours) with older kernels and reiserfs, but I believe that has been
> fixed. If not, we need to fix it, anyway; no need to work around it in
> suspend2.

Are you considering races such as the case where one process is
submitting I/O (say dd) while another is trying to sync? Even if sync
does return sooner (presumably because it only syncs writes submitted
before the sync), there will still be dirty data after the sync
completes. And if we start another sync thread, it will suffer the same
problem. The only solution is to stop I/O being submitted, then sync.
But having stopped I/O being submitted, we need to still have the
threads the process the I/O (possibly userspace ones) unfrozen. Hence we
need to differentiate 'syncthreads'.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

