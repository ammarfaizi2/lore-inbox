Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTJWIev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 04:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbTJWIeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 04:34:50 -0400
Received: from mailhost.netspeed.com.au ([203.31.48.33]:14600 "EHLO
	netspeed.com.au") by vger.kernel.org with ESMTP id S262868AbTJWIdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 04:33:38 -0400
Date: Thu, 23 Oct 2003 18:33:16 +1000
From: Martin Pool <mbp@samba.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Message-ID: <20031023083316.GB5272@sourcefrog.net>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200310171610.36569.bjorn.helgaas@hp.com> <20031017155028.2e98b307.akpm@osdl.org> <20031019181756.GP1659@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031019181756.GP1659@openzaurus.ucw.cz>
X-GPG: 1024D/A0B3E88B: AFAC578F 1841EE6B FD95E143 3C63CA3F A0B3E88B
User-Agent: Mutt/1.5.4i
X-Server: High Performance Mail Server - http://surgemail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Oct 2003, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> > > Old behavior:
> > > 
> > >     # dd if=/dev/mem of=/dev/null
> > >     <unrecoverable machine check>
> > 
> > I recently fixed this for ia32 by changing copy_to_user() to not oops if
> > the source address generated a fault.  Similarly copy_from_user() returns
> > an error if the destination generates a fault.
> 
> Are you sure this is not hiding real errors? If you pass wrong
> kernel ptr to copy_*_user, it should oops, not mask error with
> -EFAULT.
> Maybe another copy_user_unsafe should be created?

I think the problem is that reading memory that is mapped but doesn't
physically exist causes a Machine Check Assertion (like an NMI) rather
than a regular fault.

--
Martin
