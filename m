Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161318AbWJ3ShH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161318AbWJ3ShH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030569AbWJ3ShH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:37:07 -0500
Received: from mga03.intel.com ([143.182.124.21]:25382 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1030568AbWJ3ShF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:37:05 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,371,1157353200"; 
   d="scan'208"; a="138269725:sNHT546915859"
Date: Mon, 30 Oct 2006 11:37:15 -0800
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] acpiphp: fix use of list_for_each macro
Message-Id: <20061030113715.b5e8ddec.kristen.c.accardi@intel.com>
In-Reply-To: <20061028183943.GA9973@localhost>
References: <20061028183943.GA9973@localhost>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2006 03:39:43 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> This patch fixes invalid usage of list_for_each()
> 
> list_for_each (node, &bridge_list) {
> 	bridge = (struct acpiphp_bridge *)node;
> 	...
> }
> 
> This code works while the member of list node is located at the
> head of struct acpiphp_bridge.
> 
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Acked-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

> 
>  drivers/pci/hotplug/acpiphp_glue.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> Index: work-fault-inject/drivers/pci/hotplug/acpiphp_glue.c
> ===================================================================
> --- work-fault-inject.orig/drivers/pci/hotplug/acpiphp_glue.c
> +++ work-fault-inject/drivers/pci/hotplug/acpiphp_glue.c
> @@ -1693,14 +1693,10 @@ void __exit acpiphp_glue_exit(void)
>   */
>  int __init acpiphp_get_num_slots(void)
>  {
> -	struct list_head *node;
>  	struct acpiphp_bridge *bridge;
> -	int num_slots;
> -
> -	num_slots = 0;
> +	int num_slots = 0;
>  
> -	list_for_each (node, &bridge_list) {
> -		bridge = (struct acpiphp_bridge *)node;
> +	list_for_each_entry (bridge, &bridge_list, list) {
>  		dbg("Bus %04x:%02x has %d slot%s\n",
>  				pci_domain_nr(bridge->pci_bus),
>  				bridge->pci_bus->number, bridge->nr_slots,
