Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbTC0V3O>; Thu, 27 Mar 2003 16:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbTC0V3O>; Thu, 27 Mar 2003 16:29:14 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:9491 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261381AbTC0V3N>; Thu, 27 Mar 2003 16:29:13 -0500
Date: Thu, 27 Mar 2003 22:40:20 +0100
From: Alexander Kellett <lypanov@kde.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: watching for file creation completion [was Re: Synchronous signal delivery..]
Message-ID: <20030327214020.GA1731@tubby.mitza.net>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com> <20030213204518.GC14764@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030213204518.GC14764@stingr.net>
User-Agent: Mutt/1.4.1i
Disclaimer: My opinions do not necessarily represent those of my employer
Copyright: Copyright 2003 Alexander Kellett - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hiya all,

On Thu, Feb 13, 2003 at 11:45:18PM +0300, Paul P Komkoff Jr wrote:
> These functions have one nice purpose: we can watch a directory hierarchy
> for changes an efficient way. e.g. AFAIK via dnotify I can only see that
> directory was changed, but cannot actually get all the changes. If I will
> re-read all directory, I can miss some changes (if other process is
> tampering with this dir too).

fully agreed. queued events / batch notifications would also be kind of nice.

the fact that it is not possible to see if a file write has been 
completely written out currently (i.e, written to and then closed) 
is quite frustrating. anyone got any ideas for this?

currently i'm doing the ugly - readdir on dnotify signal, then
check mtime's to see if > 5 seconds, and just assume the writing
process has finished, then force a readdir in case any events
were missed while dnotify notification was off.

mvg,
Alex
