Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264422AbUDZEwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbUDZEwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 00:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbUDZEwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 00:52:37 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:48902 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264422AbUDZEwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 00:52:35 -0400
Date: Mon, 26 Apr 2004 06:49:07 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Williams Parker <listas@medusa.homeunix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: speed interface ethernet 10/100Mbit/seg
Message-ID: <20040426044907.GP596@alpha.home.local>
References: <S262064AbUDYCEK/20040425020410Z+1117@vger.kernel.org> <20040426011101.GA1798@sakroot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040426011101.GA1798@sakroot.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

you can read several time the same file, it should be cached after the first
read if it can fit in memory (eg not more than a few hundreds megs).
You can also test your interface with FTP. On the client side, you should
send it to /dev/null to avoid disk I/O. :
ftp> bin
ftp> recv XXX /dev/null

and if you have netcat (nc), this is even easier : copy a large block of
zeroes on the network and time it :
server> dd if=/dev/zero bs=16k count=10000 | nc -lp4000
client> time nc server 4000 | wc -c
=> you'll read 160 MB, you divide by the number of 'real' seconds and it
gives you the number of megabytes per second on the network.

Regards,
Willy

On Mon, Apr 26, 2004 at 03:11:01AM +0200, Williams Parker wrote:
> Hello, i have troubles with speed in ethernet interface 
> 
> 
> i have probed with transfer of files in samba to windows
> 
> speed max 1,44Mbytes/sec and it have about 8Mbytes/sec
> 
> 
> 
> info my hardisk
> 
> 
> hdparm -t /dev/hdc
> 
> /dev/hdc:
>  Timing buffered disk reads:   34 MB in  3.04 seconds =  11.18 MB/sec
> 
>  ok it´s mdma2 
> 
> 
>  while i send archivos it low to 4,20Mbytes/sec  --->
> 
> 
>  hdparm -t /dev/hdc
> 
>  /dev/hdc:
>   Timing buffered disk reads:   14 MB in  3.10 seconds =   4.52 MB/sec
> 
> 
> 
>   why do it send to 7 or 8Mbytes/sec ???
> 
>   howto probe max speed??
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
