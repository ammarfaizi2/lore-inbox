Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWF1S3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWF1S3e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbWF1S3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:29:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41436 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750843AbWF1S3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:29:34 -0400
Date: Wed, 28 Jun 2006 11:29:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.17-mm3: segvs in modpost with out-of-tree modules
Message-Id: <20060628112925.f96fcfc4.akpm@osdl.org>
In-Reply-To: <44A2B37F.4030500@goop.org>
References: <44A2B37F.4030500@goop.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 09:51:11 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> I'm seeing SIGSEGVs in modpost when compiling the out-of-tree madwifi 
> driver:
> 
>     /bin/sh: line 1: 3701 Segmentation fault scripts/mod/modpost -m -a
>     -i /home/jeremy/hg/linux-2.6/Module.symvers -I
>     /home/jeremy/svn/madwifi-ng/Modules.symvers -o
>     /home/jeremy/svn/madwifi-ng/Modules.symvers vmlinux
>     /home/jeremy/svn/madw ifi-ng/ath/ath_hal.o
>     /home/jeremy/svn/madwifi-ng/ath/ath_pci.o /home/jeremy/svn/
>     madwifi-ng/ath_rate/sample/ath_rate_sample.o
>     /home/jeremy/svn/madwifi-ng/net8021 1/wlan.o
>     /home/jeremy/svn/madwifi-ng/net80211/wlan_acl.o
>     /home/jeremy/svn/madwif i-ng/net80211/wlan_ccmp.o
>     /home/jeremy/svn/madwifi-ng/net80211/wlan_scan_ap.o
>     /home/jeremy/svn/madwifi-ng/net80211/wlan_scan_sta.o
>     /home/jeremy/svn/madwifi-ng/n et80211/wlan_tkip.o
>     /home/jeremy/svn/madwifi-ng/net80211/wlan_wep.o /home/jeremy
>     /svn/madwifi-ng/net80211/wlan_xauth.o
> 
> The backtrace is:
> 
> #0  0x4e8017da in strcmp () from /lib/libc.so.6
> #1  0x080491a7 in export_no (s=0x0) at modpost.c:209
> #2  0x0804b5c3 in read_dump (
>     fname=0xbff5fa9d "/home/jeremy/svn/madwifi-ng/Modules.symvers", kernel=0)
>     at modpost.c:1312
> #3  0x0804b88b in main (argc=21, argv=0xbff5def4) at modpost.c:1390
> 
> I haven't really looked at yet, but I was hoping someone had already 
> tracked it down.
> 

Not that I'm aware of.

		if ((export = strchr(modname, '\t')) != NULL)
			*export++ = '\0';

if `export' can be NULL,

		crc = strtoul(line, &d, 16);
		if (*symname == '\0' || *modname == '\0' || *d != '\0')
			goto fail;

		if (!(mod = find_module(modname))) {
			if (is_vmlinux(modname)) {
				have_vmlinux = 1;
			}
			mod = new_module(NOFAIL(strdup(modname)));
			mod->skip = 1;
		}
		s = sym_add_exported(symname, mod, export_no(export));

that was a bad idea.


