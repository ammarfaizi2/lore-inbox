Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbTAODUY>; Tue, 14 Jan 2003 22:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTAODUY>; Tue, 14 Jan 2003 22:20:24 -0500
Received: from packet.digeo.com ([12.110.80.53]:23178 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261356AbTAODUY> convert rfc822-to-8bit;
	Tue, 14 Jan 2003 22:20:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Morton <akpm@digeo.com>
To: ryan <ryan@ryanflynn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.56 sound/oss/sb_mixer.c bounds check
Date: Tue, 14 Jan 2003 19:30:00 -0800
User-Agent: KMail/1.4.3
References: <3E24D1D5.5090200@ryanflynn.com>
In-Reply-To: <3E24D1D5.5090200@ryanflynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301141930.00567.akpm@digeo.com>
X-OriginalArrivalTime: 15 Jan 2003 03:29:10.0934 (UTC) FILETIME=[44E44B60:01C2BC46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue January 14 2003 19:13, ryan wrote:
>
> diff -urN a/sound/oss/sb_mixer.c b/sound/oss/sb_mixer.c
> --- a/sound/oss/sb_mixer.c      Fri Jan 10 15:11:27 2003
> +++ b/sound/oss/sb_mixer.c      Tue Jan 14 22:06:20 2003
> @@ -333,6 +333,9 @@
>                          break;
> 
>                  default:
> +                       /* bounds check */
> +                       if (dev >= sizeof(smw_mix_regs))
> +                               return -EINVAL;
>                          reg = smw_mix_regs[dev];
>                          if (reg == 0)
>                                  return -EINVAL;

Yup.

It would be better to do:

	if (dev < 0 || dev >= ARRAY_SIZE(smw_mix_regs))



