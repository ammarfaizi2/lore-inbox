Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVDNLTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVDNLTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 07:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVDNLTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 07:19:44 -0400
Received: from ns.tasking.nl ([195.193.207.2]:61935 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S261477AbVDNLTg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 07:19:36 -0400
To: linux-kernel@vger.kernel.org
From: Kees Bakker <spam@altium.nl>
Subject: Re: 2.6.12-rc2: Compose key doesn't work
Date: Thu, 14 Apr 2005 13:18:44 +0200
References: <4258F74D.2010905@keyaccess.nl>
User-Agent: KNode/0.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
NNTP-Posting-Host: 172.17.1.96
Message-ID: <cb5.425e5193.abd94@altium.nl>
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by greve.tasking.nl id NAA0000413215
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:

> Hi Vojtech.
> 
> I have mapped my right windows key to "Compose" in X:
> 
> Section "InputDevice"
>          Identifier      "Keyboard0"
>          Driver          "kbd"
>          Option          "XkbModel" "pc104"
>          Option          "XkbLayout" "us"
>          Option          "XkbOptions" "compose:rwin"
> EndSection
> 
> This worked fine upto  2.6.11.7, but doesn't under 2.6.12-rc2. The key 
> doesn't seem to be doing anything anymore: "Compose-'-e" just gets me 
> "'e" and so on.

This is caused by the change in drivers/input/keyboard/atkbd.c
By default atkbd_scroll is now set 1. This can be switched off on the
commandline if you want to try: atkbd.scroll=0

I'd vote for undoing the change. Here is a tiny patch.
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c    2005-04-04 09:40:48 -07:00
+++ b/drivers/input/keyboard/atkbd.c    2005-04-04 09:40:48 -07:00
@@ -54,7 +54,7 @@
 module_param_named(softraw, atkbd_softraw, bool, 0);
 MODULE_PARM_DESC(softraw, "Use software generated rawmode");

-static int atkbd_scroll = 1;
+static int atkbd_scroll;
 module_param_named(scroll, atkbd_scroll, bool, 0);
 MODULE_PARM_DESC(scroll, "Enable scroll-wheel on MS Office and similar keyboards");




