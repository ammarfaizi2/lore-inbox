Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbULFVLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbULFVLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbULFVLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:11:15 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:52460 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261649AbULFVIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:08:18 -0500
Message-ID: <41B4C93E.10203@nortelnetworks.com>
Date: Mon, 06 Dec 2004 15:03:58 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Riina Kikas <riinak@ut.ee>
CC: linux-kernel@vger.kernel.org, mroos@ut.ee
Subject: Re: [PATCH 2.6] clean-up: fixes "unsigned>=0" warning
References: <Pine.SOC.4.61.0412062247160.21075@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0412062247160.21075@math.ut.ee>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riina Kikas wrote:
> This patch fixes warning "comparison of unsigned expression >= 0 is 
> always true"
> occuring on line 38
> 
> Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>
> 
> --- a/fs/ntfs/collate.h    2004-10-18 21:53:06.000000000 +0000
> +++ b/fs/ntfs/collate.h    2004-12-04 13:26:03.000000000 +0000
> @@ -37,7 +37,7 @@
>      if (unlikely(cr != COLLATION_BINARY && cr != COLLATION_NTOFS_ULONG))
>          return FALSE;
>      i = le32_to_cpu(cr);
> -    if (likely(((i >= 0) && (i <= 0x02)) ||
> +    if (likely(cr <= 0x02 ||

Do we really want to be doing any operations on "cr", since it's not known what 
endianness of cpu we're on?

Chris

