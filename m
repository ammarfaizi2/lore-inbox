Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWG0WXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWG0WXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 18:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWG0WXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 18:23:17 -0400
Received: from mail.gmx.de ([213.165.64.21]:30406 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751385AbWG0WXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 18:23:16 -0400
X-Authenticated: #5039886
Date: Fri, 28 Jul 2006 00:23:14 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] #define rwxr_xr_x 0755
Message-ID: <20060727222314.GA9192@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
References: <20060727205911.GB5356@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060727205911.GB5356@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.5.12-2006-07-14
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.07.28 00:59:11 +0400, Alexey Dobriyan wrote:
> Every time I try to decipher S_I* combos I cry in pain. Often I just
> refer to include/linux/stat.h defines to find out what mode it is
> because numbers are actually quickier to understand.
> 
> Compare and contrast:
> 
> 	0644 vs S_IRUGO|S_IWUSR vs rw_r__r__
> 
> I'd say #2 really sucks.

IMHO #3 sucks more, it's not as easy to spot when glossing over the
code, the underscores make it quite ugly (think _r________) and it's
less "greppable". If I know that there's something that sets S_ISUID, I
can easily search for that, compare that to [_cpdbl]{1}[r_]{1}[w_]{1}s...

And those S_I* things aren't that hard to parse actually. It starts with
the affected modes and then the "target user". So your example reads
like:

S_IRUGO | S_IWUSR:
Read - User Group Other | Write - User

It took me some time to realize that, but once you got it, it's easy.

Björn
