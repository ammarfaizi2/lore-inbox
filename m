Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262487AbRENUpw>; Mon, 14 May 2001 16:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbRENUpm>; Mon, 14 May 2001 16:45:42 -0400
Received: from ns.suse.de ([213.95.15.193]:21256 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262486AbRENUpc>;
	Mon, 14 May 2001 16:45:32 -0400
Date: Mon, 14 May 2001 22:45:08 +0200
From: Andi Kleen <ak@suse.de>
To: mostrows@speakeasy.net
Cc: Marcell GAL <cell@sch.bme.hu>, linux-kernel@vger.kernel.org,
        paulus@samba.org, "David S. Miller" <davem@redhat.com>
Subject: Re: Scheduling in interrupt BUG. [Patch]
Message-ID: <20010514224508.A3960@gruyere.muc.suse.de>
In-Reply-To: <3AFFBF14.7D7BAB01@sch.bme.hu> <15103.53345.869090.593925@slug.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15103.53345.869090.593925@slug.watson.ibm.com>; from mostrows@us.ibm.com on Mon, May 14, 2001 at 08:32:33AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 08:32:33AM -0400, Michal Ostrowski wrote:
> Having looked at the code for locking sockets I am concerned that the
> locking procedures for tcp may be wrong.   __release_sock releases the
> socket spinlock before calling sk->backlog_rcv() (== tcp_v4_do_rcv),
> however the comments at the top of tcp_v4_do_rcv() assert that the
> socket's spinlock is held (which is definitely not the case).
> 
> Anybody care to comment on this?

Looks ok for me.

The user socket lock (lock.users>0) is held while __release_sock runs, 
which is also sufficient to protect it as all new packets will go into backlog.
The spinlock comment only applies to bottom halves.

-Andi

