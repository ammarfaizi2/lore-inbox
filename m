Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272435AbTGZHwO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 03:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272436AbTGZHwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 03:52:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:7916 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272435AbTGZHwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 03:52:13 -0400
Date: Sat, 26 Jul 2003 01:08:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Romit Dasgupta <romit@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context at
 include/linux/rwsem.h:43
Message-Id: <20030726010826.488bd7ea.akpm@osdl.org>
In-Reply-To: <3F1ECCD6.5060007@myrealbox.com>
References: <3F1ECCD6.5060007@myrealbox.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Romit Dasgupta <romit@myrealbox.com> wrote:
>
>             Just found some debug messages like the subject above, from 
>  the latest kernel compiled with debug options. Attached are the dmesg 
>  output and the .config file. Not sure if anyone has seen this.

Probably some initcall has more spin_lock()s than spin_unlock()s and the
init process's preempt count ended up permanently out of whack.

Please boot with "initcall_debug=1" on the boot command line and if you see
a line of the form:

error in initcall at 0xXXXXXXXX: returned with preemption imbalance

then please look up 0xXXXXXXXX in System.map and let us know.

