Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279028AbRKAOgx>; Thu, 1 Nov 2001 09:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279029AbRKAOgn>; Thu, 1 Nov 2001 09:36:43 -0500
Received: from [195.66.192.167] ([195.66.192.167]:23819 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S279018AbRKAOg3>; Thu, 1 Nov 2001 09:36:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Tim Schmielau <tim@physik3.uni-rostock.de>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
Date: Thu, 1 Nov 2001 16:35:52 +0000
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>, J Sloan <jjs@lexus.com>
In-Reply-To: <Pine.LNX.4.30.0111010144570.31417-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.30.0111010144570.31417-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Message-Id: <01110116355201.01137@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 November 2001 00:52, Tim Schmielau wrote:

> OK, absolutely last patch for today. Sorry to bother everyone, but the
> jiffies wraparound logic was broken in the previous patch.
>
> As stated before, I would kindly ask for widespread testing PROVIDED IT IS
> OK FOR YOU TO RISK THE STABILITY OF YOUR BOX!

I see you dropped jiffies_hi update in timer int.
IMHO argument on wasting 6 CPU cycles or so per each timer int:

-	jiffies++;
+	if(++jiffies==0) jiffies_hi++;

is not justified. I'd rather see simple and correct code in timer int
rather than jumping thru the hoops in get_jiffies_64().

For CPU cycle saving zealots: I advocate saving 2 static longs in get_jiffies
instead :-)
--
vda
