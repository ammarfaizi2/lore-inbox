Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUIMMOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUIMMOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 08:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUIMMOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 08:14:10 -0400
Received: from imr2.ericy.com ([198.24.6.3]:65500 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S266511AbUIMMNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:13:40 -0400
Message-ID: <41458B72.1000300@ericsson.com>
Date: Mon, 13 Sep 2004 07:58:42 -0400
From: Makan Pourzandi <Makan.Pourzandi@ericsson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: "Serge E. Hallyn" <hallyn@CS.WM.EDU>, linux-kernel@vger.kernel.org,
       Axelle Apvrille <axelle.apvrille@trusted-logic.fr>, serue@us.ibm.com,
       "David Gordon (QB/EMC)" <David.Gordon@ericsson.com>,
       gaspoucho@yahoo.com
Subject: Re: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time a
 uthentication of binaries
References: <21A5F45EFF209A44B3057E35CE1FE6E4BC415F@eammlex037.lmc.ericsson.se> <20040911125526.T1924@build.pdx.osdl.net>
In-Reply-To: <20040911125526.T1924@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Thanks for your patch. We'll work on it and come up with a new release 
soon. I'll keep you and the list emailed about your patch.

Best Regards,
Makan

Chris Wright wrote:
> * Makan Pourzandi (QB/EMC) (makan.pourzandi@ericsson.com) wrote:
> 
>>Thanks a lot for your feedback. We'll work on the modifications in
>>the source code mentioned in your email and send out a new release
>>hopefully soon.
> 
> 
> Here's a patch with a bunch of cleanups:
> (sorry it's one big patch, just kept growing...)
> 
> - white space and braces cleanups
> - NULL pointer checks unified as (!ptr)
> - fixup confusion on ERR_PTR vs. NULL (fixes Oopsen)
> - cast on kmalloc is unecessary
> - make anyting static that can be
>   - functions
>   - variables (and remove redundany 0 initialization for static vars)
>   - use static initializers for things like semaphores, lists, locks
>   - remove set_digsig_ops/security_set_operations in favor of
>     statically initiaized digsig_security_ops
> - name change digsig_attribute_st -> digsig_attribute
> - introduce DIGSIG_ATTR macro, and use for attribute initialization
> - change names of sysfs files (in module, and hopefully supporting scripts
>   and programs)
>   - digsig_interface -> key
>   - digsig_revoke -> revoke
> - move extern defs to header files
> - get ifndef/define header bits correct
> - move towards single point of return (goto and error cleanup)
> - fixup memory leaks on error return paths
> - move towards use of error values rather than just -1
> - move ctx cleanup out of digsig_sign_verify_final so that caller is
>   responsible (less confusion and no chance of double free on error
>   cleanup)
> - mark init functions as __init
> - use security_initcall()
> - remove unneeded digsig_init_revocation (list statically initialized now)
> - remove inline on external functions
> - use list_for_each_entry
> - collapse 'n' and 'e' cases in digsig_key_store for raw_public_key allocation
> - remove redundant file->f_security = NULL after digsig_allow_write_access()
> - move list_add_tail() in dsi_sysfs for revoked key into digsig_revocation.c
>   under helper digsig_add_revoked_sig()
> - add revoked_list_lock (used in above helper) for proper list manipulation
> - s/SHA1_TFM/sha1_tfm/ ala CodingStyle
> - fix bogus ctx==NULL check in digsig_sign_verify_update()
> 
> It compiles, and I actually loaded it and ran some tests to make sure
> it still works.  Seems OK.  I didn't work at stressing any of the error
> paths, but I think they are cleaner than they were.
> 
> thanks,
> -chris
> 


-- 

Makan Pourzandi, Open Systems Lab
Ericsson Research, Montreal, Canada
*This email does not represent or express the opinions of Ericsson Inc.*

