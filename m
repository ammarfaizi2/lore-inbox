Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTDVINR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 04:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbTDVINQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 04:13:16 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:42198 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262993AbTDVINP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 04:13:15 -0400
Message-ID: <3EA4FC56.3070407@shemesh.biz>
Date: Tue, 22 Apr 2003 11:24:54 +0300
From: Shachar Shemesh <lkml@shemesh.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en, he
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new system call mknod64
References: <UTC200304212143.h3LLh6e02148.aeb@smtp.cwi.nl> <b81tan$637$1@cesium.transmeta.com> <20030421235009.GC17595@mail.jlokier.co.uk>
In-Reply-To: <20030421235009.GC17595@mail.jlokier.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>It varies very much between architectures.
>
>I just checked, and simple copies of this structure are absolutely
>atrocious in GCC 3.2 (I tried Alpha, Mips64 and Sparc64).  The code
>was approx. 3 times longer to copy the 32:32 struct than to copy a 64
>bit scalar.
>  
>
Last time I had access to gcc on sparc, copying a struct where the 
compiler guessed that non-aligned access may occure produced code that 
was guarenteed not to crash the program. This was tested in user mode, 
in 32 bit, but still...

Copying a struct with two 32 bit values does not prove to the compiler 
that it will be 64bit aligned. It is therefor reasonable for the 
compiler to assume it needs two 32 bit transfers, rather than one 64 bit 
transfer. Try adding "#pragme align 8", or whatever it is called, and 
seeing if this inefficiency goes away.

>On x86_64, the struct produces the same code as the scalar.
>The same is true on s390x.
>  
>
I don't know how x86_64 is doing, but x86 does not issue a bus error 
when unaligned value is being accessed. It is therefor reasonable for 
the compiler not to worry about it. If x86_64 is the same, the results 
you report seem like a reasonable feature of gcc, rather than a bug.

                Shachar

-- 
Shachar Shemesh
Open Source integration consultant
Home page & resume - http://www.shemesh.biz/


