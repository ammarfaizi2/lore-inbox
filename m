Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVCTMn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVCTMn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 07:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVCTMn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 07:43:27 -0500
Received: from mail.dif.dk ([193.138.115.101]:38572 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261195AbVCTMnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 07:43:19 -0500
Date: Sun, 20 Mar 2005 13:44:59 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Short sleep precision
In-Reply-To: <Pine.LNX.4.61.0503201316320.18044@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.62.0503201335420.2501@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.61.0503201316320.18044@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2005, Jan Engelhardt wrote:

> Hello,
> 
> 
> I have found that FreeBSD has a very good precision of small sleeps --
> what's holding Linux back from doing the same? Using the code snippet below, 
> FBSD yields between 2 and 80 us on the average while Linux is at 
> "constantly" ~100 (with HZ=1000) and ~1000 (HZ=100).
> 
Running your program here I see even worse values than that on 2.6.11-mm4 
and it's also interresting to see that for a lot of continuous runs the 
values reported drop steadily and eventually settle around ~1100, but if I 
insert a  sleep 1  between runs, then I see a steady ~1000 reported.
This is all with HZ = 1000


juhl@dragon:~/download/kernel/linux-2.6.11-mm4$ for i in `seq 1 40`; do ./a.out ; done
 1414 us
 1434 us
 1423 us
 1424 us
 1433 us
 1423 us
 1420 us
 1439 us
 1434 us
 1433 us
 1463 us
 1462 us
 1450 us
 1431 us
 1403 us
 1391 us
 1376 us
 1364 us
 1362 us
 1344 us
 1353 us
 1353 us
 1334 us
 1323 us
 1313 us
 1314 us
 1293 us
 1293 us
 1273 us
 1274 us
 1271 us
 1264 us
 1264 us
 1244 us
 1244 us
 1214 us
 1214 us
 1214 us
 1183 us
 1183 us

juhl@dragon:~/download/kernel/linux-2.6.11-mm4$ for i in `seq 1 10`; do (./a.out ; sleep 1) ; done
 1113 us
 997 us
 997 us
 998 us
 997 us
 997 us
 996 us
 997 us
 996 us
 996 us


