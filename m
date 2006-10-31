Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423819AbWJaTci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423819AbWJaTci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423820AbWJaTci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:32:38 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:25613 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1423819AbWJaTch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:32:37 -0500
Date: Tue, 31 Oct 2006 19:32:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Arnd Bergmann <arnd@arndb.de>,
       Christoph Hellwig <hch@lst.de>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Dominik Brodowski <linux@brodo.de>,
       Harald Welte <laforge@netfilter.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: feature-removal-schedule obsoletes
Message-ID: <20061031193212.GC26625@flint.arm.linux.org.uk>
Mail-Followup-To: J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Jiri Slaby <jirislaby@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Adrian Bunk <bunk@stusta.de>, Dominik Brodowski <linux@brodo.de>,
	Harald Welte <laforge@netfilter.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Jean Delvare <khali@linux-fr.org>
References: <45324658.1000203@gmail.com> <20061016133352.GA23391@lst.de> <200610242124.49911.arnd@arndb.de> <4543162B.7030701@drzeus.cx> <20061031155756.GA23021@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031155756.GA23021@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 04:57:56PM +0100, J?rn Engel wrote:
> On Sat, 28 October 2006 10:34:51 +0200, Pierre Ossman wrote:
> > 
> > What should be used to replace it? The MMC block driver uses it to
> > manage the block device queue. I am not that intimate with the block
> > layer so I do not know the proper fix.
> 
> Why does the MMC block driver use a thread?  Is there a technical
> reason for this or could it be done in original process context as
> well, removing some code and useless cpu scheduler overhead?

As I understand it, there is no guarantee that a block drivers request
function will be called in process context - it could be called in
interrupt context.

The MMC subsystem needs process context to issue commands since the
process of issuing commands entails various sleeps.  Hence why the
MMC block has its own process context.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
