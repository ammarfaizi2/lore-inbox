Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267655AbUBTBLS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267611AbUBTBHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:07:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16138 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S267626AbUBTBEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:04:44 -0500
Message-ID: <40355D0D.3010800@transmeta.com>
Date: Thu, 19 Feb 2004 17:04:13 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel too big
References: <UTC200402200021.i1K0L1525525.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200402200021.i1K0L1525525.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> In 2.5.61 hpa changed
> 
> -      /* 0x28000*16 = 2.5 MB, conservative estimate for the current maximum */
> -      if (sys_size > (is_big_kernel ? 0x28000 : DEF_SYSSIZE))
> +      /* 0x40000*16 = 4.0 MB, reasonable estimate for the current maximum */
> +      if (sys_size > (is_big_kernel ? 0x40000 : DEF_SYSSIZE))
>               die("System is too big. ...");
> 
> (with comment "bootsect removal").
> 
> Today I find for a 2.6.3 machine that it boots with 2994 kB and
> crashes at boot time with 3005 kB.
> 
> Thus, it looks like this "reasonable estimate" is too optimistic.
> 
> If I understand correctly, the real requirement is that
> _end must stay below 8MB (unless the initial page tables
> in head.S are made larger). A crash occurs with _end = c07fcf8c.
> 
> Maybe these "conservative" or "reasonable" estimates should be
> replaced by a text on _end?
> 

What we should do is to actually look at the limit that matters.

Also, if the limit really is around 3 MB compressed we probably need to
extend it to 16 MB uncompressed; we're a little too close for comfort.

