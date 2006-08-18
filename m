Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWHRW4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWHRW4z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWHRW4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:56:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:5878 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751559AbWHRW4y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:56:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/6]: powerpc/cell spidernet ethtool -i version number info.
Date: Sat, 19 Aug 2006 00:56:34 +0200
User-Agent: KMail/1.9.1
Cc: Linas Vepstas <linas@austin.ibm.com>, Jeff Garzik <jgarzik@pobox.com>,
       akpm@osdl.org, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       ens Osterkamp <Jens.Osterkamp@de.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com> <20060818222500.GK26889@austin.ibm.com>
In-Reply-To: <20060818222500.GK26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608190056.35775.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 August 2006 00:25, Linas Vepstas wrote:
> This patch adds version information as reported by 
> ethtool -i to the Spidernet driver.

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

except for

> @@ -2293,6 +2294,8 @@ static struct pci_driver spider_net_driv
>   */
>  static int __init spider_net_init(void)
>  {
> +       printk("spidernet Version %s.\n",VERSION);
> +

This printk is missing a level (KERN_INFO or similar). Moreover,
it is rather strange for a driver to print a message when no
device is actually used by it. I'd rather drop the version
printk completely, but I know that Jim has strong feelings about
what to do with version information. I suggest that if we decide
to keep something like that in the driver, it should be printed
in spider_net_probe().

	Arnd <><
