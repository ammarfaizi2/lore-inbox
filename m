Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVBNTTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVBNTTI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 14:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVBNTTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 14:19:07 -0500
Received: from colin2.muc.de ([193.149.48.15]:46341 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261535AbVBNTSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 14:18:46 -0500
Date: 14 Feb 2005 20:18:40 +0100
Date: Mon, 14 Feb 2005 20:18:40 +0100
From: Andi Kleen <ak@muc.de>
To: Robin Holt <holt@sgi.com>
Cc: Ray Bryant <raybry@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
Message-ID: <20050214191840.GA57423@muc.de>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <20050212121228.GA15340@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050212121228.GA15340@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For our use, the batch scheduler will give an intermediary program a
> list of processes and a series of from-to node pairs.  That process would
> then ensure all the processes are stopped, scan their VMAs to determine
> what regions are mapped by more than one process, which are mapped
> by additional processes not in the job, and make this system call for
> each of the unique ranges in the job to migrate their pages from one
> node to the next.  I believe Ray is working on a library and a standalone
> program to do this from a command line.

Sounds quite ugly. 

Do you have evidence that this is a common use case? (jobs having stuff
mapped from programs not in the job). If not I think it's better
to go with a simple interface, not one that is unusable without
a complex user space library.

If you mean glibc etc. only then the best solution for that would be probably
to use the (currently unmerged) arbitary file mempolicy code for this and set
 a suitable attribute that prevents moving.

-Andi
