Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUJ3Wlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUJ3Wlg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbUJ3Wlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:41:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14264 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261369AbUJ3Wla
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:41:30 -0400
Message-ID: <41841886.2080609@pobox.com>
Date: Sat, 30 Oct 2004 18:41:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maximilian attems <janitor@sternwelten.at>
CC: Margit Schubert-While <margitsw@t-online.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, hvr@gnu.org,
       mcgrof@studorgs.rutgers.edu, kernel-janitors@lists.osdl.org,
       prism54-devel@prism54.org, netdev@oss.sgi.com,
       Domen Puncer <domen@coderock.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4] back port msleep(), msleep_interruptible()
References: <20040923221303.GB13244@us.ibm.com> <20040923221303.GB13244@us.ibm.com> <5.1.0.14.2.20040924074745.00b1cd40@pop.t-online.de> <415CD9D9.2000607@pobox.com> <20041030222228.GB1456@stro.at>
In-Reply-To: <20041030222228.GB1456@stro.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems wrote:
> diff -puN include/linux/delay.h~add-msleep-2.4 include/linux/delay.h
> --- a/include/linux/delay.h~add-msleep-2.4	2004-10-30 22:48:46.000000000 +0200
> +++ b/include/linux/delay.h	2004-10-30 22:48:46.000000000 +0200
> @@ -34,4 +34,12 @@ extern unsigned long loops_per_jiffy;
>  	({unsigned long msec=(n); while (msec--) udelay(1000);}))
>  #endif
>  
> +void msleep(unsigned int msecs);
> +unsigned long msleep_interruptible(unsigned int msecs);
> +
> +static inline void ssleep(unsigned int seconds)
[...]
> +static inline unsigned int jiffies_to_msecs(const unsigned long j)

> +static inline unsigned int jiffies_to_usecs(const unsigned long j)

> +static inline unsigned long msecs_to_jiffies(const unsigned int m)


I'm pretty sure more than one of these symbols clashes with a symbol 
defined locally in a driver.  I like the patch but we can't apply it 
until the impact on existing code is evaluated.

	Jeff


