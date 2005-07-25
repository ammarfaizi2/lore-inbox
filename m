Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVGYCoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVGYCoJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 22:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVGYCoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 22:44:09 -0400
Received: from femail.waymark.net ([206.176.148.84]:52705 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S261590AbVGYCoI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 22:44:08 -0400
Date: 25 Jul 2005 02:34:58 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
To: linux-kernel@vger.kernel.org
Message-ID: <603f59.f8ac5d@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> Kenneth Parrish wrote to All <=-

 KP>  2.6.13-rc3-git5 lags -git4 on nbench's bitfield test, a part of its
 KP> memory index, eg typical runs
 KP> -git5
 KP> BITFIELD            :      1.1589e+07  :       1.99  :       0.42
 KP> -git4
 KP> BITFIELD            :      2.1892e+07  :       3.76  :       0.78

 KP> lmbench has slower context switch numbers for -git5.

i've been experimentally adding -funswitch-loops and -fpeel loops to the
default -march=i586 in the ../arch/i386/Makefile

cflags-$(CONFIG_M586)       += -march=i586 -funswitch-loops -fpeel-loops

based on some tests with gcc 3.4.3,4 and the cyrix mii cpu, but
with v2.6.13-rc3-git5 carelessly put these flags on the next,
cflags-$(CONFIG_M586TSC) line, and so they would not have been used.
i shall retest after recompiling to confirm.
[..]
yeah, a couple nbench runs show similar overall results as -git4
