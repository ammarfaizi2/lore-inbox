Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVENLXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVENLXh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 07:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVENLXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 07:23:37 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:17482 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262740AbVENLXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 07:23:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=T89iUPumFN6IsafejiEY7mFzFeIy2smhjuxygVsdNPg8Bg3VDn9NtpmunjgsJEFawxJmjznglb9pDT/xOp7V2AIRXrM70j4KDlzKnghI5tNxhZ1OG0Dd4KdoFl+LGxOSUAj/sQ6Qe08PdM0kKN2DSdfX29g5hJoHkwKhrbkAbPU=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: domen@coderock.org
Subject: Re: [patch 1/1] alpha/osf_sys: use helper functions to convert between tv and jiffies
Date: Sat, 14 May 2005 15:27:28 +0400
User-Agent: KMail/1.7.2
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org,
       Nishanth Aravamudan <nacc@us.ibm.com>
References: <20050513214432.640931000@nd47.coderock.org>
In-Reply-To: <20050513214432.640931000@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505141527.28900.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 May 2005 01:44, domen@coderock.org wrote:
> Use helper functions to convert between timeval structure and jiffies
> rather than custom logic.

> --- quilt.orig/arch/alpha/kernel/osf_sys.c
> +++ quilt/arch/alpha/kernel/osf_sys.c

> -	ticks = tmp.tv_usec;
> -	ticks = (ticks + (1000000 / HZ) - 1) / (1000000 / HZ);
> -	ticks += tmp.tv_sec * HZ;
> +	ticks = timeval_to_jiffies(&tmp);

> -		tmp.tv_sec = ticks / HZ;
> -		tmp.tv_usec = ticks % HZ;
> +		jiffies_to_timeval(ticks, &tmp);

Nitpicking comment: both timeval_to_jiffies and jiffies_to_timeval are
prototyped in include/linux/jiffies.h. However, arch/alpha/kernel/osf_sys.c
doesn't directly #include it. 
