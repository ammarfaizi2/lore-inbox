Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbTBCVZ6>; Mon, 3 Feb 2003 16:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbTBCVZ5>; Mon, 3 Feb 2003 16:25:57 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:62969 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S265243AbTBCVZ5>; Mon, 3 Feb 2003 16:25:57 -0500
Date: Mon, 3 Feb 2003 13:35:06 -0800
From: Chris Wright <chris@wirex.com>
To: John Goerzen <jgoerzen@complete.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.20 panic in scheduler
Message-ID: <20030203133506.A26686@figure1.int.wirex.com>
Mail-Followup-To: John Goerzen <jgoerzen@complete.org>,
	linux-kernel@vger.kernel.org
References: <87k7gh85pw.fsf@christoph.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87k7gh85pw.fsf@christoph.complete.org>; from jgoerzen@complete.org on Mon, Feb 03, 2003 at 02:33:15PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Goerzen (jgoerzen@complete.org) wrote:
> 
> Today I experienced a kernel panic running kernel 2.4.20 (plus the ctx
> vserver patch; otherwise vanilla) with a bcm5700 module added in.  It's

Have you tried this without the vserver patch?  Last I looked it touched
many of the code paths in your trace below.  Also, if possible, set up a
serial console, it'll be a lot easier to catch the full trace.

> Adhoc c01093ef <system_call+33/38>
> Adhoc c011a201 <schedule+501/530>

vserver touches this code

> Adhoc c01208c8 <release_task+e8/110>

vserver touches this code

> Adhoc c01218dc <sys_wait4+39c/410>
> Adhoc c01218de <sys_wait4+39e/410>
> Adhoc c012b419 <sys_release_ip_info+29/60>

this is vserver code which could be called from either release_task() or
inet_sock_destruct() (both are in this trace).

you get the idea...
cheers,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
