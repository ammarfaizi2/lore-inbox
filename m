Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbTBNSFo>; Fri, 14 Feb 2003 13:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbTBNSFo>; Fri, 14 Feb 2003 13:05:44 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:44548 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263333AbTBNSFn>; Fri, 14 Feb 2003 13:05:43 -0500
Date: Fri, 14 Feb 2003 18:15:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 355] New: Error when compiling SCSI drivers (Adaptec, Seagate etc.)
Message-ID: <20030214181535.B32737@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <57590000.1045237423@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <57590000.1045237423@[10.10.2.4]>; from mbligh@aracnet.com on Fri, Feb 14, 2003 at 07:43:43AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 07:43:43AM -0800, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=355
> 
>            Summary: Error when compiling SCSI drivers (Adaptec, Seagate
>                     etc.)
>     Kernel Version: 2.5.60 (- bk4)
>             Status: NEW
>           Severity: normal
>              Owner: andmike@us.ibm.com
>          Submitter: martinsteeg@t-online.de
> 
> 
> Software Environment: linnx Kernel 2.5.60 ( and snapshots -bk1 ... -bk4)  
> Problem Description:   
>   In the change of linux-2.5.59 to linux-2.5.60, the struct scsi_cmnd   
>   was changed in that the fields host, target, lun, channel are replaced   
>   by fields of the device field (struct scsi_device*): host, id, lun,
> channel       
>   This is not reflected in several SCSI drivers, e.g. the change is not  
>   considered for Adaptec and Seagate SCSI controllers.  
>   
> Proposal to fix the Problem:  
> 1. some new defines for drivers/scsi/scsi.h  
> +#define SCSICMND_HOST     device->host  
> +#define SCSICMND_TARGET   device->id  
> +#define SCSICMND_LUN      device->lun  
> +#define SCSICMND_CHANNEL  device->channel  

This macro abuse will never get into mainline.  Fix it to use the proper
dereferences directly, that'll work fine for older kernels aswell.

/me wonders how people get the crazy idea that cpp abuse will make code
more maintainable..
