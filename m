Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbWAKTBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbWAKTBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 14:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWAKTBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 14:01:42 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:12648 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932635AbWAKTBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 14:01:41 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
X-Message-Flag: Warning: May contain useful information
References: <adaslrw3zfu.fsf@cisco.com>
	<1136909276.32183.28.camel@serpentine.pathscale.com>
	<20060110170722.GA3187@infradead.org>
	<1136915386.6294.8.camel@serpentine.pathscale.com>
	<20060110175131.GA5235@infradead.org>
	<1136915714.6294.10.camel@serpentine.pathscale.com>
	<20060110140557.41e85f7d.akpm@osdl.org>
	<1136932162.6294.31.camel@serpentine.pathscale.com>
	<20060110153257.1aac5370.akpm@osdl.org>
	<1137000032.11245.11.camel@camp4.serpentine.com>
	<20060111172216.GA18292@mars.ravnborg.org>
	<20060111093019.097d156a.akpm@osdl.org>
	<1137001400.11245.31.camel@camp4.serpentine.com>
	<adairsq1tx9.fsf@cisco.com>
	<1137005865.11245.47.camel@camp4.serpentine.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 11 Jan 2006 11:01:39 -0800
In-Reply-To: <1137005865.11245.47.camel@camp4.serpentine.com> (Bryan
 O'Sullivan's message of "Wed, 11 Jan 2006 10:57:45 -0800")
Message-ID: <ada3bju1td8.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 11 Jan 2006 19:01:40.0690 (UTC) FILETIME=[74A28B20:01C616E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> The memcpy32 routine is, but __raw_memcpy_toio32 simply
    Bryan> calls it, so we have two jump/ret pairs instead of one.

Oh, I think you're misunderstanding Andrew's idea.  Just create a
generic __raw_memcpy_toio32() that is always compiled, but mark it
with attribute((weak)).  Then x86_64 can define its own version of
__raw_memcpy_toio32(), which will override the weak generic version.

 - R.
