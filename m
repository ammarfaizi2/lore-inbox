Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261817AbSJDO0R>; Fri, 4 Oct 2002 10:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261822AbSJDO0R>; Fri, 4 Oct 2002 10:26:17 -0400
Received: from gw.openss7.com ([142.179.199.224]:6927 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S261817AbSJDO0Q>;
	Fri, 4 Oct 2002 10:26:16 -0400
Date: Fri, 4 Oct 2002 08:31:48 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
Message-ID: <20021004083148.D18191@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20021003153943.E22418@openss7.org.suse.lists.linux.kernel> <1033682560.28850.32.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel> <20021003170608.A30759@openss7.org.suse.lists.linux.kernel> <1033722612.1853.1.camel@localhost.localdomain.suse.lists.linux.kernel> <20021004051932.A13743@openss7.org.suse.lists.linux.kernel> <p73k7kyqrx6.fsf@oldwotan.suse.de> <20021004071106.A18191@openss7.org> <20021004151512.B10387@wotan.suse.de> <20021004072229.B18191@openss7.org> <20021004161123.A30109@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021004161123.A30109@wotan.suse.de>; from ak@suse.de on Fri, Oct 04, 2002 at 04:11:23PM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Fri, 04 Oct 2002, Andi Kleen wrote:

> > Well, for LiS, a process does not sleep on read_lock whenever write_lock
> > might be called.  This is because only invalid getpmsg/putpmsg calls
> 
> See the "userptr" argument. The only way to access it is a 
> copy_from/to_user, and that sleeps.

The invalid argument is the fd, so no copy_from/to_user can occur
while another processor spins on the write_lock().

> 
> > (wrong file descriptor) can be made during module loading and unloading.
> > No valid file descriptors exist for getpmsg/putpmsg when the module is
> > unloading (proper use of MOD_INC/DEC_USE_COUNT).  I don't see that it
> > matters that a process sleeps holding a read_lock() when it is a given
> > that the write_lock() will never be attempted while the holder of the
> > read_lock() is sleeping.
> 
> ... Just you cannot guarantee that, except for never taking the write_lock,
> which would make the whole exercise quite pointless.

Yes, it is guaranteed by module use counts.

--brian

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
