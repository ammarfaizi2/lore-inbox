Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUFSPSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUFSPSi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 11:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUFSPSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 11:18:36 -0400
Received: from dvhart.tempdomainname.com ([128.121.61.168]:4613 "HELO
	mindlib.com") by vger.kernel.org with SMTP id S263980AbUFSPSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 11:18:34 -0400
Subject: IR Remotes under 2.6
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1087658340.2792.31.camel@farah>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 19 Jun 2004 08:19:00 -0700
Content-Transfer-Encoding: 7bit
From: Darren Hart <darren@dvhart.com>
X-Delivery-Agent: TMDA/0.89 (Chateaugay)
X-Primary-Address: darren@dvhart.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had some thoughts regarding the >=2.6.6 approach to handling remotes
as keyboards (specifically the ir-kbd-i2c driver).

1) First, I believe the kernel can really only recognize the receiver,
not the remote.  This means that one receiver could be used for several
different remotes (like with the Hauppauge PVR-[23]50 for example which
has at least 3 different remotes that I am aware of).  Unfortunately,
the keytabs are hardcoded into the kernel (ir-common.c).  IMO, the
system would be much more useful if a keytab could be loaded in much the
same way some USB devices load firmware.  

2) The current hardcoded keytabs use KEY_* event codes.  IMO people
don't think of remotes as keyboards, the closest parallel would be more
like a joystick.  My remote has keys that are bound to keyboard keys
that I don't like, but unless I recompile the kernel I can't really
change that.  It seems to me that remotes should use BTN_* event codes
rather than KEY_* codes.  That way all the buttons on the remote can be
configured.  As KEY_* codes, I find that X grabs the ones it recognizes
before I can assign them a function.  The '0' button for instance always
sends a 0 to the focused window.  There are many situations where a user
would want 0 on the remote to behave differently than 0 on their
keyboard.  The use of BTN_0 would make it configurable through userspace
applications such as the gnome media keys or lirc (although once more
apps have input event support, lirc wouldn't be necessary at all).

Thoughts?

Thanks,

Darren Hart
