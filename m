Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319074AbSHFMNY>; Tue, 6 Aug 2002 08:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319076AbSHFMNY>; Tue, 6 Aug 2002 08:13:24 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:40697 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319074AbSHFMNX>; Tue, 6 Aug 2002 08:13:23 -0400
Subject: Re: weird padding in linux/timex.h, struct timex
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Muli Ben-Yehuda <mulix@actcom.co.il>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020806111549.GL29139@alhambra.actcom.co.il>
References: <20020806111549.GL29139@alhambra.actcom.co.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 14:36:04 +0100
Message-Id: <1028640964.18130.145.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-06 at 12:15, Muli Ben-Yehuda wrote:
> Hi, 
> 
> struct timex in include/linux/timex.h is defined as 
> 
> struct timex 
> {
> 	...
> 	int  :32; int  :32; int  :32; int  :32;
> 	int  :32; int  :32; int  :32; int  :32;
> 	int  :32; int  :32; int  :32; int  :32;
> }; 
> 
> I assume that this is used as padding. Is there any reason for using
> bitfields as padding? If there is, a comment to that effect would be
> nice. If there isn't, the following patch makes the padding explicit. 
> 

That is how the interface has always been defined. I think we inherited
that from the world of xntpd but I may be wrong. Your __pad is not
always the same thing - you assume 4 byte ints and ints aligned the same
way as char [], which may not always be true.


