Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVCBXir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVCBXir (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVCBXg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:36:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:24784 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261358AbVCBXez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:34:55 -0500
Subject: Re: [PATCH 2/3] openfirmware: adds sysfs nodes for openfirmware
	devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeffrey Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050301211824.GC16465@locomotive.unixthugs.org>
References: <20050301211824.GC16465@locomotive.unixthugs.org>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 10:32:14 +1100
Message-Id: <1109806334.5611.121.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 16:18 -0500, Jeffrey Mahoney wrote:
> This patch adds sysfs nodes that the hotplug userspace can use to load the
> appropriate modules.
> 
> In order for hotplug to work with macio devices, patches to module-init-tools
> and hotplug must be applied. Those patches are available at:
> 
> ftp://ftp.suse.com/pub/people/jeffm/linux/macio-hotplug/
> 
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>

> +static ssize_t
> +compatible_show (struct device *dev, char *buf)        
> +{
> +        struct of_device *of;
> +        char *compat;
> +        int cplen;
> +        int length = 0;
> +        
> +        of = &to_macio_device (dev)->ofdev;
> +	compat = (char *) get_property(of->node, "compatible", &cplen);
> +	if (!compat) {
> +		*buf = '\0';
> +		return 0;
> +	}
> +	while (cplen > 0) {
> +		int l;
> +		length += sprintf (buf, "%s%s", length ? "," : "", compat);
> +		buf += length;
> +		l = strlen (compat) + 1;
> +		compat += l;
> +		cplen -= l;
> +	}
> +
> +	return length;
> +}
> +

There is a problem here. "," is a valid character within a "compatible"
property, and is actually regulary used. Normally, "compatible" is a
list, with '\0' beeing the separator. I suggest using CRLF instead.

Ben.
 

