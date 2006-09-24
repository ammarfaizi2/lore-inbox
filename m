Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751857AbWIXJSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWIXJSH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 05:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbWIXJSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 05:18:07 -0400
Received: from excu-mxob-2.symantec.com ([198.6.49.23]:33471 "EHLO
	excu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S1751857AbWIXJSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 05:18:05 -0400
Date: Sun, 24 Sep 2006 10:17:38 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Stas Sergeev <stsp@aknet.ru>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
In-Reply-To: <45162BE5.2020100@aknet.ru>
Message-ID: <Pine.LNX.4.64.0609241009020.17400@blonde.wat.veritas.com>
References: <45150CD7.4010708@aknet.ru>  <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
  <451555CB.5010006@aknet.ru>  <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>
 <1159037913.24572.62.camel@localhost.localdomain> <45162BE5.2020100@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Sep 2006 09:17:29.0637 (UTC) FILETIME=[42544D50:01C6DFBA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006, Stas Sergeev wrote:
> Alan Cox wrote:
> > Agreed mprotect should also be fixed.
> Since "noexec" was already rendered useless - yes.
> Before, people could use it and hope the binaries
> won't get executed (and if it was possible to execute
> them by invoking ld.so directly, then ld.so could have
> been fixed). Now the only possibility is to not use the
> "noexec" at all.
> So does that add to security or substract?..

I'm very puzzled.  The intention of "noexec" is to prevent execution
of files on that mount.  You're saying it's useless because it's
preventing execution of files on that mount?  It seems to me that
you simply have a mount where "noexec" presents more problems than
it solves: so don't use it there.  That doesn't mean it's useless:
not every mmap involves PROT_EXEC, not every mount demands execution.

Hugh
