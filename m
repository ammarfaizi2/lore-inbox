Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbSJPXRc>; Wed, 16 Oct 2002 19:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbSJPXRb>; Wed, 16 Oct 2002 19:17:31 -0400
Received: from marcie.netcarrier.net ([216.178.72.21]:39185 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S261501AbSJPXRb>; Wed, 16 Oct 2002 19:17:31 -0400
Message-ID: <3DADF607.4B83C107@compuserve.com>
Date: Wed, 16 Oct 2002 19:28:07 -0400
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.43] (DAC960 compile failure)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>  looking at that i realise that DAC960 code in 2.5.43
> is not supposed to be tested:
> ======
> #error I am a non-portable driver, please convert me to use the Documentation/DMA-mapping.txt interfaces
> ======
>  am i right?
> 
> the following weirdo appears in both gcc-3.1 and 3.2 (also in 2.5.42)
> ======
> drivers/block/DAC960.c: In function `DAC960_DetectControllers':
> drivers/block/DAC960.c:2465: `Controller' undeclared (first use in this function)
> drivers/block/DAC960.c:2465: (Each undeclared identifier is reported only once
> drivers/block/DAC960.c:2465: for each function it appears in.)
> 

Yes, 2.5.42 did this also.  It looks like gcc 3.2 doesn't like goto's
which reference variables outside their native scope.  You can move the
Controller definition to full function scope to fix that error.

The DAC960 doesn't seem usable out of the stock kernel build though. 
You'll need to try patches previously posted to the list.  (Which don't
fully work for me either...)

-- 
Kevin
