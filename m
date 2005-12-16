Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVLPGGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVLPGGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 01:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVLPGGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 01:06:20 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:7286 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932143AbVLPGGT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 01:06:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H4SY6mFtfhuNK38BYPU6Qq64sTCAtgiVQHWFOEM0yolFgdR+FdqiLb4SmhHEtCjWX7dGRF3RwUqquQgKytpPIT/nL/e1pXqv8Jg7cgJa4AG1nWuL3zrBms0d7ywhb3bCkG/cMkdtu0LCwBXXmTA9D8N4rIY12MxvYhS+/Bp9lZI=
Message-ID: <4807377b0512152206l32ac2627t48a4e0881e1790ae@mail.gmail.com>
Date: Thu, 15 Dec 2005 22:06:18 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Help track a memory leak in 2.6.0..14
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dnqp0b$96k$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43954489.5040309@thinrope.net>
	 <1133856214.2858.13.camel@laptopd505.fenrus.org>
	 <dnqp0b$96k$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, Kalin KOZHUHAROV <kalin@thinrope.net> wrote:
<snip>
> According to slabtop:
>  Active / Total Objects (% used)    : 1806688 / 1826914 (98.9%)
>  Active / Total Slabs (% used)      : 36958 / 36958 (100.0%)
>  Active / Total Caches (% used)     : 64 / 106 (60.4%)
>  Active / Total Size (% used)       : 138777.10K / 143195.01K (96.9%)
>  Minimum / Average / Maximum Object : 0.02K / 0.08K / 128.00K
>
>   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> 1768936 1768884  99%    0.07K  34018       52    136072K size-64
>  19642  16616  84%    0.06K    322       61      1288K buffer_head
>  10152   4828  47%    0.14K    376       27      1504K dentry_cache
>
> ss ~ # cat /proc/slabinfo |grep "size-64 "
> size-64           1767932 1768000     76   52    1 : tunables   32   16    0 : slabdata  33999
> 34000      0 : globalstat 21513120 1767964 34005    0    0    1   84    0 : cpustat 614583639
> 1370079 612951759 1234047
>
> ss ~ # lsmod
> Module                  Size  Used by
> nfs                   114540  1
> lockd                  66920  2 nfs
> nfs_acl                 3680  1 nfs
> sunrpc                152004  4 nfs,lockd,nfs_acl
> usbhid                 27876  0
> yenta_socket           26028  2
> rsrc_nonstatic         14112  1 yenta_socket
> ehci_hcd               33224  0
> ohci_hcd               21988  0
> usbcore               125660  4 usbhid,ehci_hcd,ohci_hcd
> e100                   37984  0
> mii                     5568  1 e100

<snip>

size-64 is pretty tiny, and I don't think e100 makes any allocations
that tiny, so you should be able to eliminate e100.  If you try an
older kernel and it works you might be able to get an idea of where
changes have been made to start looking for kmallocs of size <= 64
bytes

your unloading module case is a bit of a misnomer because the item
that leaked may not know it leaked and therefore could unload without
freeing the things it leaked.

I'm not sure how to help you from here, have you tried a kernel.org
kernel like 2.6.14.3?  You're likely to get more help from here if you
do.

Jesse
