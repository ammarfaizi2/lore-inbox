Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVLHUX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVLHUX2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVLHUX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:23:28 -0500
Received: from mail.gmx.de ([213.165.64.20]:35034 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932337AbVLHUX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:23:27 -0500
X-Authenticated: #26200865
Message-ID: <4398963D.8040207@gmx.net>
Date: Thu, 08 Dec 2005 21:23:25 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@hp.com>
CC: len.brown@intel.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] ACPI owner_id limit too low
References: <1134066095.32040.20.camel@tdi>
In-Reply-To: <1134066095.32040.20.camel@tdi>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Williamson schrieb:
>    We've found recently that it's not very hard to bump into the limit
> of the number of owner_ids that the ACPI subsystem can provide.
> [...] Doubling the limit to 64 is a sufficient short term fix
> and a fairly trivial patch, maybe even something that could go in before
> 2.6.15.  Len, could we do something like the below patch to give us a
> little more reasonable limit?  We could switch to a bitmap too, but
> given how close the next kernel is to release this is less impact.
> Thanks,
> 
> 	Alex
> 
> 
> Signed-off-by: Alex Williamson <alex.williamson@hp.com>
> ---
> 
> diff -r 03055821672a drivers/acpi/utilities/utmisc.c
> --- a/drivers/acpi/utilities/utmisc.c	Mon Dec  5 01:00:10 2005
> +++ b/drivers/acpi/utilities/utmisc.c	Wed Dec  7 14:55:58 2005
> @@ -84,14 +84,14 @@
>  
>  	/* Find a free owner ID */
>  
> -	for (i = 0; i < 32; i++) {
> -		if (!(acpi_gbl_owner_id_mask & (1 << i))) {
> +	for (i = 0; i < 64; i++) {
> +		if (!(acpi_gbl_owner_id_mask & (1UL << i))) {

Shouldn't this be 1ULL if you intend it to be 64 bit wide on a
32 bit arch?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
