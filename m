Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267557AbSLEW2k>; Thu, 5 Dec 2002 17:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267556AbSLEW2k>; Thu, 5 Dec 2002 17:28:40 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:10903 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S267555AbSLEW2j>; Thu, 5 Dec 2002 17:28:39 -0500
Message-ID: <3DEFD4FC.7D2ED539@earthlink.net>
Date: Thu, 05 Dec 2002 14:36:44 -0800
From: Erblichs <erblichs@earthlink.net>
X-Mailer: Mozilla 4.72 [en]C-gatewaynet  (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel: question/bug: mm/vmscan.c : refill_inactive_zone() : 2.4.18-3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Statement:

	In a "while" loop we are looking for a target number of
	pages to deactivate.

Question?
	If there are a large number of processes that have not
	exceeded their Resident Set Size (rss) and they are
	keeping their pages hot, then we won't reach our target
	value. This would keep our inactive page list small.

Suggestion and solution:
	In this environment, I would think it would make sense
	to effectively walk this list again (without aging)
	and effectively half the rss so we are able to reach
	our target value.

	I would think that this approach would then penalize
	all tasks equally. If halving the rss is too extreme,
	then an increased percentage (< 100%) would walk more
	pages to reach the target value.

	Mitchell Erblich : erblichs@earthlink.net
	Note: I am not currently on this mail alias.
