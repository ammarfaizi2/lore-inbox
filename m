Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263162AbVGIHun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbVGIHun (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 03:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbVGIHun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 03:50:43 -0400
Received: from [206.246.247.150] ([206.246.247.150]:6111 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263162AbVGIHul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 03:50:41 -0400
Date: Sat, 9 Jul 2005 03:50:35 -0400
From: Ben Collins <bcollins@debian.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       scjody@modernduck.com, bunk@stusta.de
Subject: Re: [2.6 patch] drivers/ieee1394/: schedule unused EXPORT_SYMBOL's for removal
Message-ID: <20050709075035.GA20151@phunnypharm.org>
References: <20050709030734.GD28243@stusta.de> <200507090722.j697Mcrv015292@einhorn.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507090722.j697Mcrv015292@einhorn.in-berlin.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can we, instead of removing these, wrap then in a "Export full API" config
option? I've already got several reports from external projects that are
using most of these exported symbols, and I'd hate to make it harder on
them to use our drivers (for internal projects or otherwise).

On Sat, Jul 09, 2005 at 09:22:38AM +0200, Stefan Richter wrote:
> On  9 Jul, Adrian Bunk wrote:
> > On Thu, Jul 07, 2005 at 09:30:21PM +0200, Stefan Richter wrote:
> >> Now that we are at it, the following EXPORT_SYMBOLs should be removed too...
> >> 	_csr1212_read_keyval
> > used in sbp2.c
> >> 	_csr1212_destroy_keyval
> > used in raw1394.c
> 
> You are right.
> 
> 
> <--  snip  -->
> 
> 
> 
> This patch schedules unused EXPORT_SYMBOL's for removal.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> 
> ---
> 
>  Documentation/feature-removal-schedule.txt |   21 ++++++++++++++
>  drivers/ieee1394/ieee1394_core.c           |   31 +++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> --- linux-2.6.12-rc4-mm1-full/Documentation/feature-removal-schedule.txt.old	2005-05-13 15:19:54.000000000 +0200
> +++ linux-2.6.12-rc4-mm1-full/Documentation/feature-removal-schedule.txt	2005-05-13 15:29:24.000000000 +0200
> @@ -93,0 +94,21 @@
> +
> +---------------------------
> +
> +What:	remove the following ieee1394 EXPORT_SYMBOL's:
> +	- hpsb_send_phy_config
> +	- hpsb_send_packet_and_wait
> +	- highlevel_add_host
> +	- highlevel_remove_host
> +	- nodemgr_for_each_host
> +	- csr1212_create_csr
> +	- csr1212_init_local_csr
> +	- csr1212_new_immediate
> +	- csr1212_associate_keyval
> +	- csr1212_new_string_descriptor_leaf
> +	- csr1212_destroy_csr
> +	- csr1212_generate_csr_image
> +	- csr1212_parse_csr
> +When:	August 2005
> +Files:	drivers/ieee1394/ieee1394_core.c
> +Why:	No modular usage in the kernel.
> +Who:	Adrian Bunk <bunk@stusta.de>
> --- linux-2.6.12-rc4-mm1-full/drivers/ieee1394/ieee1394_core.c.old	2005-05-13 15:19:34.000000000 +0200
> +++ linux-2.6.12-rc4-mm1-full/drivers/ieee1394/ieee1394_core.c	2005-05-13 15:28:17.000000000 +0200
> @@ -1226,7 +1226,13 @@
>  EXPORT_SYMBOL(hpsb_alloc_packet);
>  EXPORT_SYMBOL(hpsb_free_packet);
> +
> +/* EXPORT_SYMBOL scheduled for removal */
>  EXPORT_SYMBOL(hpsb_send_phy_config);
> +
>  EXPORT_SYMBOL(hpsb_send_packet);
> +
> +/* EXPORT_SYMBOL scheduled for removal */
>  EXPORT_SYMBOL(hpsb_send_packet_and_wait);
> +
>  EXPORT_SYMBOL(hpsb_reset_bus);
>  EXPORT_SYMBOL(hpsb_bus_reset);
> @@ -1265,6 +1271,11 @@
>  EXPORT_SYMBOL(hpsb_get_hostinfo_bykey);
>  EXPORT_SYMBOL(hpsb_set_hostinfo);
> +
> +/* EXPORT_SYMBOL scheduled for removal */
>  EXPORT_SYMBOL(highlevel_add_host);
> +
> +/* EXPORT_SYMBOL scheduled for removal */
>  EXPORT_SYMBOL(highlevel_remove_host);
> +
>  EXPORT_SYMBOL(highlevel_host_reset);
>  
> @@ -1275,4 +1286,6 @@
>  EXPORT_SYMBOL(hpsb_unregister_protocol);
>  EXPORT_SYMBOL(ieee1394_bus_type);
> +
> +/* EXPORT_SYMBOL scheduled for removal */
>  EXPORT_SYMBOL(nodemgr_for_each_host);
>  
> @@ -1312,18 +1325,36 @@
>  
>  /** csr1212.c **/
> +
> +/* EXPORT_SYMBOLs scheduled for removal */
>  EXPORT_SYMBOL(csr1212_create_csr);
>  EXPORT_SYMBOL(csr1212_init_local_csr);
>  EXPORT_SYMBOL(csr1212_new_immediate);
> +
>  EXPORT_SYMBOL(csr1212_new_directory);
> +
> +/* EXPORT_SYMBOL scheduled for removal */
>  EXPORT_SYMBOL(csr1212_associate_keyval);
> +
>  EXPORT_SYMBOL(csr1212_attach_keyval_to_directory);
> +
> +/* EXPORT_SYMBOL scheduled for removal */
>  EXPORT_SYMBOL(csr1212_new_string_descriptor_leaf);
> +
>  EXPORT_SYMBOL(csr1212_detach_keyval_from_directory);
>  EXPORT_SYMBOL(csr1212_release_keyval);
> +
> +/* EXPORT_SYMBOL scheduled for removal */
>  EXPORT_SYMBOL(csr1212_destroy_csr);
> +
>  EXPORT_SYMBOL(csr1212_read);
> +
> +/* EXPORT_SYMBOL scheduled for removal */
>  EXPORT_SYMBOL(csr1212_generate_csr_image);
> +
>  EXPORT_SYMBOL(csr1212_parse_keyval);
> +
> +/* EXPORT_SYMBOL scheduled for removal */
>  EXPORT_SYMBOL(csr1212_parse_csr);
> +
>  EXPORT_SYMBOL(_csr1212_read_keyval);
>  EXPORT_SYMBOL(_csr1212_destroy_keyval);
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
> July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
> core and dual graphics technology at this free one hour event hosted by HP,
> AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
> _______________________________________________
> mailing list linux1394-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux1394-devel

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
SwissDisk  - http://www.swissdisk.com/
