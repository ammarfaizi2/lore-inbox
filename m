Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268438AbTBZAiY>; Tue, 25 Feb 2003 19:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268449AbTBZAiY>; Tue, 25 Feb 2003 19:38:24 -0500
Received: from intra.cyclades.com ([64.186.161.6]:47118 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP
	id <S268438AbTBZAiW>; Tue, 25 Feb 2003 19:38:22 -0500
Message-ID: <3E5B9E23.6080303@cyclades.com>
Date: Tue, 25 Feb 2003 16:47:31 +0000
From: Henrique Gobbi <henrique2.gobbi@cyclades.com>
Reply-To: henrique.gobbi@cyclades.com
Organization: Cyclades Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: n_tty.c - possible enhancement
References: <Pine.LNX.4.33.0301211141580.8730-100000@pcz-madhavis.sasken.com> <3E2CF0A1.5030203@ToughGuy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all !!!

I was having data loss problems using my serial ports at 115200 with 
software flow control (I can't use hw flow control) and I ended up 
figuring out that the problem was happening because of the small value 
of the tty buffer high water mark (TTY_THRESHOLD_THROTTLE). Changing 
that define value and recompiling the kernel was the only solution i 
found to my problem.

The way this code is implemented today is bad. The water marks are hard 
coded and the only way to change them is recompiling the kernel again, 
and this is not a good solution for that. I want to change that.

My idea is:
-------------------------------------------------------------------------
1 - Create two new variables in the tty struct: high_watermark and 
low_watermark;

2 - Initialize this variables with the values they have today: 128 and 128;

3 - Create 4 ioctl's to set and get the values of this 2 variables;

4 - Change the file n_tty.c. The line that has
	if (n_tty_receive_room(tty) < TTY_THRESHOLD_THROTTLE) {
     will have:
	if (n_tty_receive_room(tty) < tty->high_watermark) {

     and the same thing will be done for the low watermark
-------------------------------------------------------------------------

I would appreciate any comment on this matter. If you guys don't see any 
problem on this I will commit a patch as soon as possible

later
Henrique

