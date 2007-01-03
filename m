Return-Path: <linux-kernel-owner+w=401wt.eu-S932199AbXACXxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbXACXxH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 18:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbXACXxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 18:53:07 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:24039 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932199AbXACXxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 18:53:05 -0500
Date: Wed, 3 Jan 2007 15:39:41 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] EDAC: e752x-bit-mask-fix
Message-Id: <20070103153941.1486073f.randy.dunlap@oracle.com>
In-Reply-To: <20070103001336.84797.qmail@web50110.mail.yahoo.com>
References: <20070103001336.84797.qmail@web50110.mail.yahoo.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2007 16:13:36 -0800 (PST) Doug Thompson wrote:

> from: Brian Pomerantz <bapper@mvista.com>
> 
> Description:
>     The fatal vs. non-fatal mask for the sysbus FERR status is
> incorrect
>     according to the E7520 datasheet.  This patch corrects the mask to
> correctly
>     handle fatal and non-fatal errors.
> 
> Signed-off-by: Brian Pomerantz <bapper@mvista.com>
> Signed-off-by: Dave Jiang <djiang@mvista.com>
> Signed-off-by: Doug Thompson <norsk5@xmission.com>
> 
>  e752x_edac.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6.18/drivers/edac/e752x_edac.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/edac/e752x_edac.c
> +++ linux-2.6.18/drivers/edac/e752x_edac.c
> @@ -561,17 +561,17 @@ static void e752x_check_sysbus(struct e7
>  	error32 = (stat32 >> 16) & 0x3ff;
>  	stat32 = stat32 & 0x3ff;
>  
> -	if(stat32 & 0x083)
> -		sysbus_error(1, stat32 & 0x083, error_found, handle_error);
> +	if(stat32 & 0x087)
> +		sysbus_error(1, stat32 & 0x087, error_found, handle_error);
>  
> -	if(stat32 & 0x37c)
> -		sysbus_error(0, stat32 & 0x37c, error_found, handle_error);
> +	if(stat32 & 0x378)
> +		sysbus_error(0, stat32 & 0x378, error_found, handle_error);
>  
> -	if(error32 & 0x083)
> -		sysbus_error(1, error32 & 0x083, error_found, handle_error);
> +	if(error32 & 0x087)
> +		sysbus_error(1, error32 & 0x087, error_found, handle_error);
>  
> -	if(error32 & 0x37c)
> -		sysbus_error(0, error32 & 0x37c, error_found, handle_error);
> +	if(error32 & 0x378)
> +		sysbus_error(0, error32 & 0x378, error_found, handle_error);
>  }

	if (

Are these bit masks documented somewhere?

You could make that almost readable by using some #defines for them.

---
~Randy
