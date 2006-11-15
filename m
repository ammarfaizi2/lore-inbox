Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966589AbWKOHDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966589AbWKOHDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966590AbWKOHDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:03:52 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:46491 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966589AbWKOHDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:03:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=mf5ZuvoXJ3HSMLvsQfNseYf7CI/inhApgzygD+ylGmrquXStUhZesCVuM3oZfcbcvajmwRpO1Wnx8sl4/C9C0kwrHkJH9CgiU3gP+ixUdvDiBIVd9pDc3tkTLgttGo+Zr0rt1Tjk2slbyn1mCmv6eOMJ0FFawKhVbgfatGPMqA8=  ;
X-YMail-OSG: D2oNubkVM1lxki4_w.6YQBAQkyClfZoq7Azl7hB4Yuh47tvQnQk8Jyq340a5bVzV59ncN_8yrNM48E.uR213NM_0ldha23WTV0z_E8Jm3Fjqiwjjaha6WA--
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Tue, 14 Nov 2006 23:03:47 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611142303.47325.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmesg reports to me stuff like

ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [20060707]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPC0.BAT1._BIF] (Node ffff8100020368d0), AE_TIME
ACPI Exception (acpi_battery-0148): AE_TIME, Evaluating _BIF [20060707]
ACPI: read EC, IB not empty
ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [20060707]
ACPI Error (psparse-0537): Method parse/execution failed [\_TZ_.THRM._TMP] (Node ffff810002032d10), AE_TIME

It never used to complain at all.  This is an amd64 laptop, and related symptoms
include

 - kpowersave not being able to monitor the batter or AC adapter correctly;
   leading to catastrophes like laptop powering itself off with no warning,
   loss of work, filesystem needing log recovery, and so forth.

 - Serious fan action.  Recent kernels seemed to finally be doing sane things
   so that e.g. just editing text kept the CPU cool ... but now it's on almost
   all the time, CPU is very hot.

What's an AE_TIME?

I'm not quite sure where these problems crept in, but I never saw such stuff with
2.6.18 at all.

- Dave

