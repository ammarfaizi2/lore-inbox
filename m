Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278653AbRJSUcy>; Fri, 19 Oct 2001 16:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278655AbRJSUcp>; Fri, 19 Oct 2001 16:32:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44043 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278653AbRJSUc2>; Fri, 19 Oct 2001 16:32:28 -0400
Message-ID: <3BD08DE4.2020500@zytor.com>
Date: Fri, 19 Oct 2001 13:32:36 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Timur Tabi <ttabi@interactivesi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Allocating more than 890MB in the kernel?
In-Reply-To: <Pine.LNX.4.30.0110191204210.21846-100000@hill.cs.ucr.edu> <3BD08207.7090807@interactivesi.com> <9qq0mo$eun$1@cesium.transmeta.com> <3BD08B57.1070604@interactivesi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:

> 
> That's completely missing the point of my request (which, I admit, I
> didn't make clear).  I need to allocate about 3/4 of available memory in
> the kernel.  If I had 2GB of RAM, I'd need to allocate 1.5GB.  If I had
> 8 GB of RAM, I'd need to allocate 6GB.  I just used 3GB/4GB because it's
> our current test platform.
> 


There is no way you can allocate 6 GB of address space when you have 4 GB
to dole out -- and that includes to userspace.  Linux tends to allocate
most of the address space (usually 3 GB) to userspace, because it can be
re-used between processes and it matches the needs of more users.

This puts fundamental limits on how much space is addressible in the
kernel.  What you can do if your application permits is allocate HIGHMEM
pages, and use kmap()/kmap_atomic()/kunmap() to selectively bring them
into the address space on an as-need basis.  THIS IS EXPENSIVE, have no
illusions about it, and doesn't give you space that is contiguous in
either linear nor physical space.

Obviously, on a 64-bit CPU these limitations utterly vanish, since address
space is no longer limited.

	-hpa



