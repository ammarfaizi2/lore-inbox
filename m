Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271802AbRIEHwz>; Wed, 5 Sep 2001 03:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271825AbRIEHwo>; Wed, 5 Sep 2001 03:52:44 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:19716 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S271802AbRIEHwh>; Wed, 5 Sep 2001 03:52:37 -0400
Message-ID: <3B95D97A.DB82E0C4@idb.hist.no>
Date: Wed, 05 Sep 2001 09:51:22 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.10-pre4 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Sebastian Heidl <heidl@zib.de>, linux-kernel@vger.kernel.org
Subject: Re: DMA to/from user buffers
In-Reply-To: <20010904164509.A27144@csr-pc1.zib.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Heidl wrote:
> 
> Hi,
> 
> two questions about using an user-supplied buffer (e.g. malloced
> in user space) for DMA transfers:
> 
> 1. Is it possible ?
> 2. What restrictions/requirements apply for the buffer (alignment...) ?

There are some obvious problems with this.  First, a malloc'ed
buffer might not be in memory.  It might not be created yet if you
haven't touched it, and it might be on swap if you have.  

The recommended way is to allocate in the kernel, (probably by
the driver that want to do DMA), and mmap this buffer into
userspace.  

Helge Hafting
