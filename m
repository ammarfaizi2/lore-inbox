Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751627AbWEOTOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWEOTOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWEOTOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:14:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:54179 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751627AbWEOTOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:14:44 -0400
Subject: Re: [PATCH] 2.6.17-rc4-mm1 - kbuild wierdness with
	EXPORT_SYMBOL_GPL
From: Ram Pai <linuxram@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200605151900.k4FJ0ktD006410@turing-police.cc.vt.edu>
References: <200605151900.k4FJ0ktD006410@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: IBM 
Date: Mon, 15 May 2006 12:14:38 -0700
Message-Id: <1147720478.4884.74.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 15:00 -0400, Valdis.Kletnieks@vt.edu wrote:
> It looks like a buggy comparison down in the guts of
> kbuild-export-type-enhancement-to-modpostc.patch - it's doing
> something really odd when it hits a EXPORT_SYMBOL_GPL.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> ---
> Proposed fix (with an added debugging warning Just In Case:
> 
> --- linux-2.6.17-rc4-mm1/scripts/mod/modpost.c.whatdied	2006-05-15 13:50:13.000000000 -0400
> +++ linux-2.6.17-rc4-mm1/scripts/mod/modpost.c	2006-05-15 14:52:13.000000000 -0400
> @@ -1194,12 +1194,14 @@
>  					*d != '\0')
>  			goto fail;
>  
> -		if ((strcmp(export, "EXPORT_SYMBOL_GPL")))
> +		if ((strcmp(export, "EXPORT_SYMBOL_GPL") == 0))

Yes my mistake.  Error while merging in Andreas's fix. :(

Andrew, can apply this patch on top of the other patches?
RP



>  			export_type = 1;
>  		else if(strcmp(export, "EXPORT_SYMBOL") == 0)
>  			export_type = 0;
> -		else
> +		else {
> +			warn("Odd symbol export=%s symname=%s modname=%s\n",export,symname,modname);
>  			goto fail;
> +		}
>  
>  		if (!(mod = find_module(modname))) {
>  			if (is_vmlinux(modname)) {
> 
> 

