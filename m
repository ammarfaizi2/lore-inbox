Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263201AbREWSY5>; Wed, 23 May 2001 14:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263203AbREWSYr>; Wed, 23 May 2001 14:24:47 -0400
Received: from ns.suse.de ([213.95.15.193]:51464 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263201AbREWSYg>;
	Wed, 23 May 2001 14:24:36 -0400
Date: Wed, 23 May 2001 20:23:32 +0200
From: Andi Kleen <ak@suse.de>
To: Ben Mansell <linux-kernel@slimyhorror.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Selectively refusing TCP connections
Message-ID: <20010523202332.A31402@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.33.0105231841230.1163-100000@baphomet.bogo.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0105231841230.1163-100000@baphomet.bogo.bogus>; from linux-kernel@slimyhorror.com on Wed, May 23, 2001 at 06:59:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 06:59:02PM +0100, Ben Mansell wrote:
> Hi all,
> 
> Is there any mechanism in Linux for refusing incoming TCP connections?
> I'd like to be able to fetch the next incoming connection on a listen
> queue, and selectively accept or reject it based on the IP address of the
> client. I know this could be done via firewall rules, but for this case,
> I'd like an application to have the final say on whether the connection
> will be accepted.


You can push a BPF (LPF) filter expression onto a LISTEN socket that checks
every incoming packet using SO_ATTACH_FILTER.

The only way to do it fully in an application is probably to set up netfilter
NAT to forward the connection to some local process; or alternative push
the packets using a netfilter queue target to a user process and forward/
disable firewall rules dynamically.


-Andi

