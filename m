Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbVHSNpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVHSNpT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 09:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbVHSNpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 09:45:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26384 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932524AbVHSNpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 09:45:17 -0400
Date: Fri, 19 Aug 2005 14:45:09 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
Message-ID: <20050819144509.C2880@flint.arm.linux.org.uk>
Mail-Followup-To: Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050819043331.7bc1f9a9.akpm@osdl.org> <4305DDBF.1060309@ens-lyon.org> <20050819142746.B2880@flint.arm.linux.org.uk> <4305E189.1080903@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4305E189.1080903@ens-lyon.org>; from Brice.Goglin@ens-lyon.org on Fri, Aug 19, 2005 at 03:41:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 03:41:29PM +0200, Brice Goglin wrote:
> Le 19.08.2005 15:27, Russell King a écrit :
> > Since you're going to be adding #ifdef CONFIG_SMP...#endif around each
> > of these, why not fix where it's declared/defined to be empty?
> 
> Probably because I'm too lazy to find a nice way to fix it :)
> 
> smp_nmi_call_function may return an error but I don't see any place
> where the return value is actually checked. If the error case is
> actually possible, we should check the return value, and the warning
> would disappear.
> 
> Sorry but I'm not familiar enough with this code to know what's the
> good solution :(

Well, I don't have access to the code you're looking at so I'll make
the following suggestion completely blind.  You want the header file
which defines smp_nmi_call_function() to contain something like:

#ifdef CONFIG_SMP
extern int smp_nmi_call_function(void (*fn)(void *), void *priv, int whatever);
#else
static inline int smp_nmi_call_function(void (*fn)(void *), void *priv, int whatever)
{
	return 0;
}
#endif

Obviously I've probably got the arguments to smp_nmi_call_function()
wrong, so they'll need fixing.  I'm sure the above will point you in
the right direction though.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
