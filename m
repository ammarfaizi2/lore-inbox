Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWGMNeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWGMNeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWGMNeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:34:25 -0400
Received: from mx1.suse.de ([195.135.220.2]:43393 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751473AbWGMNeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:34:25 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: utrace vs. ptrace
Date: Thu, 13 Jul 2006 15:34:16 +0200
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>, Albert Cahalan <acahalan@gmail.com>,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com> <200607131521.52505.ak@suse.de> <1152797295.3024.50.camel@laptopd505.fenrus.org>
In-Reply-To: <1152797295.3024.50.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607131534.16819.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 July 2006 15:28, Arjan van de Ven wrote:
> 
> > That said extended core dumping (e.g. automatic processing of the output) 
> > in user space makes sense. I had a prototype for that once that uploaded
> > a simple crash report to a web 
> 
> the script I use for that is at
> http://www.fenrus.org/bt.sh
> 
> it tries to include things like rpm versions of the package it was in
> etc, and suggests/downloads the right debuginfo rpms to improve the
> backtrace. Clearly that's all userspace stuff; but it can run from a
> daemon easily; eg have all core dumps go to a special directory where
> the daemon reaps them and analyzes.

You can't do that right now because core_pattern doesn't support slashes.
The coredumps will be always all over the fs or not be there at all
if the cwd is write protected.

In my patch I allowed pipes and piped the coredump into a user space
processor that generated a simple report using gdb and sent it off.

The web frontend then did some statistics on what crashed most.

-Andi
