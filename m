Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272446AbTHEGZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 02:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272455AbTHEGZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 02:25:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:5049 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272446AbTHEGZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 02:25:25 -0400
Date: Mon, 4 Aug 2003 23:26:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Konold <martin.konold@erfrakon.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interactive Usage of 2.6.0.test1 worse than 2.4.21
Message-Id: <20030804232654.295c9255.akpm@osdl.org>
In-Reply-To: <200308050704.22684.martin.konold@erfrakon.de>
References: <200308050704.22684.martin.konold@erfrakon.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Konold <martin.konold@erfrakon.de> wrote:
>
> Hi,
> 
>  when using  2.6.0.test1 on a high end laptop (P-IV 2.2 GHz, 1GB RAM) I notice 
>  very significant slowdown in interactive usage compared to 2.4.21.
> 
>  The difference is most easily seen when switching folders in kmail. While 
>  2.4.21 is instantaneous 2.6.0.test1 shows the clock for about 2-3 seconds.
> 
>  I am using maildir folders on reiserfs.

There is a bug in old kmail versions wherein they do silly things if the
filesystem alleges that its optimum I/O size is much larger than 4k.

2.6's reiserfs tell applications that its optimum IO size is 128k, and the
bug bites.

Try mounting your reiserfs filesystems with the "nolargeio" option.

A `mount -o remount,nolargeio' will probably work too.

Please test that, send a report, and if it fixes it, upgrade your kmail.

Thanks.
