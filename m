Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310289AbSCSHbk>; Tue, 19 Mar 2002 02:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310295AbSCSHba>; Tue, 19 Mar 2002 02:31:30 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:4883 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S310289AbSCSHbR>; Tue, 19 Mar 2002 02:31:17 -0500
Message-Id: <200203190728.g2J7Srq31344@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Russ Weight <rweight@us.ibm.com>, mingo@elte.hu
Subject: Re: [PATCH] Scalable CPU bitmasks
Date: Tue, 19 Mar 2002 09:28:25 -0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020318140700.A4635@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 March 2002 20:07, Russ Weight wrote:
>           While systems with more than 32 processors are still
>   out in the future, these interfaces provide a path for gradual
>   code migration. One of the primary goals is to provide current
>   functionality without affecting performance.

Not so far in the future. "7.52 second kernel compile" thread is about
timing kernel compile on the 32 CPU SMP box.

I don't know whether BUG() in inlines makes them too big, but
_for() _loops_ in inline functions definitely do that.
Here's one of the overgrown inlines:

> +static inline char *cpumap_format(cpumap_t map, char *buf, int size)
> +{
> +	if (size < CPUMAP_BUFSIZE) {
> +		BUG();
> +	}
> +
> +#if CPUMAP_SIZE > 1
> +	sprintf(buf, "0x" CPUMAP_FORMAT_STR, map[CPUMAP_SIZE-1]);
> +	{
> +		int i;
> +		char *p = buf + strlen(buf);
> +		for (i = CPUMAP_SIZE-2; i >= 0; i--, p += (sizeof(long) + 1)) {
> +			sprintf(p, " " CPUMAP_FORMAT_STR, map[i]);
> +		}
> +	}
> +#else
> +	sprintf(buf, "0x" CPUMAP_FORMAT_STR, map[0]);
> +#endif
> +	return(buf);
> +}
--
vda
