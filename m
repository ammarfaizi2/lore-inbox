Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWJBUFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWJBUFW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWJBUFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:05:21 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:64418 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964944AbWJBUFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:05:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=txzf5C+ayDFS0fZLKCNCAaUyQDQNNgeDFA4QV34egvXJ+ouqI0crWD4nKD2vkTcO3a900Nc0lcsL3tQQENi2x5Ru8o73rIFhSJqclqsxinK9Uwc8azFUE2RqA2T/X+gx68z6Orj3KaoQWhbIz5MYMnx0oPxBJSCmcPsufD53MVM=  ;
From: David Brownell <david-b@pacbell.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 2.6.18-git] ide-cs (CompactFlash) driver, rm irq warning
Date: Mon, 2 Oct 2006 11:58:59 -0700
User-Agent: KMail/1.7.1
Cc: B.Zolnierkiewicz@elka.pw.edu.pl,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200610020902.20030.david-b@pacbell.net> <1159811149.8907.32.camel@localhost.localdomain>
In-Reply-To: <1159811149.8907.32.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610021158.59886.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2006 10:45 am, Alan Cox wrote:
> Ar Llu, 2006-10-02 am 09:02 -0700, ysgrifennodd David Brownell:
> > Git rid of the runtime warning about pcmcia not supporting
> > exclusive IRQs, so "the driver needs updating".
> > 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> You've audited the code to check this is safely handled ?

As best I can, yes.  IDE being somewhat black-boxish to most of us.
The patch literally does no more than shut up the warning found in
drivers/pcmcia/pcmcia_resource.c ... it doesn't change any other
behavior in the PCMCIA layer.  And the IDE layer never appeared to
have a problem.

The IRQ handler seems to be drivers/ide/ide-io.c::ide_intr() and
comments there reflect the expectation that it handle shared IRQs.

- Dave
