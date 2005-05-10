Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVEJS6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVEJS6p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 14:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVEJS6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 14:58:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:22695 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261741AbVEJS6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 14:58:43 -0400
Message-ID: <4281045C.4020205@us.ibm.com>
Date: Tue, 10 May 2005 11:58:36 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC/PATCH] unregister_node() for hotplug use
References: <20050420173235.GA17775@kroah.com> <20050422003009.1b96f09c.tokunaga.keiich@jp.fujitsu.com> <20050422003920.GD6829@kroah.com> <20050422113211.509005f1.tokunaga.keiich@jp.fujitsu.com> <20050425230333.6b8dfb33.tokunaga.keiich@jp.fujitsu.com> <20050426065431.GB5889@suse.de> <20050507211141.4829d4c0.tokunaga.keiich@jp.fujitsu.com> <427FE7B3.8080200@us.ibm.com> <20050510202053.3ddd9e7b.tokunaga.keiich@jp.fujitsu.com> <4280FA41.3050403@us.ibm.com> <20050510184508.GA2463@suse.de>
In-Reply-To: <20050510184508.GA2463@suse.de>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, May 10, 2005 at 11:15:29AM -0700, Matthew Dobson wrote:
> 
>>So I think it's probably a good idea to stick the __devinit on
>>register_node() and unregister_node(), otherwise we have no marker to know
>>which functions to remove for CONFIG_TINY.  Greg?
> 
> 
> Like _anyone_ would have CONFIG_NUMA and CONFIG_TINY enabled at the same
> time?  I don't think so...
> 
> I'll leave it as is for now.
> 
> thanks,
> 
> greg k-h

No, it seems unlikely that anyone would build with CONFIG_NUMA and
CONFIG_TINY both enabled.  But it is possible and reasonable to build with
CONFIG_NUMA=y and CONFIG_HOTPLUG=n, which is the case I was trying to speak
to.  If NUMA is on and HOTPLUG is off, then we're wasting kernel text
(granted, it's a very small amount of space) for the register_node() &
unregister_node() functions that we *know* will never be called after
initial bootup.  That's why I suggested marking both of those functions as
__devinit.  But it doesn't make a huge difference either way.

-Matt
