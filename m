Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279698AbRJYEEU>; Thu, 25 Oct 2001 00:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279699AbRJYEEL>; Thu, 25 Oct 2001 00:04:11 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:64005 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S279698AbRJYEDw>;
	Thu, 25 Oct 2001 00:03:52 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200110250404.f9P44KM162546@saturn.cs.uml.edu>
Subject: Re: Allocating more than 890MB in the kernel?
To: ttabi@interactivesi.com (Timur Tabi)
Date: Thu, 25 Oct 2001 00:04:20 -0400 (EDT)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <3BD08B57.1070604@interactivesi.com> from "Timur Tabi" at Oct 19, 2001 03:21:43 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I need to allocate about 3/4 of available memory in the kernel. 
> If I had 2GB of RAM, I'd need to allocate 1.5GB.  If I had 8 GB
> of RAM, I'd need to allocate 6GB.  I just used 3GB/4GB because
> it's our current test platform.

The best you can do, IMHO:

1. reserve a 3 GB chunk of memory at boot
2. create a regular user process
3. have that process make a system call which will never return
4. in that system call, wipe out all memory mappings in the process
5. hand-craft a 3 GB memory mapping (0 GB virt --> 1 GB phys)
6. call your desired code, remembering to schedule by hand


