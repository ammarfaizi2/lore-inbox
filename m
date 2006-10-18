Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWJRGyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWJRGyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 02:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWJRGyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 02:54:51 -0400
Received: from ranger.systems.pipex.net ([62.241.162.32]:56993 "EHLO
	ranger.systems.pipex.net") by vger.kernel.org with ESMTP
	id S964793AbWJRGyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 02:54:50 -0400
Message-ID: <4535CFB1.2010403@tungstengraphics.com>
Date: Wed, 18 Oct 2006 07:54:41 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Keith Packard <keithp@keithp.com>
Cc: Ryan Richter <ryan@tau.solarneutrino.net>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Intel 965G: i915_dispatch_cmdbuffer failed (2.6.19-rc2)
References: <20061013194516.GB19283@tau.solarneutrino.net>	<1160849723.3943.41.camel@neko.keithp.com>	<20061017174020.GA24789@tau.solarneutrino.net> <1161124062.25439.8.camel@neko.keithp.com>
In-Reply-To: <1161124062.25439.8.camel@neko.keithp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is all a little confusing as the driver doesn't really use that 
path in normal operation except for a single command - MI_FLUSH, which 
is shared between the architectures.  In normal operation the hardware 
does the validation for us for the bulk of the command stream.  If there 
  were missing functionality in that ioctl, it would be failing 
everywhere, not just in this one case.

I guess the questions I'd have are
	- did the driver work before the kernel upgrade?
	- what path in userspace is seeing you end up in this ioctl?
	- and like Keith, what commands are you seeing?

The final question is interesting not because we want to extend the 
ioctl to cover those, but because it will give a clue how you ended up 
there in the first place.

Keith

Keith Packard wrote:
> On Tue, 2006-10-17 at 13:40 -0400, Ryan Richter wrote:
> 
>> So do I want something like
>>
>>
>> static int do_validate_cmd(int cmd)
>> {
>> 	return 1;
>> }
>>
>> in i915_dma.c?
> 
> that will certainly avoid any checks. Another alternative is to printk
> the cmd which fails validation so we can see what needs adding here.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> 
> 
> ------------------------------------------------------------------------
> 
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel

