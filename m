Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266262AbUGAUlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266262AbUGAUlM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 16:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUGAUlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 16:41:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:19872 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266262AbUGAUlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 16:41:10 -0400
Date: Thu, 1 Jul 2004 13:39:38 -0700
From: Greg KH <greg@kroah.com>
To: linas@austin.ibm.com
Cc: Dave Hansen <haveblue@us.ibm.com>, paulus@au1.ibm.com,
       Paul Mackerras <paulus@samba.org>,
       PPC64 External List <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6 PPC64: lockfix for rtas error log (third-times-a-charm?)]
Message-ID: <20040701203938.GB23260@kroah.com>
References: <20040701141931.E21634@forte.austin.ibm.com> <1088711355.21679.152.camel@nighthawk> <20040701153117.H21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701153117.H21634@forte.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 03:31:17PM -0500, linas@austin.ibm.com wrote:
> +	/* Log the error in the unlikely case that there was one. */
> +	if (unlikely(logit)) {
> +		buff_copy = kmalloc (RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
> +		if (buff_copy) {
> +			memcpy (buff_copy, rtas_err_buf, RTAS_ERROR_LOG_MAX);
> +		}
> +	}
> +	

The extra space before the '(' isn't needed, as the rest of this file
shows...

And shouldn't you return -ENOMEM if you are out of memory, and can't log
the message?

thanks,

greg k-h
