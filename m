Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270524AbUJUD26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270524AbUJUD26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 23:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269097AbUJUD2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 23:28:25 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:36193 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270162AbUJUDKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 23:10:55 -0400
Message-ID: <417728B0.3070006@yahoo.com.au>
Date: Thu, 21 Oct 2004 13:10:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
References: <20041021011714.GQ24619@dualathlon.random>
In-Reply-To: <20041021011714.GQ24619@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> I don't see why this 'int x' exists, alignment should really work fine
> even with empty structure (works with my compiler with an userspace
> test, please double check).
> 
> Index: linux-2.5/include/linux/mmzone.h
> ===================================================================
> RCS file: /home/andrea/crypto/cvs/linux-2.5/include/linux/mmzone.h,v
> retrieving revision 1.67
> diff -u -p -r1.67 mmzone.h
> --- linux-2.5/include/linux/mmzone.h	19 Oct 2004 14:58:00 -0000	1.67
> +++ linux-2.5/include/linux/mmzone.h	21 Oct 2004 01:14:20 -0000
> @@ -35,7 +35,6 @@ struct pglist_data;
>   */
>  #if defined(CONFIG_SMP)
>  struct zone_padding {
> -	int x;
>  } ____cacheline_maxaligned_in_smp;
>  #define ZONE_PADDING(name)	struct zone_padding name;
>  #else

Perhaps to keep old compilers working? Not sure.

I think it is common to use a zero length array...?

	int x[0];

Although that maybe that is only used when one requires a
handle on the address.

Nick
