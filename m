Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbTIYSX7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbTIYSX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:23:58 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:13140 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261826AbTIYSXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:23:42 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>, akpm@osdl.org, petero2@telia.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Add BTN_TOUCH to Synaptics driver. Update mousedev.
Date: Thu, 25 Sep 2003 13:23:33 -0500
User-Agent: KMail/1.5.3
References: <10645086121286@twilight.ucw.cz>
In-Reply-To: <10645086121286@twilight.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309251323.33416.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 September 2003 11:50 am, Vojtech Pavlik wrote:
> +
> +	if (hw.z > 30) input_report_key(dev, BTN_TOUCH, 1);
> +	if (hw.z < 25) input_report_key(dev, BTN_TOUCH, 0);
>

Couple of questions:

- Why does it use hard-coded values? Different people prefer different 
  settings.

- Are userspace drivers supposed to use BTN_TOUCH event to detect whether 
  the pad is touched or ABS_PRESSURE? If ABS_PRESSURE then BTN_TOUCH is
  unneeded; otherwise it's not configurable.

- Introducing BTN_TOUCH as far as I can seen does nothing to prevent joydev
  grabbing either Synaptics or touchscreens... Is there a patch missing?
  Anyway, I still thing that joydev claims are too broad. Next time you add 
  a non-joystick device you will need to re-examine joydev and it should be
  other way around - if you add a joystick you need to make sure that joydev
  grabs it. This way you will catch most problems right away.

BTW, any chance on including pass-through patches? Do you want me to re-diff 
them?

Dmitry
  
