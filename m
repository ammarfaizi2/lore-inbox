Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293152AbSCEBsA>; Mon, 4 Mar 2002 20:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293252AbSCEBru>; Mon, 4 Mar 2002 20:47:50 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:29929 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293152AbSCEBro>; Mon, 4 Mar 2002 20:47:44 -0500
Date: Mon, 04 Mar 2002 17:47:51 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Greg KH <greg@kroah.com>, mingo@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of mp_bus_id_to_node array in 2.5.6-pre2
Message-ID: <256650000.1015292871@flay>
In-Reply-To: <20020305010910.GA6139@kroah.com>
In-Reply-To: <20020305010910.GA6139@kroah.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't remove this! This was preparatory work I did to enable
me to use PCI buses on nodes > 0 on NUMA-Q. The rest of the code
isn't in 2.5 yet (hence you can't see where it's used ;-) ) but the patches
to use it are now in 2.4, and I will submit them to 2.5 very shortly ....
(guess I'd better hurry up ;-) )

Thanks,

Martin.

--On Monday, March 04, 2002 17:09:11 -0800 Greg KH <greg@kroah.com> wrote:

> Hi,
> 
> Here's a patch against 2.5.6-pre2 that removes the mp_bus_id_to_node
> array from arch/i386/kernel/mpparse.c as it isn't needed anymore.  This
> saves us a small amount of kernel memory, which is always a good thing :)
> 
> thanks,
> 
> greg k-h
> 
> 
> diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
> --- a/arch/i386/kernel/mpparse.c	Mon Mar  4 16:59:01 2002
> +++ b/arch/i386/kernel/mpparse.c	Mon Mar  4 16:59:01 2002
> @@ -36,7 +36,6 @@
>   */
>  int apic_version [MAX_APICS];
>  int mp_bus_id_to_type [MAX_MP_BUSSES];
> -int mp_bus_id_to_node [MAX_MP_BUSSES];
>  int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
>  int mp_current_pci_id;
>  
> @@ -246,8 +245,7 @@
>  	str[6] = 0;
>  	
>  	if (clustered_apic_mode) {
> -		mp_bus_id_to_node[m->mpc_busid] = translation_table[mpc_record]->trans_quad;
> -		printk("Bus #%d is %s (node %d)\n", m->mpc_busid, str, mp_bus_id_to_node[m->mpc_busid]);
> +		printk("Bus #%d is %s (node %d)\n", m->mpc_busid, str, translation_table[mpc_record]->trans_quad);
>  	} else {
>  		Dprintk("Bus #%d is %s\n", m->mpc_busid, str);
>  	}
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


