Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264951AbSJWMmK>; Wed, 23 Oct 2002 08:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbSJWMmK>; Wed, 23 Oct 2002 08:42:10 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:22735 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264951AbSJWMmJ>;
	Wed, 23 Oct 2002 08:42:09 -0400
Date: Wed, 23 Oct 2002 14:48:19 +0200
From: bert hubert <ahu@ds9a.nl>
To: riel@conectiva.com.br, akpm@digeo.com, linux-kernel@vger.kernel.org,
       albert@users.sf.net
Subject: Re: 2.5.44 io accounting weirdness, bi & bo swapped?
Message-ID: <20021023124819.GA32421@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, riel@conectiva.com.br,
	akpm@digeo.com, linux-kernel@vger.kernel.org, albert@users.sf.net
References: <20021023121347.GA31763@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021023121347.GA31763@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 02:13:47PM +0200, bert hubert wrote:
> It appears as if the kernel does its accounting wrong in some places. For
> example, with procps 3.0.4, dd if=/dev/zero of=/mnt/100mb bs=1024
> count=100000 causes large 'bi' readings:

My bad. In this case, what I thought of as sane:

> However, mmapping a file and touching 100mb of pages does the following,
> which looks sane:
> 
>  r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
>  1  0  1  14320   7972   1952 146560    0    0     0  1912 1279   277  2 53 45

Is not. Touching a page entails reading it. In Albert's procps with 2.5.44,
bi and bo are reversed. Rik's vmstat does report things correctly.

Because I saw vmstat sometimes being right and sometimes being wrong, I
derived that is was the kernel that was at fault.

Perhaps Albert's procps isn't ready for 2.5.44?

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
