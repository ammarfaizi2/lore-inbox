Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWCVKjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWCVKjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 05:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWCVKjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 05:39:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51684 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750700AbWCVKjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 05:39:49 -0500
Subject: Re: [RFC PATCH 26/35] Add Xen subarch reboot support
From: Arjan van de Ven <arjan@infradead.org>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <1992b724e8540f8e532806076d07eb9e@cl.cam.ac.uk>
References: <20060322063040.960068000@sorel.sous-sol.org>
	 <20060322063801.949835000@sorel.sous-sol.org>
	 <1143016837.2955.20.camel@laptopd505.fenrus.org>
	 <1992b724e8540f8e532806076d07eb9e@cl.cam.ac.uk>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 11:39:40 +0100
Message-Id: <1143023981.2955.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 10:22 +0000, Keir Fraser wrote:
> On 22 Mar 2006, at 08:40, Arjan van de Ven wrote:
> 
> >> +static int shutdown_process(void *__unused)
> >> +{
> >> +	static char *envp[] = { "HOME=/", "TERM=linux",
> >> +				"PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
> >> +	static char *restart_argv[]  = { "/sbin/reboot", NULL };
> >> +	static char *poweroff_argv[] = { "/sbin/poweroff", NULL };
> >
> > how is this function different from the generic one? If not, why aren't
> > you using the generic one?
> 
> The intent is to allow remote management tools to trigger a clean 
> shutdown of the virtual machine. That requires us to notify to 
> userspace, and this function does that by exec'ing one of the standard 
> userspace programs. Given the trigger is received by the kernel in the 
> first instance I don't know a better way of doing this. And if this is 
> the best way, I don't think there is generic code in the kernel which 
> does the same thing.


well this isn't really different from the normal ctrl-alt-delete right?
I would strongly suggest to follow the normal ctrl-alt-del path.. that
follows the normal convention sysadmins are used to.
It's not "/sbin/poweroff" fwiw... at least not hardcoded. Following the
normal ctrl-alt-del codepath gets all the policy out of this kind of
thing as well..


