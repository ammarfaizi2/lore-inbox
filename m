Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbTFBJ7Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbTFBJ7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:59:24 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:38394 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S262143AbTFBJ7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:59:22 -0400
Date: Mon, 2 Jun 2003 03:09:46 -0700
From: Chris Wright <chris@wirex.com>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Chris Wright <chris@wirex.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       greg@kroah.com, sds@epoch.ncsc.mil
Subject: Re: [PATCH][LSM] Early init for security modules and various cleanups
Message-ID: <20030602030946.H27233@figure1.int.wirex.com>
Mail-Followup-To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
	Chris Wright <chris@wirex.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
	greg@kroah.com, sds@epoch.ncsc.mil
References: <20030602025450.C27233@figure1.int.wirex.com> <Pine.LNX.4.44.0306021205520.27640-100000@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0306021205520.27640-100000@pointblue.com.pl>; from gj@pointblue.com.pl on Mon, Jun 02, 2003 at 12:08:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Grzegorz Jaskiewicz (gj@pointblue.com.pl) wrote:
> On Mon, 2 Jun 2003, Chris Wright wrote:
> 
> > @@ -91,7 +92,7 @@
> >  	 * Superuser processes are usually more important, so we make it
> >  	 * less likely that we kill those.
> >  	 */
> > -	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN) ||
> > +	if (!security_capable(p,CAP_SYS_ADMIN) ||
> >  				p->uid == 0 || p->euid == 0)
> >  		points /= 4;
> ..............
> > -	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
> > +	if (!security_capable(p,CAP_SYS_RAWIO))
> >  		points /= 4;
> 
> Correct me if i am wrong, but I think it is not a good idea to favor 
> applications with more 
> capabilities, as ussualy those are most wanted target on a system.

security_capable() returns 0 if that capability bit is set.  so there is
no functional change here, just allows the security module to see the
capability check that was hand coded.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
