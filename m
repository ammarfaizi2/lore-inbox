Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318169AbSHUQCY>; Wed, 21 Aug 2002 12:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318355AbSHUQCX>; Wed, 21 Aug 2002 12:02:23 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:34541 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318169AbSHUQCW>;
	Wed, 21 Aug 2002 12:02:22 -0400
Date: Wed, 21 Aug 2002 09:04:01 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "Feldman, Scott" <scott.feldman@intel.com>,
       "'Troy Wilson'" <tcw@tempest.prismnet.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org, tcw@prismnet.com
Subject: RE: mdelay causes BUG, please use udelay
Message-ID: <2544596606.1029920638@[10.10.2.3]>
In-Reply-To: <288F9BF66CD9D5118DF400508B68C4460283E4AF@orsmsx113.jf.intel.com>
References: <288F9BF66CD9D5118DF400508B68C4460283E4AF@orsmsx113.jf.intel.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> -    msec_delay(10);
>> +    usec_delay(10000);
> 
> Jeff, 10000 seems on the border of what's OK.  If it's acceptable, 
> then let's go for that.  Otherwise, we're going to have to chain 
> several mod_timer callbacks together to do a controller reset.

Whilst this sort of delay in interrupt context is undoubtedly bad
any way we do it, I'd question the context a little more before we
make a decision. This is called from e1000_reset_hw - are we likely
to ever actually call this except under initialisation? If we just
do it once on system boot, I'd say evil hacks (like this) are 
acceptable. If we're going to do this under load, it definitely
needs fixing.

FWIW, this is heavily tested under Apache webserver load on a maxed 
out 8 CPU system with at least 4 (8?) gigabit ethernet cards. Whilst
undoubtedly ugly, it's better than what we have now, so might I 
suggest that we do this for now until a real fix is forthcoming if
we decide it's needed?

Martin.

