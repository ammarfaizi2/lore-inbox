Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316252AbSEKSRp>; Sat, 11 May 2002 14:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316253AbSEKSRo>; Sat, 11 May 2002 14:17:44 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:23570 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316252AbSEKSRn>; Sat, 11 May 2002 14:17:43 -0400
Message-Id: <200205111815.g4BIF0Y02586@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [PATCH] 1/6: 64 bit jiffies
Date: Sat, 11 May 2002 21:18:04 -0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0205111224180.26626-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 May 2002 08:25, Tim Schmielau wrote:
> +static inline void init_jiffieswrap_timer(void)
> +{
> +	init_timer(&jiffieswrap_timer);
> +	jiffieswrap_timer.expires = jiffies + CHECK_JIFFIESWRAP_INTERVAL;
> +	jiffieswrap_timer.function = check_jiffieswrap;
> +	add_timer(&jiffieswrap_timer);
> +}

I'm ignorant on the issue... does active timer mandate check for
expiration at every timer tick? If yes, it is somewhat silly to use timer:
such check would be more costly than
	
	if(!++jiffies) jiffies_hi++;

(or similar) construct in timer int.

BTW, I always liked above thing more that any other 64 jiffy solution.
What's wrong with it?
--
vda
