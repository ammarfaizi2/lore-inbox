Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424353AbWLHEoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424353AbWLHEoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 23:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424357AbWLHEoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 23:44:17 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:56598 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424353AbWLHEoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 23:44:16 -0500
Date: Thu, 7 Dec 2006 20:42:58 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Document how to decode an IOCTL number
Message-Id: <20061207204258.676d8a93.randy.dunlap@oracle.com>
In-Reply-To: <200612072306_MC3-1-D448-DB6A@compuserve.com>
References: <200612072306_MC3-1-D448-DB6A@compuserve.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 23:02:04 -0500 Chuck Ebbert wrote:

> Document how to decode a binary IOCTL number.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> ---
>  Documentation/ioctl/ioctl-decoding.txt |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Thanks...  could this be added to Documentation/ioctl-number.txt
instead?  and maybe move that file into Documentation/ioctl/ ?


> --- /dev/null
> +++ 2.6.19.0.5-32smp/Documentation/ioctl/ioctl-decoding.txt
> @@ -0,0 +1,24 @@
> +To decode a hex IOCTL code:
> +
> +Most architecures use this generic format, but check
> +include/ARCH/ioctl.h for specifics, e.g. powerpc
> +uses 3 bits to encode read/write and 13 bits for size.
> +
> + bits    meaning
> + 31-30	00 - no parameters: uses _IO macro
> +	10 - read: _IOR
> +	01 - write: _IOW
> +	11 - read/write: _IOWR
> +
> + 29-16	size of arguments
> +
> + 15-8	ascii character supposedly
> +	unique to each driver
> +
> + 7-0	function #
> +
> +
> + So for example 0x82187201 is a read with arg length of 0x218,
> +character 'r' function 1. Grepping the source reveals this is:
> +
> +#define VFAT_IOCTL_READDIR_BOTH         _IOR('r', 1, struct dirent [2])
> -- 

---
~Randy
