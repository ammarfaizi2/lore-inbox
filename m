Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264022AbUEMKcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbUEMKcR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 06:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUEMKcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 06:32:16 -0400
Received: from usergc137.dsl.pipex.com ([62.190.170.137]:779 "EHLO
	gateway.office.e-tv-interactive.com") by vger.kernel.org with ESMTP
	id S264022AbUEMKcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 06:32:12 -0400
Subject: Natsemi ethernet 'cable magic' fix can cause problems
From: Colin Paton <colin.paton@etvinteractive.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: eTV Interactive Ltd
Message-Id: <1084444503.4548.141.camel@colinp>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 13 May 2004 11:35:03 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This information may be useful to anyone who uses the natsemi ethernet
driver.

I have discovered that the 'do_cable_magic()' call introduced into the
driver in kernels 2.4.20 and later can cause problems.

Some machines we have use the Natsemi DP83815 chip, which worked with no
problems using kernel 2.4.19. Following an upgrade to 2.4.25 a few of
the boxes stopped working - but most were still OK.

The problem was strange - about 30% packet loss was experienced during
pings. Moving the box to a different ethernet wall outlet (but still
using the same port on the switch) cured the problem. The problem
therefore appeared to be cable dependant.

It would appear that the call to 'do_cable_magic()' in
drivers/net/natsemi.c causes the problem to occur.

It looks as though this was added in to actually *fix* such problems...
but in our case it made things worse.

The cable problems were never experienced before, and everything seems
fine now that this call has been removed.

I'm not sure of the correct way to fix this problem, but I'm hoping that
this information might be useful to others who encounter something
similar.

Colin

