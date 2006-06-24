Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932750AbWFXAml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbWFXAml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 20:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWFXAml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 20:42:41 -0400
Received: from mx1.suse.de ([195.135.220.2]:64658 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932750AbWFXAmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 20:42:40 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] [20/82] i386: Panic the system when a NUMA kernel doesn't run on IBM NUMA
Date: Sat, 24 Jun 2006 02:42:31 +0200
User-Agent: KMail/1.9.3
Cc: torvalds@osdl.org, discuss@x86-64.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <449C8510.mailCWD11E44E@suse.de> <20060624003856.GE19461@redhat.com>
In-Reply-To: <20060624003856.GE19461@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606240242.31906.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 June 2006 02:38, Dave Jones wrote:
> On Sat, Jun 24, 2006 at 02:19:28AM +0200, Andi Kleen wrote:
> 
> 
>  > +	extern int use_cyclone;
>  > +	if (use_cyclone == 0) {
>  > +		/* Make sure user sees something */
>  > +		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else.";
>  > +		early_printk(s);
>  > +		panic(s);
>  > +	}
> 
> non-IBM Machines do still boot with that enabled though don't they?


No they don't - as they likely didn't do before. e.g. Opterons generally
break and that brings the point across clearer.

The rationale is that CONFIG_NUMA is very rarely used on i386 (even on summit)
and always does bitrot quickly. It also doesn't work at all on a wide
range of machines.

I'm sure someone will bring up now an example where their non Summit 
machine booted with CONFIG_NUMA, but they were just extremly lucky
and unlikely to be for very long.

-Andi
