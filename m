Return-Path: <linux-kernel-owner+w=401wt.eu-S1751700AbXAVOUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbXAVOUx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 09:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbXAVOUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 09:20:52 -0500
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:56457 "EHLO
	vulpecula.futurs.inria.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbXAVOUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 09:20:52 -0500
X-Greylist: delayed 1382 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jan 2007 09:20:52 EST
Message-ID: <45B4C2DA.8020906@lifl.fr>
Date: Mon, 22 Jan 2007 14:57:46 +0100
From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@lifl.fr>
User-Agent: Thunderbird 1.5.0.9 (X11/20070105)
MIME-Version: 1.0
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: akpm@osdl.org, ralf@linux-mips.org, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
References: <20070118160338.GA6343@linux-mips.org>	<20070118135326.c0238873.akpm@osdl.org>	<20070119.121910.96686038.nemoto@toshiba-tops.co.jp> <20070119.125751.104030382.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20070119.125751.104030382.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01/19/2007 04:57 AM, Atsushi Nemoto wrote/a écrit:
> On Fri, 19 Jan 2007 12:19:10 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>> OK, here is a revised patch which uses pci= option instead of config
>> parameters.
> 
> Sorry, this patch would cause build failure if setup-bus.c was not
> built into kernel.  Revised again.
> 
> 
> Subject: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
> 
> CARDBUS_MEM_SIZE was increased to 64MB on 2.6.20-rc2, but larger size
> might result in allocation failure for the reserving itself on some
> platforms (for example typical 32bit MIPS).  Make it (and
> CARDBUS_IO_SIZE too) customizable by "pci=" option for such platforms.
:
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 25d2985..ace7a9a 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1259,6 +1259,12 @@ and is between 256 and 4096 characters. 
>  				This sorting is done to get a device
>  				order compatible with older (<= 2.4) kernels.
>  		nobfsort	Don't sort PCI devices into breadth-first order.
> +		cbiosize=nn[KMG]	A fixed amount of bus space is
> +				reserved for CardBus bridges.
> +				The default value is 256 bytes.
> +		cbmemsize=nn[KMG]	A fixed amount of bus space is
> +				reserved for CardBus bridges.
> +				The default value is 64 megabytes.
Hi, I've got the feeling that those two parameters don't do the same 
things, although they have the same description ;-) Maybe the texts 
could be:
* The fixed amount of bus space which is reserved for the CardBus 
bridges IO window.
* The fixed amount of bus space which is reserved for the CardBus 
bridges memory window.

See you,
Eric
