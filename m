Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbVHXMnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVHXMnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 08:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVHXMnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 08:43:50 -0400
Received: from web25807.mail.ukl.yahoo.com ([217.12.10.192]:51561 "HELO
	web25807.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750906AbVHXMnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 08:43:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=s35LRB+btr0wk246YXBZ6gJv1v0Bsk8GUn+JOqjJY3QbG+HNYwqWORGxnO3yFRyE7tc9IvIqA3xR140CX6dctoVw1S5KHjUMhP6nJnDdq6GoPLT53mwQ5Ru8owmWyY1F06GxG7/zB4yObQAYgCNfROcAtK0+LAhd1jrmdqK6IHc=  ;
Message-ID: <20050824124348.44686.qmail@web25807.mail.ukl.yahoo.com>
Date: Wed, 24 Aug 2005 14:43:48 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: question on memory barrier
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently trying to write a USB driver for Linux. The device must be
configured by writing some values into the same register but I want to be
sure that the writing order is respected by either the compiler and the cpu.

For example, here is a bit of driver's code:

"""
#include <asm/io.h>

static inline void dev_out(u32 *reg, u32 value)
{
        writel(value, regs);
}

void config_dev(void)
{
        dev_out(reg_a, 0x0); /* first io */
        dev_out(reg_a, 0xA); /* second io */
}

void config_dev_fixed(void)
{
        dev_out(reg_a, 0x0); /* first io */
        wmb();
        dev_out(reg_a, 0xA); /* second io */
        wmb();
}
"""

In this case, am I sure that the order will be respected ? can gcc remove
the first io while optimizing...If so, does "config_dev_fixed" fix it ?

thanks for your answers,

            Francis


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
