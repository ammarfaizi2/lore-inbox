Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263912AbTD0KfO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 06:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTD0KfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 06:35:14 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:25099 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S263912AbTD0KfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 06:35:12 -0400
Message-ID: <3EABB532.5000101@superbug.demon.co.uk>
Date: Sun, 27 Apr 2003 11:47:14 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
Reply-To: James@superbug.demon.co.uk
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug in linux kernel when playing DVDs.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have found a bug in the linux kernel when it plays DVDs. I use xine
(xine.sf.net) for playing DVDs.
At some point during the playing there is an error on the DVD. But
currently this error is not handled correctly by the linux kernel.
This puts the kernel into an uncertain state, causing the kernel to take
100% CPU and fail all future read requests.

One way to exit this "uncertain state" is to push a pin into the small
hole on the front of all DVD drive. This causes the kernel to sense
"tray open", which it knows about, and handles correctly. After this,
the kernel releases it's grab on the CPU and linux runs normally again.
Please see kern.log extract for more details.

What is error 0x34 ? Does anyone know how we should handle it, because
the current method for handling it is obviously wrong.
I am 100% sure that the application does not ask for out of range
sectors, because I have debugged that far. I have now compiled the
ide-cd as a kernel module, so I could add kprintf's to the kernel source
if that helps give more information.

Currently, I cannot find document that will explain what error 0x34 is.
Can anybody help ?

Cheers
James

Apr 26 17:15:55 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:00 games kernel: hdd: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Apr 26 17:16:00 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:05 games kernel: hdd: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Apr 26 17:16:05 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:10 games kernel: hdd: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Apr 26 17:16:10 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:10 games kernel: hdd: ATAPI reset complete
Apr 26 17:16:15 games kernel: hdd: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Apr 26 17:16:15 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:20 games kernel: hdd: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Apr 26 17:16:20 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:24 games kernel: hdd: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Apr 26 17:16:24 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:24 games kernel: hdd: ATAPI reset complete
Apr 26 17:16:25 games kernel: end_request: I/O error, dev 16:40 (hdd),
sector 7750464
Apr 26 17:16:29 games kernel: hdd: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Apr 26 17:16:29 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:34 games kernel: hdd: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Apr 26 17:16:34 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:39 games kernel: hdd: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Apr 26 17:16:39 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:44 games kernel: hdd: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Apr 26 17:16:44 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:44 games kernel: hdd: ATAPI reset complete
Apr 26 17:16:49 games kernel: hdd: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Apr 26 17:16:49 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:54 games kernel: hdd: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Apr 26 17:16:54 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:59 games kernel: hdd: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Apr 26 17:16:59 games kernel: hdd: cdrom_decode_status: error=0x34
Apr 26 17:16:59 games kernel: hdd: ATAPI reset complete
Apr 26 17:16:59 games kernel: end_request: I/O error, dev 16:40 (hdd),
sector 7750468
Apr 26 17:16:59 games kernel: hdd: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }

"I use the PIN here"

Apr 26 17:16:59 games kernel: hdd: cdrom_decode_status: error=0xb4
Apr 26 17:16:59 games kernel: hdd: tray open
Apr 26 17:16:59 games kernel: end_request: I/O error, dev 16:40 (hdd),
sector 7750472
Apr 26 17:16:59 games kernel: hdd: tray open
Apr 26 17:16:59 games kernel: end_request: I/O error, dev 16:40 (hdd),
sector 7750476
Apr 26 17:16:59 games kernel: hdd: tray open
Apr 26 17:16:59 games kernel: end_request: I/O error, dev 16:40 (hdd),
sector 7750480
Apr 26 17:16:59 games kernel: hdd: tray open
Apr 26 17:16:59 games kernel: end_request: I/O error, dev 16:40 (hdd),
sector 7750484
Apr 26 17:16:59 games kernel: hdd: tray open

-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



