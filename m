Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVGJPYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVGJPYc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 11:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVGJPYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 11:24:32 -0400
Received: from mx2.elte.hu ([157.181.151.9]:27292 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261957AbVGJPYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 11:24:31 -0400
Date: Sun, 10 Jul 2005 17:24:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjanv@infradead.org>, mlindner@syskonnect.de,
       rroesler@syskonnect.de,
       =?iso-8859-1?Q?Beno=EEt?= Dejean <benoit@placenet.org>
Subject: Re: [patch] reduce stack footprint of functions in drivers/net/sk98lin/skgepnmi.c
Message-ID: <20050710152406.GA29482@elte.hu>
References: <20050709140314.GA6786@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050709140314.GA6786@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> this patch reduces the stack footprint of Vpd() from 1018 bytes to 28 
> bytes, SkPnmiGetStruct() from 744 bytes to 92 bytes, GetVpdKeyArr() 
> from 552 bytes to 48 bytes, and General() from 364 bytes to 112 bytes.

Benoît Dejean noticed that these changes are incorrect, because the code 
deals with KeyArr as an array of strings (and a 2D array), while my 
changes turn it into a char **. This breaks code like:

        Ret = GetVpdKeyArr(pAC, IoC, &KeyArr[0][0], sizeof(KeyArr), &KeyNo);
...
                                if (SK_STRCMP(KeyStr, KeyArr[Index]) == 0) {
...

	Ingo
