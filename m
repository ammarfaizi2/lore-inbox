Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVAFOsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVAFOsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 09:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbVAFOsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 09:48:33 -0500
Received: from [195.23.16.24] ([195.23.16.24]:15797 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262844AbVAFOsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 09:48:30 -0500
Message-ID: <41DD4FBC.2070404@grupopie.com>
Date: Thu, 06 Jan 2005 14:48:28 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, jaharkes@cs.cmu.edu,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       acme@conectiva.com.br, davem@redhat.com, nathans@sgi.com
Subject: Re: [Coverity] Untrusted user data in kernel
References: <1103247211.3071.74.camel@localhost.localdomain> <20050105120423.GA13662@logos.cnet> <20050105161653.GF13455@fi.muni.cz> <20050105140549.GA14622@logos.cnet> <20050106091844.GB6961@fi.muni.cz>
In-Reply-To: <20050106091844.GB6961@fi.muni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
> [...]
> +	if (mem.len <= 0 || mem.addr < 0 || mem.len > 65536 || mem.addr > 65535
> +		|| mem.addr + mem.len > 65536)
> +		return -EFAULT;

Just an extremely small nitpick. The conditions

mem.len > 65536 || mem.addr > 65535

aren't needed, because if one of them is true, then

mem.addr + mem.len > 65536

must be true also, since we've already asserted that len>0 and addr>=0.

This would be even simpler if len and addr were unsigned as they should 
be, but that's probably not your fault :(

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu
