Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbTIJMxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 08:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbTIJMxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 08:53:13 -0400
Received: from tench.street-vision.com ([212.18.235.100]:49044 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S262967AbTIJMxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 08:53:03 -0400
Subject: Re: [2.4] siimage locks hard on high load
From: Justin Cormack <justin@street-vision.com>
To: Witold Krecicki <adasi@kernel.pl>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200309121344.43573.adasi@kernel.pl>
References: <200309121344.43573.adasi@kernel.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 10 Sep 2003 13:52:38 +0100
Message-Id: <1063198360.313.54.camel@lotte.street-vision.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-12 at 12:44, Witold Krecicki wrote:
> I've got Asus a7n8x deluxe with on-board Silicon Image SATA and 2xBarracuda 
> 120GB connected to it in software RAID array.
> On high disk load (e.g. cp -Rf /usr/src/linux somewhere_else) kernel locks 
> hard after about 10 seconds (magic sysrq is not working).
> It happens only when DMA is enabled. 
> /dev/hda:
>  multcount    = 16 (on)
>  IO_support   =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 16 (on)
>  geometry     = 14593/255/63, sectors = 234441648, start = 0
> 
> Also, I'm not really satisfied with speed of this array:
> /dev/md1:
>  Timing buffered disk reads:  64 MB in  1.77 seconds = 36.16 MB/sec
> Any solutions/fixes?

Cant help you on the lockups (I havent seen this myself), but the
performance is due to the workaround that sets max_kb_per_request to 15
for siimage. On some drives (Western digital, maxtor) this only cuts the
performance by 10-15MB/s or so but on the Seagates it completely trashes
performance (you can easily test this but you may get data
corruption...).

A proper bug fix rather than a workaround would be nice (unless this
isnt possible). Are the docs for this chipset actually available and is
a bug fix possible? (Alan/Andre should know).

Justin


