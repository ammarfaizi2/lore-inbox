Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVA1A14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVA1A14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVA1AYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 19:24:18 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:57531 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261352AbVA1AX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 19:23:28 -0500
To: hpa@zytor.com (H. Peter Anvin)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch 4/6  randomize the stack pointer
X-Message-Flag: Warning: May contain useful information
References: <20050127101117.GA9760@infradead.org>
	<20050127101322.GE9760@infradead.org>
	<41F94462.7080108@francetelecom.REMOVE.com>
	<ctbvtf$305$1@terminus.zytor.com>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 27 Jan 2005 16:23:08 -0800
In-Reply-To: <ctbvtf$305$1@terminus.zytor.com> (H. Peter Anvin's message of
 "Fri, 28 Jan 2005 00:10:23 +0000 (UTC)")
Message-ID: <52u0p2wger.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Jan 2005 00:23:11.0027 (UTC) FILETIME=[8C67A030:01C504CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Julien> Not very important but ((get_random_int() % 4096) << 4)
    Julien> could be optimized into get_random_int() & 0xFFF0.

    HPA> .. and gcc knows that.

    HPA>    8:   25 ff 0f 00 00          and    $0xfff,%eax
    HPA>    d:   83 c4 0c                add    $0xc,%esp
    HPA>   10:   c1 e0 04                shl    $0x4,%eax

Actually gcc isn't quite that smart (since it obviously can't
understand the semantics of get_random int()).  The original point was
that the "shl $0x4" can be avoided by directly &'ing with 0xfff0, not
that "% 4096" can be strength reduced to "& 0xfff".

 - R.
