Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVAYCPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVAYCPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 21:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVAYCPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 21:15:39 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:4852 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261754AbVAYCPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 21:15:32 -0500
Message-ID: <41F5ABB8.8070308@mvista.com>
Date: Mon, 24 Jan 2005 18:15:20 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH 1/7] posix-timers: tidy up clock interfaces and consolidate
 dispatch logic
References: <200501232322.j0NNMcxe006476@magilla.sf.frob.com>
In-Reply-To: <200501232322.j0NNMcxe006476@magilla.sf.frob.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where were you when I was writing this stuff :).  I agree with most all of it, 
save the following:

 >  /*
 > + * Define this to initialize every k_clock function table so all its
 > + * function pointers are non-null, and always do indirect calls through the
 > + * table.  Leave it undefined to instead leave null function pointers and
 > + * decide at the call sites between a direct call (maybe inlined) to the
 > + * default function and an indirect call through the table when it's filled
 > + * in.  Which style is preferable is whichever performs better in the
 > + * common case of using the default functions.

 > +#define CLOCK_DISPATCH_DIRECT

As I understand it modern machines, the indirect call does really bad things to 
the pipeline.  The default call, even preceeded by the if, will be much faster 
by this reasoning.  I would, therefor, prefer not defining CLOCK_DISPATCH_DIRECT.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

