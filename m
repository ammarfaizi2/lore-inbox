Return-Path: <linux-kernel-owner+w=401wt.eu-S1751912AbWLVSga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbWLVSga (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 13:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWLVSga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 13:36:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35095 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbWLVSg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 13:36:29 -0500
Date: Fri, 22 Dec 2006 10:36:15 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Keiichi KII <k-keiichi@bx.jp.nec.com>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH -mm 0/5] proposal for dynamic configurable
 netconsole
Message-ID: <20061222103615.6e074f4e@localhost.localdomain>
In-Reply-To: <458BC905.7050003@bx.jp.nec.com>
References: <458BC905.7050003@bx.jp.nec.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006 21:01:09 +0900
Keiichi KII <k-keiichi@bx.jp.nec.com> wrote:

> From: Keiichi KII <k-keiichi@bx.jp.nec.com>
> 
> The netconsole is a very useful module for collecting kernel message under
> certain circumstances(e.g. disk logging fails, serial port is unavailable).
> 
> But current netconsole is not flexible. For example, if you want to change ip
> address for logging agent, in the case of built-in netconsole, you can't change
> config except for changing boot parameter and rebooting your system, or in the
> case of module netconsole, you need to reload netconsole module.

If netconsole is a module, you should be able to remove it and reload
with different parameters.

> So, I propose the following extended features for netconsole.
> 
> 1) support for multiple logging agents.
> 2) add interface to access each parameter of netconsole
>    using sysfs.
> 
> This patch is for linux-2.6.20-rc1-mm1 and is divided to each function.
> Your comments are very welcome.

Rather than extending the existing kludge with module parameter, to
sysfs. I would rather see a better API for this. Please build think
about doing a better API with a basic set of ioctl's. Some additional
things:
	- shouldn't just be IPV4 specific, should handle IPV6 as well
	- shouldn't specify MAC address, it can do network discovery/arp to
	  find that when adding addresses
