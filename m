Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTGXRXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 13:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269578AbTGXRWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 13:22:49 -0400
Received: from 66.83.182.2.nw.nuvox.net ([66.83.182.2]:24789 "EHLO
	secure.intgrp.com") by vger.kernel.org with ESMTP id S269575AbTGXRV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 13:21:57 -0400
Message-ID: <038a01c3520a$233c2280$9100000a@intgrp.com>
From: "Eric Wood" <eric@interplas.com>
To: "Kernel List" <linux-kernel@vger.kernel.org>
References: <077a01c35157$d898c100$9100000a@intgrp.com> <3F1F7A97.7000304@candelatech.com>
Subject: Re: RH 9 kernel compile error
Date: Thu, 24 Jul 2003 13:36:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> I have never used rpm target...but I imagine it works :)

Overall yes. As long as you:
# make mrproper `/bin/cp configs/kernel-2.4.20-i686.config .config`
oldconfig dep clean rpm

The resulting rpm file seems to always be built for i386 even though you're
using a 686 .config file.  It looks like kerne.spec file which is generated
from "scripts/mkspec" neglects to issue an arch.  Or you have to edit the
Makefile and slip in a "--target=i686" or "--target=athlon" like so:

$(RPM) -ta --target=i686 $(TOPDIR)/../$(KERNELPATH).tar.gz ; \

before you do the build.
-eric

