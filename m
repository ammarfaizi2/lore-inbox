Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317148AbSHGKBs>; Wed, 7 Aug 2002 06:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSHGKBs>; Wed, 7 Aug 2002 06:01:48 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:56326 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S317148AbSHGKBr>; Wed, 7 Aug 2002 06:01:47 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15696.61666.452460.264138@laputa.namesys.com>
Date: Wed, 7 Aug 2002 14:05:22 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: kernel thread exit race
In-Reply-To: <1028719111.18156.227.camel@irongate.swansea.linux.org.uk>
References: <15696.59115.395706.489896@laputa.namesys.com>
	<1028719111.18156.227.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Tom-Swifty: "The printer is using too much toner," Tom said darkly.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > 
 > On Wed, 2002-08-07 at 10:22, Nikita Danilov wrote:
 > > Hello,
 > > 
 > > what is the politically correct way to exit from a kernel thread daemon
 > > without module unload races?
 > 
 > You probably want to use completions. There is a function in the kernel
 > core "complete_and_exit" which does both the complete() and then the
 > exit() so that after complete finishes the task will not re-enter
 > modulespace and risk an unload race
 > 

Ah I see, thank you and Russell. But this depends on no architecture
ever accessing spinlock data after letting waiters to run, otherwise
there still is (tiny) window for race at the end of complete() call,
right?

 > 

Nikita.
