Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVH1Viy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVH1Viy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 17:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVH1Viy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 17:38:54 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:43933 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750824AbVH1Vix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 17:38:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=VruHgNWt8AyXFBWqwSc7ZzXHc+iidwOXPs8OpxZRwRUBWB68o5/sKtPFqQnoLduCk7S1hgsvDf1/kFilcgRsx7zZjSCe4NUWPVndet5Myxyx9K2UIyfrW/hBlI9s3x7UzZi6yZZ7UXu0qMiEVBUJ99FSWzGPzT5u9Wmhv3Sscgw=
Date: Mon, 29 Aug 2005 01:46:56 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
       V9FS Developers <v9fs-developer@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.13-rc6-mm2] v9fs: use standard kernel byteswapping routines
Message-ID: <20050828214656.GA11613@mipter.zuzino.mipt.ru>
References: <1125263107.17501.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125263107.17501.23.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2005 at 04:05:07PM -0500, Eric Van Hensbergen wrote:
> [PATCH] v9fs: use standard kernel byteswapping routines
> 
> Originally suggested by hch, we have removed our byteswap code
> and replaced it with calls to the standard kernel byteswapping code.

> -	buf->p[0] = val;
> -	buf->p[1] = val >> 8;
> +	*(u16 *) buf->p = cpu_to_le16(val);

*(__le16 *)

> -	ret = buf->p[0] | (buf->p[1] << 8);
> +	ret = le16_to_cpu(*(u16 *)buf->p);

*(__le16 *) etc.

Otherwise sparse will warn.

