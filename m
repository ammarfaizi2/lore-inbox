Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRAXUme>; Wed, 24 Jan 2001 15:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRAXUmZ>; Wed, 24 Jan 2001 15:42:25 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:5718 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S129763AbRAXUmI>;
	Wed, 24 Jan 2001 15:42:08 -0500
Message-ID: <3A6F3E05.4090409@valinux.com>
Date: Wed, 24 Jan 2001 13:41:41 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Timur Tabi <ttabi@interactivesi.com>
CC: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
        Linux MM mailing list <linux-mm@kvack.org>
Subject: Re: Page Attribute Table (PAT) support?
In-Reply-To: <20010124174824Z129401-18594+948@vger.kernel.org> <20010124203012Z129444-18594+1042@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:

> ** Reply to message from Jeff Hartmann <jhartmann@valinux.com> on Wed, 24 Jan
> 2001 11:45:43 -0700
> 
> 
> 
>> I'm actually writing support for the PAT as we speak.  I already have 
>> working code for PAT setup.  Just having a parameter for ioremap is not 
>> enough, unfortunately.  According to the Intel Architecture Software 
>> Developer's Manual we have to remove all mappings of the page that are 
>> cached.
> 
> 
> For our specific purposes, that's not important.  We already flush the cache
> before we create uncached regions (via ioremap_nocache).  I understand that as a
> general Linux feature, you can't ignore cache incoherency, but I don't think
> it's a hard requirement.

Actually you can't ignore it or the processor will have a heart attack 
if the cached page mapping is used even speculatively.  I've done some 
experimenting, if the page is mapped cached in one place, and UCWC in 
another, things will not work.  Its extremely likely the processor will 
cease to function.  Its not like having cached and uncached mappings of 
a page (which does work on the Intel processors, we use that feature in 
the agpgart and the DRM in fact.)  When you mark a page UCWC, you better 
have removed all cached mappings or your asking for REAL trouble.

-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
