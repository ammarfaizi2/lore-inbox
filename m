Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932102AbWFDGah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWFDGah (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 02:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWFDGah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 02:30:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27290
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932102AbWFDGag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 02:30:36 -0400
Date: Sat, 03 Jun 2006 23:30:34 -0700 (PDT)
Message-Id: <20060603.233034.59468148.davem@davemloft.net>
To: hpa@zytor.com
Cc: maks@sternwelten.at, linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: Re: [PATCH] klibc
From: David Miller <davem@davemloft.net>
In-Reply-To: <44820C7D.6080501@zytor.com>
References: <20060602081416.GA11358@nancy>
	<44820C7D.6080501@zytor.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@zytor.com>
Date: Sat, 03 Jun 2006 15:26:05 -0700

> __arch64__ is ugly; it doesn't say it's a sparc thing.  I have added 
> -D__sparc_v9__ to the sparc64 MCONFIG file, so I think that's fine.
> 
> Perhaps the right thing to do is to make this an archconfig.h configurable.

Please don't do this, I'll explain why.

Using __sparc_v9__ is incorrect, here is the lowdown on these defines:

1) __sparc_v9__ means "-mcpu={ultrasparc*,niagara}" or "-mcpu=v9".
   Although this is implied by "-m64" it can be used for 32-bit
   code too.

   __sparc_v9__ means "using v9 instructions" which does not
   necessarily mean 64-bit

2) "__sparc__ && __arch64__" means 64-bit sparc

People often get this wrong, and it certainly is confusing.

Jakub Jelinek gives a good explanation on the gcc mailing
list here:

	http://gcc.gnu.org/ml/gcc/2002-12/msg00108.html

Thanks.
