Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbSJDOFw>; Fri, 4 Oct 2002 10:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261784AbSJDOFv>; Fri, 4 Oct 2002 10:05:51 -0400
Received: from ns.suse.de ([213.95.15.193]:31760 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261783AbSJDOFu>;
	Fri, 4 Oct 2002 10:05:50 -0400
Date: Fri, 4 Oct 2002 16:11:23 +0200
From: Andi Kleen <ak@suse.de>
To: bidulock@openss7.org, linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
Message-ID: <20021004161123.A30109@wotan.suse.de>
References: <20021003153943.E22418@openss7.org.suse.lists.linux.kernel> <1033682560.28850.32.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel> <20021003170608.A30759@openss7.org.suse.lists.linux.kernel> <1033722612.1853.1.camel@localhost.localdomain.suse.lists.linux.kernel> <20021004051932.A13743@openss7.org.suse.lists.linux.kernel> <p73k7kyqrx6.fsf@oldwotan.suse.de> <20021004071106.A18191@openss7.org> <20021004151512.B10387@wotan.suse.de> <20021004072229.B18191@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004072229.B18191@openss7.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, for LiS, a process does not sleep on read_lock whenever write_lock
> might be called.  This is because only invalid getpmsg/putpmsg calls

See the "userptr" argument. The only way to access it is a 
copy_from/to_user, and that sleeps.

> (wrong file descriptor) can be made during module loading and unloading.
> No valid file descriptors exist for getpmsg/putpmsg when the module is
> unloading (proper use of MOD_INC/DEC_USE_COUNT).  I don't see that it
> matters that a process sleeps holding a read_lock() when it is a given
> that the write_lock() will never be attempted while the holder of the
> read_lock() is sleeping.

... Just you cannot guarantee that, except for never taking the write_lock,
which would make the whole exercise quite pointless.

-Andi
