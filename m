Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752137AbWCCCFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbWCCCFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 21:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbWCCCFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 21:05:24 -0500
Received: from relay2.es.uci.edu ([128.200.80.28]:43198 "EHLO
	relay2.es.uci.edu") by vger.kernel.org with ESMTP id S1752137AbWCCCFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 21:05:23 -0500
X-UCInetID: fkruggel
Message-ID: <4407A45C.8010307@uci.edu>
Date: Thu, 02 Mar 2006 18:05:16 -0800
From: Frithjof Kruggel <fkruggel@uci.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.7.12) Gecko/20060207 Debian/1.7.12-1.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, fkruggel@uci.edu
Subject: Bug in aic79xx_osm.c: synchronous mode not negotiated
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have an HP tape library attached to an Adaptec
29320A Ultra320 SCSI card. While upgrading the
kernel from version 2.6.13.5 to 2.6.15.5, I found
that writing tapes slowed down from 24 MB/s to
4.5 MB/s.

Switching on debug mode in the driver revealed
that for both the tape drive and the autochanger,
asynchronous mode is negotiated with the new kernel.

After playing around with the code, I found that
there is a problem with function ahd_send_async()
in file aic79xx_osm.c.

Reverting a piece of code in this function back
to version 2.6.13.5 solved the problem (specifically,
replacing lines 1609-1632 of aic79xx_osm.c in
version 2.6.15.5 with lines 4240-4263 in version
2.6.13.5). Synchronous mode is now negiotiated
for both targets.

Of course, I have no idea about any potential
side effects of this change, so I would rather
give this problem back to the maintainers of this
code. Feel free to contact me if you need more
information. Please, cc: to the address above,
as I am not a regular subscriber to this list.

Best wishes,

Frithjof Kruggel



