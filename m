Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUJJAKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUJJAKm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 20:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267810AbUJJAKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 20:10:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:1460 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267769AbUJJAKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 20:10:24 -0400
Subject: Re: [PATCH]: pbook apm_emu.c fix remaining time when charging
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1097352701.3483.12.camel@localhost>
References: <1097352701.3483.12.camel@localhost>
Content-Type: text/plain
Message-Id: <1097366985.5591.16.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 10 Oct 2004 10:09:46 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-10 at 06:11, Soeren Sonnenburg wrote:
> Hi,
> 
> this should make /proc/apm 
> 
> a) display the remaining time until the battery is fully charged and
> b) when the system is on AC but the battery is not getting charged 0 is
> displayed as remaining time.
> 
> Please comment/apply,
> Soeren

                if (amperage < 0) {
+                       /* when less than 100mA are used the machine must be on AC and as it is 
+                          not charging the battery is only slightly self decharging and thus full be definition */
+                       if (amperage < 100) {

There must be something wrong in the above...

+                                       time_units = (charge * 59) / (amperage * -1);
+                               else
+                                       time_units = (charge * 16440) / (amperage * -60);

Can you make sure also that amperage is never 0 ?

Ben.


