Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289230AbSAGPhK>; Mon, 7 Jan 2002 10:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289225AbSAGPhA>; Mon, 7 Jan 2002 10:37:00 -0500
Received: from gw.chygwyn.com ([62.172.158.50]:9230 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S289230AbSAGPgo>;
	Mon, 7 Jan 2002 10:36:44 -0500
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200201071538.PAA28211@gw.chygwyn.com>
Subject: Re: nbd request too big
To: robalomarquesl@yahoo.com (=?iso-8859-1?q?Luc=20Robalo=20Marques?=)
Date: Mon, 7 Jan 2002 15:38:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020107152423.78321.qmail@web14906.mail.yahoo.com> from "=?iso-8859-1?q?Luc=20Robalo=20Marques?=" at Jan 07, 2002 04:24:23 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I presume you are using Pavel's server from his web page ? You need to increase
the buffer size that the server uses. This happens as a result of the change
a little while ago of nbd to use the elevator to merge requests at the nbd
client end. If memory serves the maximum size of request is sizeof(header) +
128 * block_size, so you need to alter the server to use that size.

You'll find the buffer size in the main loop of the mainloop() function
char buf[20480]; needs increasing (to (131072 + 28) for 1k blocks for example)
and also you'll need to increase the value here (to 131072 in this example):

                if (len > 10240)
                        err("Request too big!");

Then it should work fine.

Steve.

> 
> hi,
> 
> i would like to setup a nbd but when I try to mke2fs
> the device on the client side, the connection hangs
> and /log/messages contains a entry for mthe server
> telling that the request was too big.
> Any idea what caused it.
> 
> Thanks you
> 
> Luc robalo Marques
> 
> ___________________________________________________________
> Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
> Yahoo! Courrier : http://courrier.yahoo.fr
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

