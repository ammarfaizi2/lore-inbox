Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286188AbSBCGaI>; Sun, 3 Feb 2002 01:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286207AbSBCG35>; Sun, 3 Feb 2002 01:29:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20240 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286188AbSBCG3n>;
	Sun, 3 Feb 2002 01:29:43 -0500
Message-ID: <3C5CD8A2.697F5F2A@zip.com.au>
Date: Sat, 02 Feb 2002 22:28:50 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: Manuel McLure <manuel@mclure.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 Oops when trying to mount ATAPI CDROM
In-Reply-To: <20020202170244.A12338@ulthar.internal> <Pine.LNX.4.10.10202021715180.26613-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> Manuel,
> 
> Would you be kind enough to be a little more specific on the hardware?
> The attached devices bu make model and real vender if known.
> 
>

There are eight different config_drive_xfer_rate() functions.
And they all basically do this:

	if (id && ...) {
		...
	} else if (id->xxx)

So either

1: The first test for id=NULL is unneeded or

2: id can sometimes be null, which will oops in the way
   Manuel describes.

-
