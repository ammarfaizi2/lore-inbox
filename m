Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262138AbSJFTJN>; Sun, 6 Oct 2002 15:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262139AbSJFTJN>; Sun, 6 Oct 2002 15:09:13 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:10206 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262138AbSJFTJM>; Sun, 6 Oct 2002 15:09:12 -0400
Message-ID: <20021006191339.3421.qmail@uymail.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Emmanuel Papirakis" <sk_buff@uymail.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 07 Oct 2002 03:13:39 +0800
Subject: TCP BUG: window update issue
X-Originating-Ip: 24.122.23.44
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

under a very specific circomstance, Linux's TCP implementation exhibits a nasty BUG: it fast retransmits spuriously.

I have first noticed the BUG working with a Microsoft "smart phone" (it turns out they are not so smart after all).

These devices spend a lot of ressources on their display.  Beeing so buisy all the time, they become too slow for the network and are not able to read octets fast enough.

Because of this, the advertised window starts to drop. And, here is the interesting part: it seems that Microsoft's TCP sends window updates every time the window starts to grow (that is a lot of window updates), not just after the window has been 0.

The problem is that Linux (2.4) doesn't seem to be able to make the diffrence between a window update and a DUPACK, and fast retransmits spuriously. (Microsoft's stack does the same.)

I could have investigated the source code and fixed the BUG myself, but it seems that somebody more familiar with it could address this issue in a more productive way.

Thank you for your time.

Emmanuel Papirakis
-- 
Get your free email from www.uymail.com 


Powered by Outblaze
