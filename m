Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264455AbSIQSfc>; Tue, 17 Sep 2002 14:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264479AbSIQSfc>; Tue, 17 Sep 2002 14:35:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38155 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264455AbSIQSfb>;
	Tue, 17 Sep 2002 14:35:31 -0400
Message-ID: <3D8776FF.3050504@mandrakesoft.com>
Date: Tue, 17 Sep 2002 14:39:59 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RESEND] Cleanup (BIN|BCD)_TO_(BCD|BIN) usage/macros
References: <20020917182950.GA726@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> Right now there's a bit of a mess with all of the BIN_TO_BCD/BCD_TO_BIN
> macros in the kernel.  It's defined in a half dozen places, and worse
> yet, not all places use them the same way.  Most users do something
> like:
> if ( ... )
>    BIN_TO_BCD(x);
> 
> But in a few places, it's used as:
> if ( ... )
>    y = BIN_TO_BCD(x);
> 
> The following creates include/linux/bcd.h which has the 'normal'
> BIN_TO_BCD macros, as well as CONVERT_{BIN,BCD}_TO_{BCD,BIN},
> which are for the second case.


hmmm... removing all the private definitions certainly makes good sense, 
but having both CONVERT_foo and foo seems a bit wonky...

IMO it would be better to have BIN_TO_BCD which returns a value, and 
__BIN_TO_BCD which has side effects but returns no value...

	Jeff



