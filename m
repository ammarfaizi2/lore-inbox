Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUAEKua (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 05:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUAEKua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 05:50:30 -0500
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:25533 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S264129AbUAEKu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 05:50:28 -0500
Message-ID: <20040105105027.15858.qmail@iname.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Herve Fache" <herve.fache@europemail.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 05 Jan 2004 10:50:27 +0000
Subject: Removing/ejecting and mount
X-Originating-Ip: 81.86.174.68
X-Originating-Server: ws1-88.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was reading someone's wish to support removal of media such as USB keys or CompactFlash cards at any time. I have the same wish. In fact, I thought it through a bit and I would like a bit more mount options. I could do with:
- almost-sync: allow for delay in writing (not as 'hard' as sync), but do not return until the data is actually safely written onto the medium
- nobusy: umount works (maybe with -f option?) even if the medium is 'busy'
- ephmerary: if the device is mounted rw from a user's point of view, it is not from a kernel point of view unless required by a write operation, and only for the duration of it

Why? Imagine the standard user:
- inserts medium (such as a compact flash card) - hotplug mounts it for him automatically and the WM opens a file manager window
- copies files to/from it - the medium is only in rw mode for the time of the writes (ephemerary option)
+ copy window disappears - we know it _IS_ done (almost-sync option) and we're now mounted ro
- removes compact flash card - hotplug needs to be able to 'clear' the mount, even if busy (nobusy option), and the WM can close any active window pointing to it
+ the medium is still 'clean'

Also, the nobusy option means I can always eject my CD, and that my CD can be handled the same way as described above...

Note that explaining users what mounting is about is very time consuming; such a solution would be greatly beneficial to my nerves...

I am open to comments, and pointers to where this can be implemented but please no flames!
Hervé.
-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

