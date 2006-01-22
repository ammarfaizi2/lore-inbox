Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWAVUKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWAVUKk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWAVUKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:10:40 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:20277 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751334AbWAVUKj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:10:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d6dRi028Nt3ny2rcReGp9RI7LtWjVyRZmyzGFRnw5b8Uba1PielDGzePirfzLW3jCuqJlrQRk5OOuRqsB3TTdhmMyOikHjXzPoxiSRUvXZPA9olrPehU0+DUQAmWkROGHpxXZrX20g1xsEgIBpZ1v5kAl34yzQEMO1HZyZqgWrw=
Message-ID: <25ac9de40601221210q143ba21arf5f442f6321b9db8@mail.gmail.com>
Date: Sun, 22 Jan 2006 14:10:38 -0600
From: Patrick Read <pread99999@gmail.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: FIXED: re: PROBLEM: 2.6.15 Oops in USBHID (good news)
Cc: pread99999@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Andrew asked me to test the 2.6.16-rc1 in regards to an Oops I got at
bootup in 2.6.15 a few weeks ago.

The error was due to a null pointer dereferencing in the USB HID code
(drivers/usb/input/pid.c line 262):

OLD (error) code:
struct hid_input *hidinput = list_entry(&hid->inputs, struct hid_input, list);

NEW (fixed) code:
struct hid_input *hidinput = list_entry(hid->inputs.next, struct
hid_input, list);

The code fix is indeed in 2.6.16-rc1 and the Oops on bootup doesn't
happen on my system anymore with 2.6.16-rc1.

The original debug and Oops messages are still available online in
case anyone doesn't have anything more interesting to read... ;-)

http://www.cs.txstate.edu/~patrick/kernel-debug/

Regards,
Patrick
