Return-Path: <linux-kernel-owner+w=401wt.eu-S1422711AbWLUEvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbWLUEvL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 23:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbWLUEvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 23:51:11 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:28767 "HELO
	smtp107.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422711AbWLUEvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 23:51:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=S708eBmJaHz+w/caKebGD+I1z3Ln7hmfsAkEW90G5JSpD/wApZODCj5VOUtorPpQx+/18ASuWws4nuQvDWDdQdJue+j8lOCnRZhDnOmcBzF2dSu4N2geHuYYt9/FsosVB5fLo6S0oUoiRxayOoLH+EKbuh5hdRWmQ72lNRTCYOU=  ;
X-YMail-OSG: uHGGLlEVM1kn5u928DwpYfbKFdDlrKdQUWY1UgDWmzkZACNJfXLeGs_Eu1aSIzyVHN4s2kukWK6AAABC.Dy0Xpl8F8uFnxVE9mOzRVnPzPPCZgIkx0P2Ar41OPW8VletuQ_.HoumtoZhsbP_cj6ImbVI1WoaiQuCmQRP8K7nIeLhEINAd85JR9PvEK1T
From: David Brownell <david-b@pacbell.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] Fix /sys/device/.../power/state
Date: Wed, 20 Dec 2006 20:51:05 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org> <200612201904.28681.david-b@pacbell.net> <20061221040648.GA1499@srcf.ucam.org>
In-Reply-To: <20061221040648.GA1499@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612202051.06623.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 December 2006 8:06 pm, Matthew Garrett wrote:
> On Wed, Dec 20, 2006 at 07:04:28PM -0800, David Brownell wrote:
> > On Wednesday 20 December 2006 5:29 pm, Matthew Garrett wrote:
> > > I dislike that.
> > 
> > Tough noogies, as they say.  In a tradeoff between correctness and your
> > personal taste (or even mine, sigh!), the normal tradeoff is in favor
> > of correctness.
> 
> But it's not correct - the test prohibits suspending devices even if 
> it would be safe to do so.

It prohibits suspending them unless it's known to be safe.  What your
patch does is add some more ways to know it's safe.  My comment was
that while adding ways is safe, it's incorrect to allow things which
aren't known to be safe.


> > > We're asking to suspend an individual device - whether  
> > > the bus supports devices that need to suspend with interrupts disabled 
> > > is irrelevent, it's the device that we care about. We should just make 
> > > it necessary for every bus to support this method until the interface is 
> > > removed.
> > 
> > But you _didn't_ do anything to "make it necessary".  Which means that
> > your patch *WILL* cause bugs whenever a driver uses those calls, and
> > courtesy of your patch userspace tries to suspend that device ... 
> 
> New patch attached.

I'll have a look at it after I get past some other stuff.  I take it that
you tested this by now?  I assume it'd work, but you know how that goes.

- Dave
