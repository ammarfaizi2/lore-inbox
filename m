Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287307AbRL3CHn>; Sat, 29 Dec 2001 21:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287309AbRL3CHd>; Sat, 29 Dec 2001 21:07:33 -0500
Received: from ppp112.dyn147.pacific.net.au ([210.23.147.112]:25728 "EHLO
	mega-nerd.net") by vger.kernel.org with ESMTP id <S287307AbRL3CH1>;
	Sat, 29 Dec 2001 21:07:27 -0500
Date: Sun, 30 Dec 2001 13:07:23 +1100
From: Erik de Castro Lopo <nospam@mega-nerd.com>
To: linux-kernel@vger.kernel.org
Subject: midi device release function not being called
Message-Id: <20011230130723.1f27a83f.nospam@mega-nerd.com>
Organization: Erik Conspiracy Secret Labs
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: Microsoft Outlook Fatal Error. Please reboot your system.
X-Erik-Conspiracy: There is no conspiracy.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi People,

I'm trying to track down a problem in the es1371 midi driver. The problem
is that when /dev/midi is opened with O_NONBLOCK and the file is closed
when there is still data in the output buffer something in the driver
gets locked up preventing all further opens of the device. The error 
returned by open is "Device or resource busy".

Having a look around in the driver I added a printk statement to the
top of the es1371_midi_release() function and found that this function
is never called. I would have expected this to be called in at least 
one of the following situations:

    - The device is close()ed 
    - The driver is mod unloaded

Adding a printk statement to the es1371_midi_open() function works as
expected. Is there a reason why the release function is not called?

This is on linux-2.4.16 on an SMP machine. I have also tried 2.2.20 and 
found the same problem (file opened O_NONBLOCK and closed with data still
in the output buffer) there.

Can someone please shed some light on this?

Cheers,
Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
"The whole principle is wrong; it's like demanding that grown men live on 
skim milk because the baby can't eat steak."
- author Robert A. Heinlein on censorship.
