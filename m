Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWAPUil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWAPUil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWAPUil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:38:41 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:47375 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750992AbWAPUik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:38:40 -0500
Date: Mon, 16 Jan 2006 21:39:17 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: [patch 2.6.15-mm4] sem2mutex: I2C, #2
Message-Id: <20060116213917.361e40f6.khali@linux-fr.org>
In-Reply-To: <20060114162527.GA4822@elte.hu>
References: <20060114162527.GA4822@elte.hu>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

> semaphore to mutex conversion.
> 
> the conversion was generated via scripts, and the result was validated
> automatically via a script as well.
> 
> build tested.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ----
> 
>  drivers/i2c/busses/i2c-amd756-s4882.c |   14 ++++++-----
>  drivers/i2c/busses/i2c-isa.c          |    2 -
>  drivers/i2c/chips/eeprom.c            |    9 +++----
>  drivers/i2c/chips/max6875.c           |   10 +++----
>  drivers/i2c/chips/pcf8591.c           |   13 +++++-----
>  drivers/i2c/chips/tps65010.c          |   43 +++++++++++++++++-----------------
>  drivers/i2c/i2c-core.c                |   34 +++++++++++++-------------
>  include/linux/i2c.h                   |    6 ++--
>  8 files changed, 68 insertions(+), 63 deletions(-)

drivers/i2c/chips/tps65010.c looks broken to me: you updated every use
of the lock, but the structure itself is still declared as a semaphore.
I'll fix it up.

Also, any reason why drivers/i2c/busses/scx200_acb.c was not converted?
I'll convert it unless you had a specific reason no to.

Thanks,
-- 
Jean Delvare
