Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132886AbRDWRLP>; Mon, 23 Apr 2001 13:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133108AbRDWRLF>; Mon, 23 Apr 2001 13:11:05 -0400
Received: from [195.224.53.219] ([195.224.53.219]:4228 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S132886AbRDWRK7>;
	Mon, 23 Apr 2001 13:10:59 -0400
Date: Mon, 23 Apr 2001 17:40:03 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>, Matt <madmatt@bits.bris.ac.uk>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: ioctl arg passing
Message-ID: <1233833238.988047603@[192.168.199.16]>
In-Reply-To: <EE31127966@vcnet.vc.cvut.cz>
In-Reply-To: <EE31127966@vcnet.vc.cvut.cz>
X-Mailer: Mulberry/2.1.0a3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And there is very low chance that kmalloc() for
> anything bigger than 4KB will succeed. You should either use
> vmalloc unconditionally, or at least as fallback.

The phrase 'very low chance' is inaccurate.

How do you think NFS works with -rsize, -wsize > 4096?
kmalloc() uses get_free_pages() to allocate
more than one physically contiguous memory
page, which in turn uses a sort of modified
buddy system to distribute them. And if you
specify the right GFP_ flags, will page out,
if necessary, to do so. (I know the hard way
as this is the one substantial thing I fixed
in the linux kernel just after 1.0 in about 95).

If you need physically (as opposed to virtially)
contiguous memory, unless lots has changed since then,
kmalloc() is the right call. However, you are
correct that it draws on scarce resources.

--
Alex Bligh
