Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTI1WHI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 18:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTI1WHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 18:07:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:20411 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262758AbTI1WHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 18:07:07 -0400
Date: Sun, 28 Sep 2003 15:07:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: "P. Christeas" <p_christ@hol.gr>
Cc: linux-kernel@vger.kernel.org, "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: [aic7xxx]: Scheduling while atomic on rmmod - 2.6.0-test5,6
Message-Id: <20030928150740.148122eb.akpm@osdl.org>
In-Reply-To: <200309290015.26280.p_christ@hol.gr>
References: <200309290015.26280.p_christ@hol.gr>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"P. Christeas" <p_christ@hol.gr> wrote:
>
> I (always) get the same 'scheduling while atomic' error whenever I try to 
>  rmmod the aic7xxx module or try to suspend.

That's because ahc_linux_exit() takes ahc_list_spinlock then calls
ahc_linux_kill_dv_thread(), which downs a semaphore.

