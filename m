Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290658AbSBFQi7>; Wed, 6 Feb 2002 11:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290664AbSBFQit>; Wed, 6 Feb 2002 11:38:49 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:14985 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S290658AbSBFQii>; Wed, 6 Feb 2002 11:38:38 -0500
Message-ID: <3C615AAA.2050608@antefacto.com>
Date: Wed, 06 Feb 2002 16:32:42 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Rohland <cr@sap.com>,
        Andries.Brouwer@cwi.nl, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <Pine.LNX.4.33L2.0202060758340.18426-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Wed, 6 Feb 2002, Alan Cox wrote:
> 
> | > > If you are going to cat it onto the end of the kernel image just
> | > > mark it __initdata and shove a known symbol name on it. It'll get
> | > > dumped out of memory and you can find it trivially by using tools on
> | > > the binary
> | >
> | > What about putting such info into a (swappable) tmpfs file with
> | > shmem_file_setup?
> |
> | That is indeed an extremely cunning plan. Paticularly as /proc/config can
> | be a symlink to it
> | -
> 
> I still prefer your suggestion to append it to the kernel image
> as __initdata so that it's discarded from memory but can be
> read with some tool(s).
> 
> 

I aggree. You shouldn't need the kernel running to be able
to read it's config settings from it. You could do the
equivalent of the following at the end of the build.

<.config sed -e '/^#/d' -e '/^[    ]*$/d' | gzip -9 >> image

The sed scripts strip comments and blank lines.

Padraig.

