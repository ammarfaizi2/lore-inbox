Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUEVJ1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUEVJ1R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 05:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUEVJ1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 05:27:17 -0400
Received: from canuck.infradead.org ([205.233.217.7]:33286 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S265053AbUEVJ0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 05:26:33 -0400
Date: Sat, 22 May 2004 05:26:27 -0400
From: hch@infradead.org
To: Andrew Morton <akpm@osdl.org>, brking@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
Message-ID: <20040522092627.GA3432@infradead.org>
Mail-Followup-To: hch@infradead.org, Andrew Morton <akpm@osdl.org>,
	brking@us.ibm.com, linux-kernel@vger.kernel.org
References: <20040522013636.61efef73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522013636.61efef73.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +ipr-ppc64-depends.patch
> 
>  Make ipr.c depend on PPC

>> Makes ipr depend on CONFIG_PPC since this driver is unique to PPC hardware.
>> 
>> (It actually builds OK on x86, but it heavily uses anonymous unions, which
>> breaks on gcc-2.95)

I use gcc-2.95 happily on ppc.  Better thing is to either fix it up not to
use anonymous unions (which is a pitty because that feature helps making
code more readable sometimes) or stick a

#if (__GNUC__ < 3)
# error "This driver requires GCC 3.x"
#endif

ontop of the driver so people know why it fails at least.

Still wondering why these fixes don't go trhough linux-scsi..
