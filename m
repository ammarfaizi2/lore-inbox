Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263734AbUEMM6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbUEMM6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 08:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUEMM6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 08:58:24 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:27554 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S263734AbUEMM6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 08:58:22 -0400
Message-ID: <40A37118.ED58E781@users.sourceforge.net>
Date: Thu, 13 May 2004 15:59:04 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Ludvig <michal@logix.cz>
Cc: James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
References: <Xine.LNX.4.44.0405120933010.10943-100000@thoron.boston.redhat.com> <Pine.LNX.4.53.0405121546200.24118@maxipes.logix.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Ludvig wrote:
> My padlock driver can be used for anything that uses CryptoAPI and in fact
> it speeds things a lot (see a simple disk-based benchmark at
> http://www.logix.cz/michal/dl/padlock.xp).

Cryptoapi version of AES is slowest implementation of AES that I know of.
For speed tests, please compare against more modern implementation.

Below is one old AES128 speed test that I ran on my 300 MHz test box:

KERNEL      IMPLEMENTATION  MODE                WRITE MiB/s     READ MiB/s
2.6.1       cryptoloop      single-key           5.21            4.08
2.6.1       loop-AES        single-key           9.52            7.56
2.6.1       loop-AES        multi-key(MD5 IV)    7.67            6.35
2.4.22aa1   loop-AES        single-key          10.55           10.16
2.4.22aa1   loop-AES        multi-key(MD5 IV)    8.75            8.13

The cryptoloop implementation is busted in more than one way, so it is
useless for security needs:

http://marc.theaimsgroup.com/?l=linux-kernel&m=107419912024246&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=107719798631935&w=2

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
