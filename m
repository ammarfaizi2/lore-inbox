Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUG2MUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUG2MUI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 08:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbUG2MUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 08:20:08 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:52609 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264443AbUG2MUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 08:20:04 -0400
Subject: Re: fixing usb suspend/resuming
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: David Brownell <david-b@pacbell.net>,
       Alexander Gran <alex@zodiac.dnsalias.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040729083543.GG21889@openzaurus.ucw.cz>
References: <200405281406.10447@zodiac.zodiac.dnsalias.org>
	 <40F962B6.3000501@pacbell.net>
	 <200407190927.38734@zodiac.zodiac.dnsalias.org>
	 <200407202205.37763.david-b@pacbell.net>
	 <20040729083543.GG21889@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1091103438.2703.13.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 29 Jul 2004 22:17:18 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-07-29 at 18:35, Pavel Machek wrote:
> Plus, some PCI drivers (ide disk?) want to do different thing on S3 and swsusp:
> it does not make much sense to spindown before swsusp.

Regarding the spinning down before suspending to disk, I have a patch in
my version that adds support for excluding part of the device tree when
calling drivers_suspend. I take the bdevs we're writing the image to,
trace the structures to get the relevant device tree entry/ies and then
move (in the correct order) those devices and their parents from the
active devices list to a 'dont' touch' list (I don't call it that in
code). I can then safely suspend the remaining devices without powering
down the ones being used for suspend. I'm not sure of the context of
your conversation but if it's helpful, I'll send a patch.

Nigel

