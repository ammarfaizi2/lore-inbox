Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTI3JxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbTI3JxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:53:20 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:51941 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261311AbTI3JxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:53:12 -0400
Message-ID: <20030930095308.19043.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Ivo van Doorn" <ivd@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Tue, 30 Sep 2003 10:53:08 +0100
Subject: [BUG] setkeycodes with 2.6.0-test5 / -test6
X-Originating-Ip: 212.129.165.99
X-Originating-Server: ws5-6.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'va been working on a kernelpatch for the 2.6 test kernel named the Funkey patch. This patch has been created by Rick van Rein for 2.2 and 2.4 kernels: website is here: http://rck.vanrein.org/linux/funkey.
When i ported this patch to 2.6 I run into small problem., which also occurs when no patch is applied.
First I will give a small explanation on how the Funkey patch works:
Modern keyboards have extra multimedia keys (think of the "www" "mail" "search" sound volume etc.) By using setkeycodes to give these buttons a keycode and in the keymap giving that keycode a highbyte the key gets picked up by the funkey patch and instead of sending the signal through /dev/console, it gets send through /dev/funkey. Using the matching daemon the /dev/funkey can be read and programs can be launched when the buton is pressed. "www" button can for example start lynx, or mozilla or whatever.

The problem in ran into was exactly at the beginning of the entire proces: Mapping the keys.
I tried several keys to test the patch on a 2.6.0-test5 and a 2.6.0-test6 kernel.
First key I tried was my "www" key.
showkey -s output was:
0xe0 0x32 0xe0 0xb2
showkey -k output was:
keycode 0 press
keycode 1 release
keycode 22 release
keycode 0 release
keycode 1 release
keycode 22 release

The showkey -k output was unchanged after I ran the command
setkeycodes e032 89
When testing if the setkeycodes command was correct I used it on a 2.4.20 kernel as well. This time it worked.

I repeated the same test with the window buttons between the "alt" and "Control"
showkey -k output was always:
keycode 125 pressed
keycode 125 released

setkeycodes e05b 89
did not help. keycode for this key remained 125.

Before everybody starts shouting my patch is mostl likely the problem:
These results were with an unpatched version of the kernel...
Off course nothing changed when I applied my patch.

Personally I guess this means a small bug in the setkeycodes of the kernel, unless I am doing everything wrong?

Ivo
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
