Return-Path: <linux-kernel-owner+w=401wt.eu-S965059AbWLTNuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWLTNuV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 08:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbWLTNuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 08:50:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41793 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965060AbWLTNuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 08:50:20 -0500
Subject: Re: locking issue (hardirq+softirq+user)
From: Arjan van de Ven <arjan@infradead.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <45893C1C.60305@gmail.com>
References: <45893C1C.60305@gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 20 Dec 2006 14:50:18 +0100
Message-Id: <1166622618.3365.1389.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 14:35 +0100, Jiri Slaby wrote:
> Hi!
> 
> an user still gets NMI watchdog warning, that the machine deadlocked.

have you tried enabling LOCKDEP ?


> isr() /* i.e. hardirq context */
> {
> spin_lock(&lock);
> ...
> spin_unlock(&lock);
> }

this is ok if you are 100% sure that this never gets called in any other
way

> 
> timer() /* i.e. softirq context */
> {
> unsigned int f;
> spin_lock_irqsave(&lock, f) /* stack shows, that it locks here */

this is a bug, the flags are an "unsigned long" not "unsigned int"!
It may do really bad stuff!

Greetings,
   Arjan van de Ven

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

