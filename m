Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVEZM1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVEZM1e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 08:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVEZM1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 08:27:33 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:25482 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261346AbVEZM1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 08:27:25 -0400
Date: Thu, 26 May 2005 14:27:24 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Domen Puncer <domen@coderock.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: 2.6.12-rc2: Compose key doesn't work
Message-ID: <20050526122724.GA3396@ucw.cz>
References: <4258F74D.2010905@keyaccess.nl> <20050414100454.GC3958@nd47.coderock.org> <20050526122315.GA3880@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20050526122315.GA3880@nd47.coderock.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 26, 2005 at 02:23:15PM +0200, Domen Puncer wrote:

> Still true for 2.6.12-rc5. Should probably be fixed before final.

Caused by a bug in the atkbd-scroll feature. The attached patch
fixes it.

> On 14/04/05 12:04 +0200, Domen Puncer wrote:
> > On 10/04/05 11:52 +0200, Rene Herman wrote:
> > > Hi Vojtech.
> > > 
> > > I have mapped my right windows key to "Compose" in X:
> > ...
> > > 
> > > This worked fine upto  2.6.11.7, but doesn't under 2.6.12-rc2. The key 
> > > doesn't seem to be doing anything anymore: "Compose-'-e" just gets me 
> > > "'e" and so on.
> > 
> > I can confirm this, right windows key works as scroll up, so it might
> > be related to recent scroll patches.
> > 
> > A quick workaround is to:
> > echo -n "0" > /sys/bus/serio/devices/serio1/scroll
> > 
> > serio1 being the keyboard here.
> > 
> > Btw. is that "-n" really necessary? Had too look at the code to figure
> > out why it's not working :-)
> > 
> > > 
> > > X is X.org 6.8.1, keyboard is regular PS/2 keyboard, directly connected.
> > 
> > Same here.
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=atkbd-fix-scroll

ChangeSet@1.2229.1.9, 2005-04-04 15:37:45+02:00, vojtech@suse.cz
  input: Fix fast scrolling scancodes in atkbd.c
    
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 atkbd.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2005-05-03 15:23:34 +02:00
+++ b/drivers/input/keyboard/atkbd.c	2005-05-03 15:23:34 +02:00
@@ -171,9 +171,9 @@
 	unsigned char set2;
 } atkbd_scroll_keys[] = {
 	{ ATKBD_SCR_1,     0xc5 },
-	{ ATKBD_SCR_2,     0xa9 },
-	{ ATKBD_SCR_4,     0xb6 },
-	{ ATKBD_SCR_8,     0xa7 },
+	{ ATKBD_SCR_2,     0x9d },
+	{ ATKBD_SCR_4,     0xa4 },
+	{ ATKBD_SCR_8,     0x9b },
 	{ ATKBD_SCR_CLICK, 0xe0 },
 	{ ATKBD_SCR_LEFT,  0xcb },
 	{ ATKBD_SCR_RIGHT, 0xd2 },

--FL5UXtIhxfXey3p5--
