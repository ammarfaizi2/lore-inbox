Return-Path: <linux-kernel-owner+w=401wt.eu-S965053AbWLTNiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWLTNiz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 08:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWLTNiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 08:38:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46142 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965050AbWLTNiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 08:38:54 -0500
Subject: Re: Network drivers that don't suspend on interface down
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20061220125314.GA24188@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org>
	 <200612191959.43019.david-b@pacbell.net>
	 <20061220042648.GA19814@srcf.ucam.org>
	 <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de>
	 <20061220055209.GA20483@srcf.ucam.org>
	 <1166601025.3365.1345.camel@laptopd505.fenrus.org>
	 <20061220125314.GA24188@srcf.ucam.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 20 Dec 2006 14:38:51 +0100
Message-Id: <1166621931.3365.1384.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

about your driver list;
do you have an idea of what the top 5 relevant ones would be?
I'd be surprised if the top 5 together had less than 95% market share,
so if we fix those we'd be mostly done already.

> The situation is more complicated for wireless. Userspace expects to be 
> able to get scan results from the card even if the interface is down.

if it's down userspace cannot currently expect this (if it does it's
broken), just as it currently can't expect link notifications when the
interface is down. It needs to have the interface up for this. 
(but point taken for a 3rd state)

>  In 
> that case, I'm pretty sure we need a third state rather than just "up" 
> or "down".

so what do you want from this 3rd state? rough guess based on what I
think the desktop wants (so please correct/append)

In the third state you 
* don't expect to get or send "regular" packets
* don't have a dhcp lease or anything like that
* you do expect to get link change notification [1]
* you do expect to be able to scan for access points [2]

open questions
* what if you get a WOL event?



[1] What kind of latency would be allowed? Would an implementation be
allowed to power up the phy say once per minute or once per 5 minutes to
see if there is link? The implementation could do this progressively;
first poll every X seconds, then after an hour, every minute etc.

[2] would it be permissible to temporarily power up the device on scan?
Eg how frequently does the desktop expect to poll for scanning, and what
kind of latency would be tolerable?

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

