Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbUDXTgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUDXTgA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 15:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUDXTgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 15:36:00 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:6416 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261728AbUDXTf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 15:35:58 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Roland Dreier <roland@topspin.com>
Subject: Re: Si3112 S-ATA bug preventing use of udma5.
Date: Sat, 24 Apr 2004 22:35:40 +0300
User-Agent: KMail/1.5.4
Cc: Brenden Matthews <brenden@rty.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <42822.68.144.162.3.1082757748.squirrel@webmail.rty.ca> <52ad12qf8u.fsf@topspin.com> <1082781068.10628.51.camel@gaston>
In-Reply-To: <1082781068.10628.51.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404242235.40640.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 April 2004 07:31, Benjamin Herrenschmidt wrote:
> On Sat, 2004-04-24 at 12:30, Roland Dreier wrote:
> > Finally, siimage.c does
> >
> >                 hwif->OUTW(speedt, addr);
> >
> > and speedt is a u32 -- however, as you say, the compiler should just
> > cast speedt down to a u16.  What am I missing?
>
> This is just a normal function call, there should be nothing special,
> so either you are missing something else or you are suffering from
> incorrectly compiled code... I'm no x86 expert so I can't help
> analyzing the codegen here though.

place a pair of bogus calls:

void marker(void);
....
	marker();
	hwif->OUTW(speedt, addr);
	marker();
...

and objdump -d resulting .o file.
It will be easy to find corresponding asm fragment.
--
vda

