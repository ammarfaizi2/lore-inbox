Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbUKJV1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUKJV1B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUKJV0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:26:06 -0500
Received: from sd291.sivit.org ([194.146.225.122]:10952 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262055AbUKJVVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:21:16 -0500
Date: Wed, 10 Nov 2004 22:21:32 +0100
From: Stelian Pop <stelian@popies.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] drivers/net/pcmcia: use module_param() instead of MODULE_PARM()
Message-ID: <20041110212132.GK2706@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.de>,
	Andrew Morton <akpm@osdl.org>
References: <20041104112736.GT3472@crusoe.alcove-fr> <418AE490.1010304@pobox.com> <20041110155903.GA8542@sd291.sivit.org> <20041110160058.GB8542@sd291.sivit.org> <41924339.1070809@osdl.org> <20041110195200.GJ2706@deep-space-9.dsnet> <41927055.9030306@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41927055.9030306@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 11:47:33AM -0800, Randy.Dunlap wrote:

> >In fact, I do think that all module parameter should be exposed in
> >/sys, and that a '0' in module_param() should really mean 0400.
> >
> >It can be useful to know what parameters have been passed to a module,
> >and I cannot think of a single case where we want to hide this 
> >information (and no, security doesn't really apply here. If you have
> >root rights than you can also look into the kernel memory and find
> >out the value by yourself).
[...]
> 
> I don't have an argument with most of that, but I am concerned
> about how much memory each entry requires and how useful it really
> is.  IOW, if I need to know the module parameters for a module,
> I can probably find that info somewhere else, like in
> /etc/modprobe.conf or a script etc., so why waste memory on it?

The problem is that the information you can get out of /etc/modprobe.conf
or some script is not necessarily consistent. Maybe the module was
hand-loaded using different parameters that the ones in the script.

This is the same issue as with the in-kernel .config. We have this
today because this way we're sure we are looking at the right one,
not an older copy which happen to be in /boot. Same thing for KKSYMOOPS.

Yes, this wastes a bit of memory (quite a lot actually for KKCONFIG
or KKSYMOOPS), but less and less people cares. And those who really
care (embedded people etc) can disable this with a config option.

If module parameters are a memory issue, maybe we should do the same
as above: put all of them into /sys unless chosen otherwise, and in
this case disable all of them, since we can go just fine without
any module parameter in /sys.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
