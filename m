Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTKJCzd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 21:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbTKJCzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 21:55:33 -0500
Received: from cache1.telkomsel.co.id ([202.155.14.251]:43782 "EHLO
	cache1.telkomsel.co.id") by vger.kernel.org with ESMTP
	id S262099AbTKJCzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 21:55:31 -0500
Message-ID: <3FAEF7BC.8060503@telkomsel.co.id>
Date: Mon, 10 Nov 2003 09:28:12 +0700
From: arief_mulya <arief_m_utama@telkomsel.co.id>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.4-4 StumbleUpon/1.8
X-Accept-Language: en
MIME-Version: 1.0
To: vojtech@suse.cz
CC: linux-kernel@vger.kernel.org
Subject: [PATCH?] psmouse-base.c 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mr. Vojtech,


I learn that you are the author for PS/2 mouse driver on Linux 2.6.x 
kernel.

I just want to share a little change that  I've did to 
psmouse_pm_callback() which without this, my synaptics touchpad would 
prevent my laptop (IBM Thinkpad T30) from suspending.

I don't remember how the functions read at first. But this is how it 
become. This is not exactly a patch, huh? Sorry, but I hope it helps.

I also not sure if this patch already done the right thing and I haven't 
tested it on other machine. It works for me, but I can't promise if it 
blows up others. Maybe you could give it a test?

The kernel version was 2.6.0-test9 from Debian (not vanilla, but I'm 
sure the psmouse part is clean).

This is the function:

static int psmouse_pm_callback(struct pm_dev *dev, pm_request_t request, 
void *data)
{
        struct psmouse *psmouse = dev->data;
        struct serio_dev *ser_dev = psmouse->serio->dev;
                                                                               
 
        switch (request) {
        case PM_RESUME:
                psmouse->state = PSMOUSE_IGNORE;
                serio_rescan(psmouse->serio);
        default:
                return 0;
        }
}

Sorry if this just bothers you.
I'm cc-ing also to [linux-kernel], but I'm not subscribed to the list yet.


Best Regards,
-- 
arief_mulya <http://www.geocities.com/naida_s_rasha/>
Peace is beautiful.

