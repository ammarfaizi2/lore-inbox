Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTEOGAC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 02:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbTEOGAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 02:00:02 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:40917 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263859AbTEOGAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 02:00:01 -0400
Date: Wed, 14 May 2003 23:14:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
Message-Id: <20030514231414.42398dda.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0305141935440.9816-100000@cherise>
References: <20030514193300.58645206.akpm@digeo.com>
	<Pine.LNX.4.44.0305141935440.9816-100000@cherise>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 06:12:46.0172 (UTC) FILETIME=[00CCC1C0:01C31AA9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@osdl.org> wrote:
>
> > Eric, maybe we need to turn it off by hand at the right time rather than
>  > relying on driver model shutdown ordering?
> 
>  Interesting. This is yet more proof that system-level devices cannot be
>  treated as common, everyday devices. Sure, it's nice to see them show up
>  in sysfs with little overhead, and very nice not to have to work about
>  them during shutdown or power transitions. But there are just too many
>  special cases (like getting the ordering right ;) that you have to worry
>  about.
> 
>  So, what do we do with them? 

I'd say that as long as the shutdown routines are executed in reverse
order of startup, then the core driver stuff has fulfilled its
obligations.

In this case we need to understand why the lockup is happening - what
code is requiring 8259 services after the thing has been turned off?
Could be that the bug lies there.

Felipe, please send your .config.   (again - in fact you may as well do
cp .config ~/.signature)



