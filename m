Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282436AbRKZTml>; Mon, 26 Nov 2001 14:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282430AbRKZTmf>; Mon, 26 Nov 2001 14:42:35 -0500
Received: from mta23-acc.tin.it ([212.216.176.76]:53705 "EHLO fep23-svc.tin.it")
	by vger.kernel.org with ESMTP id <S282436AbRKZTmA>;
	Mon, 26 Nov 2001 14:42:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Flavio Stanchina <flavio.stanchina@tin.it>
Organization: not at all
To: "David C. Hansen" <haveblue@us.ibm.com>
Subject: Re: [PATCH] Remove needless BKL from release functions
Date: Mon, 26 Nov 2001 20:41:52 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200111231047.fANAlA105874@ns.caldera.de> <3C028008.6000605@us.ibm.com>
In-Reply-To: <3C028008.6000605@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011126194153.MIQN11444.fep23-svc.tin.it@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 November 2001 18:46, David C. Hansen wrote:

> In the patch, in the open function, you do this:
>     if (handler)
>         new_fops = fops_get(handler->fops);
>
> But, the fops_get() #define already cheecks to make sure handler isn't
> null: #define fops_get(fops) \
>         (((fops) && (fops)->owner)      \
>                 ? ( try_inc_mod_count((fops)->owner) ? (fops) : NULL ) \
>                 : (fops))

Look closer, it doesn't check 'handler' (it couldn't).

-- 
Ciao,
    Flavio Stanchina
    Trento - Italy

"The best defense against logic is ignorance."
http://spazioweb.inwind.it/fstanchina/
