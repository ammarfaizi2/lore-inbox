Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263314AbSJHXZh>; Tue, 8 Oct 2002 19:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263238AbSJHXVu>; Tue, 8 Oct 2002 19:21:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59048 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261721AbSJHXT7>;
	Tue, 8 Oct 2002 19:19:59 -0400
Date: Tue, 08 Oct 2002 16:18:38 -0700 (PDT)
Message-Id: <20021008.161838.15299897.davem@redhat.com>
To: bidulock@openss7.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: export of sys_call_table
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021008162017.A11261@openss7.org>
References: <20021004164151.D2962@openss7.org>
	<20021004.153804.94857396.davem@redhat.com>
	<20021008162017.A11261@openss7.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Brian F. G. Bidulock" <bidulock@openss7.org>
   Date: Tue, 8 Oct 2002 16:20:17 -0600

   This version (courtesy of Dave Grothe at GCOM) uses up/down
   semaphore instead of read/write spinlocks.
   
Oh really?

   +static int (*do_putpmsg) (int, void *, void *, int, int) = NULL;
   +static int (*do_getpmsg) (int, void *, void *, int, int) = NULL;
   +
   +static rwlock_t streams_call_lock = RW_LOCK_UNLOCKED;
           ^^^^^^^^
   +
   +long asmlinkage sys_putpmsg(int fd, void *ctlptr, void *datptr, int band, int flags)
   +{
   +	int ret = -ENOSYS;
   +	read_lock(&streams_call_lock);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   +	if (do_putpmsg)
   +		ret = (*do_putpmsg) (fd, ctlptr, datptr, band, flags);
   +	read_unlock(&streams_call_lock);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   +	return ret;
   +}
