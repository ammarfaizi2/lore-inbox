Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTI3Uvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 16:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbTI3Uvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 16:51:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:64247 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261722AbTI3Uvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 16:51:35 -0400
Message-ID: <3F79ECEA.5090904@onlinehome.de>
Date: Tue, 30 Sep 2003 22:51:54 +0200
From: Hans-Georg Thien <1682-600@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PORT to 2.6.x] "Disable Trackpad while typing" on Notebooks with
 a PS/2 Trackpad
References: <3EB19625.6040904@onlinehome.de>	<3EBAAC12.F4EA298D@hp.com>	<3ED3CECA.9020706@onlinehome.de> <20030527231026.6deff7ed.subscript@free.fr>
In-Reply-To: <20030527231026.6deff7ed.subscript@free.fr>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have written a patch against the linux 2.4.x kernel and I want to port 
it to the 2.6.x Kernel now.

What it is
- ----------
The trackpad on the MacIntosh iBook notebooks have a feature that 
prevents unintended trackpad input while typing on the keyboard. There 
are no mouse-moves or mouse-taps for a short period of time after each 
keystroke.

I thougt that was a nice-to-have for my i386 notebook and have 
implemented it ( with some very important help of other people, namely 
Torsten Foertsch ).

This feature is fully configurable via a proc entry.

How it currently works
- ----------------------

In the 2.4.x kernel the handling of keyboard and PS/2 mouse where both 
done in linux/drivers/char/pc_keyb.c. So it was easy to apply a patch 
without touching other files.

It simply stores a timestamp whenever a key event occurs. If a mouse 
event occurs it compares the timestamp of the mouse event with stored 
timestamp of the key event. If the delta of these timestamps is less 
than a treshold value, than this mouse event is simply discarded. There 
where some things more to consider about, but I think you have the idea.

Where I need help now
- ---------------------
Since I do not want to touch the keyboard driver, I wonder if there is 
better way to get the timestamp when the last keyboard event occured?

Maybe a function call, a callback function where I can register to the 
be notified when a event occurs, a global accessible variable, a proc 
entry or something like that.

Any ideas ?

- - Hans

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (MingW32)

iD8DBQE/eezq2xSpXPjN/jsRAgyAAJ9djvaiYsgiR4pOf4GRJ2xNKCUa5QCdFreB
4/iOjaoS+3XX0dL8DFGEaJk=
=zh+9
-----END PGP SIGNATURE-----

