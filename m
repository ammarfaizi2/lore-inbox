Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317828AbSGKLVG>; Thu, 11 Jul 2002 07:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317829AbSGKLVF>; Thu, 11 Jul 2002 07:21:05 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:34315 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317828AbSGKLVF>;
	Thu, 11 Jul 2002 07:21:05 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Albert Cranford <ac9410@bellsouth.net>
Date: Thu, 11 Jul 2002 13:23:08 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [patch] 2.5.25 I2C driver id and Config updates boundar
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <A966E820E25@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jul 02 at 1:26, Albert Cranford wrote:
> Hello Linus,
> Could you please apply these 3 patches toward 2.5.26.
> They include Config.in updates, additions in i2c-id.h
> for "Video for Linux" and a compatibility fix for
> i2c-algo-bit.c

Hi,
  is timeout field in i2c_algo_bit_data supposed to be in jiffies
(like it is currently used) or in 10ms units? If it is supposed
to be in jiffies (other algos do not care about timeout field),
there is dozen of places (all callers of i2c_bit_add_bus) which
get it wrong.

  Next suspicious thing is that 'timeout' field from i2c_adapter
structure is not used at all - only i2c_control is willing to
set it, but nobody reads this field. Should not i2c_bit_add_bus
copy its timeout into this field, and then use adap->timeout instead
of bitadap->timeout in its sclhi() procedure?
                                        Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
