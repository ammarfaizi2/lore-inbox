Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264848AbSLBSwV>; Mon, 2 Dec 2002 13:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbSLBSwV>; Mon, 2 Dec 2002 13:52:21 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:31430 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264848AbSLBSwT>; Mon, 2 Dec 2002 13:52:19 -0500
Date: Mon, 2 Dec 2002 11:01:14 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.50-current-bk and EDD
Message-ID: <20021202190114.GB1850@beaverton.ibm.com>
Mail-Followup-To: Petr Vandrovec <vandrove@vc.cvut.cz>,
	Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org
References: <20021202183619.GB9798@vana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021202183619.GB9798@vana>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec [vandrove@vc.cvut.cz] wrote:
> Hi Matt,
>    I'm not sure that this patch is correct, but at least I can
> compile kernel now. As I have no SCSI devices in the box, I have
> no idea whether this to_scsi_host() should do same thing as
> to_scsi_host() in drivers/scsi does...
> 				Thanks,
> 					Petr Vandrovec
> 				
> 
> 
> diff -urdN linux/arch/i386/kernel/edd.c linux/arch/i386/kernel/edd.c
> --- linux/arch/i386/kernel/edd.c	2002-12-02 17:28:11.000000000 +0000
> +++ linux/arch/i386/kernel/edd.c	2002-12-02 17:36:49.000000000 +0000
> @@ -686,8 +686,6 @@
>   * The reference counting probably isn't the best it could be.
>   */
>  
> -#define	to_scsi_host(d)	\
> -	container_of(d, struct Scsi_Host, host_driverfs_dev)
>  #define children_to_dev(n) container_of(n,struct device,node)
>  static struct scsi_device *
>  edd_find_matching_scsi_device(struct edd_device *edev)

This is my bad with some sysfs updates I did recently to scsi. The patch
will make you compile, but the to_scsi_host is host.h does not return the
same data as the previous to_scsi_host in edd.c did if class_data is not
set. Though the "sh" variable is never used in the function
edd_find_matching_scsi_device. I will look over this function some more
and send mail to the list / Matt as to what else might have broke.

-andmike
--
Michael Anderson
andmike@us.ibm.com

