Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVAJTqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVAJTqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVAJTof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:44:35 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:38412 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S262480AbVAJTY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:24:26 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <linux-os@analogic.com>, "Patrick J. LoPresti" <patl@curl.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: RE: /dev/random vs. /dev/urandom
Date: Mon, 10 Jan 2005 11:24:21 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEMKAPAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Importance: Normal
In-Reply-To: <Pine.LNX.4.61.0501100735210.19253@chaos.analogic.com>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 10 Jan 2005 11:00:20 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 10 Jan 2005 11:00:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In the first place, the problem was to display the error of using
> an ANDing operation to truncate a random number.

	Except there is no error.

> In the limit,
> one could AND with 0 and show that all randomness has been removed.

	Of course. Any time you truncate something, you are removing something from
it.

> However, those who know nothing about the theory would then
> probably jump upon this as a "special case" even though it usn't.

	Nope, no special case. Truncate all the way, remove everything. Truncate
part of the way, remove something.

	If you have a random number between 0 and 32767, and you want a random
number between 0 and 255, you are going to have to remove some of the
randomness from the input number. So long as the input random numbers are
uniform and the truncation maps the same number of inputs to each output,
any truncation scheme is as good as any other. Specifically, ANDing is as
good as dividing, is as good as any other scheme as far as the quality of
the output is concerned.

	Where things get complicated is where the number of possible outputs does
not divide evenly into the number of possible inputs. For example,
truncating a random number between 0 and 32767 to one between 0 and 9. There
are some algorithms to do this, but ANDing is insufficient.

	DS


