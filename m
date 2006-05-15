Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWEOPNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWEOPNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWEOPNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:13:23 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:5332 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S964971AbWEOPNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:13:21 -0400
Message-ID: <44689A54.4020307@ru.mvista.com>
Date: Mon, 15 May 2006 19:12:20 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Assorted bugs in the PIIX drivers
References: <1132929808.3298.18.camel@localhost.localdomain>
In-Reply-To: <1132929808.3298.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:
> I finally got all the documents rounded up to try and redo Jgarzik's
> PIIX driver a bit more completely (I'm short MPIIX if anyone has it ?)
>
> I then started reading the docs and the code and noticing a couple of
> problems

> 1.	We set IE1 on PIO0-2 which the docs say is for PIO3+

    For PIO2+ actually, according to Intel's PRM (29860004.pdf), and it's said
to have no effect in the lower modes. This is actually not very correct since
when one issues Set Transfer Mode ATA command with the value (8 + PIOn), this
means select PIO _flow control_ mode n, so -IORDY is assumed to be in use.

> I'm also not clear if the "no MWDMA0" list has been updated correctly
> for the newer chipsets.

    What is/was the point for keeping MW DMA 0 support anyway? On PIIX, it's
greatly slowed down (600 vs 480 ns cycle) and was never "offically" supported
by Intel.

MBR, Sergei


