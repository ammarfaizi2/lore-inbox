Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbUJaRFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbUJaRFh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 12:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbUJaRFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 12:05:37 -0500
Received: from ny03.mtek.chalmers.se ([129.16.60.203]:45584 "HELO
	ny03.mtek.chalmers.se") by vger.kernel.org with SMTP
	id S261343AbUJaRFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 12:05:30 -0500
Message-ID: <41851B57.5080302@am.chalmers.se>
Date: Sun, 31 Oct 2004 18:05:27 +0100
From: Thomas Svedberg <thsv@am.chalmers.se>
User-Agent: Mozilla Thunderbird 0.6+ (Windows/20041023)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: KVMs & psmouse losing sync
References: <200410300038.04193.dtor_core@ameritech.net>
In-Reply-To: <200410300038.04193.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Hi,
> 
> Here is my next attempt at resolving the problem with psmouse losing sync
> when used with KVMs that suppress psmouse announcements when switching back
> to linux box.
> 
> The new parameter psmouse.poll is used to have the driver periodically send
> "enable" command to the mouse if there was no data from the device in last
> <poll> msec. If the command errors or times out the driver assumes that the
> mouse was disconnected and next time there is data on the same serio port
> the driver will attempt to reconnect.
> 
> The advantages of this approach is that it should work well regardless of
> the protocol (normally it is very hard to differentiate between bare PS/2
> and PS2++) and driver will not pass any bad packets to userpace. The main
> cpms is that we're toast if KVM ACKs the command even when mouse/kbd are
> connected to another box. 
> 
> The patch is against vanilla 2.6.9, boot with psmouse.poll=500. I would
> appreciate comments/testing. Thanks!

Works great with my Belkin Omni Cube, thank you!

-- 
/ Thomas
.......................................................................
  Thomas Svedberg
  Department of Applied Mechanics
  Chalmers University of Technology

  Address: SE-412 96 Göteborg, SWEDEN
  E-mail : thsv@am.chalmers.se, thsv@bigfoot.com
  Phone  : +46 31 772 1522
  Fax    : +46 31 772 3827
.......................................................................


