Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbVL1IzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVL1IzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 03:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVL1IzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 03:55:05 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:37097 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932519AbVL1IzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 03:55:02 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Date: Wed, 28 Dec 2005 10:54:26 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <43A91C57.20102@cosmosbay.com> <200512281032.15460.vda@ilport.com.ua>
In-Reply-To: <200512281032.15460.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512281054.26703.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 December 2005 10:32, Denis Vlasenko wrote:
> On Wednesday 21 December 2005 11:11, Eric Dumazet wrote:
> > I wonder if the 32 and 192 bytes caches are worth to be declared in 
> > include/linux/kmalloc_sizes.h, at least on x86_64
> > 
> > (x86_64 : PAGE_SIZE = 4096, L1_CACHE_BYTES = 64)
> > 
> > On my machines, I can say that the 32 and 192 sizes could be avoided in favor 
> > in spending less cpu cycles in __find_general_cachep()
> > 
> > Could some of you post the result of the following command on your machines :
> > 
> > # grep "size-" /proc/slabinfo |grep -v DMA|cut -c1-40
> > 
> > size-131072            0      0 131072
> > size-65536             0      0  65536
> > size-32768             2      2  32768
> > size-16384             0      0  16384
> > size-8192             13     13   8192
> > size-4096            161    161   4096
> > size-2048          40564  42976   2048
> > size-1024            681    800   1024
> > size-512           19792  37168    512
> > size-256              81    105    256
> > size-192            1218   1280    192
> > size-64            31278  86907     64
> > size-128            5457  10380    128
> > size-32              594    784     32
> 
> # grep "size-" /proc/slabinfo |grep -v DMA|cut -c1-40
> size-131072            0      0 131072
> size-65536             0      0  65536
> size-32768             1      1  32768
> size-16384             0      0  16384
> size-8192            253    253   8192
> size-4096             89     89   4096
> size-2048            248    248   2048
> size-1024            312    312   1024
> size-512             545    648    512
> size-256             213    270    256
> size-128            5642   5642    128
> size-64             1025   1586     64
> size-32             2262   7854     32

Wow... I overlooked that you are requesting data from x86_64 boxes.
Mine is not, it's i386...
--
vda
