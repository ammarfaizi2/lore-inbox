Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263582AbUDZVgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbUDZVgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 17:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263581AbUDZVgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 17:36:06 -0400
Received: from gprs214-178.eurotel.cz ([160.218.214.178]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263582AbUDZVgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 17:36:02 -0400
Date: Mon, 26 Apr 2004 23:35:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz
Subject: Not so theoretical race in atkbd_command
Message-ID: <20040426213555.GA1368@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There's quite real race in atkbd_command:

static int atkbd_command(struct atkbd *atkbd, unsigned char *param,
int command)
{
        int timeout = 500000; /* 500 msec */
        int send = (command >> 12) & 0xf;
        int receive = (command >> 8) & 0xf;
        int i;

        atkbd->cmdcnt = receive;
[user presses key here]

atkbd_interrupt eats user keypress, thinking its reply. Boom. To
exploit:

while true; do setleds +num; setleds -num; done

then try typing.
							Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
