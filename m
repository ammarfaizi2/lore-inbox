Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbRFUOUM>; Thu, 21 Jun 2001 10:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbRFUOUD>; Thu, 21 Jun 2001 10:20:03 -0400
Received: from noc242.toshiba-eng.co.jp ([210.254.22.242]:47500 "EHLO
	noc4.toshiba-eng.co.jp") by vger.kernel.org with ESMTP
	id <S264983AbRFUOTw>; Thu, 21 Jun 2001 10:19:52 -0400
Date: Thu, 21 Jun 2001 23:19:39 +0900
From: Masaru Kawashima <masaru@scji.toshiba-eng.co.jp>
To: Dionysius Wilson Almeida <dwilson@technolunatic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100: wait_for_cmd_done timeout
Message-Id: <20010621231939.757bddd6.masaru@scji.toshiba-eng.co.jp>
In-Reply-To: <20010620163134.A22173@technolunatic.com>
In-Reply-To: <20010620163134.A22173@technolunatic.com>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.9; i586-pc-linux-gnu)
Organization: Open Software Sec.
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__21_Jun_2001_23:19:39_+0900_08750ac0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Thu__21_Jun_2001_23:19:39_+0900_08750ac0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

On Wed, 20 Jun 2001 16:31:34 -0700
Dionysius Wilson Almeida <Dionysius Wilson Almeida <dwilson@technolunatic.com>> wrote:
> Jun 20 16:14:07 debianlap kernel: eepro100: wait_for_cmd_done timeout!
> Jun 20 16:14:38 debianlap last message repeated 5 times

I saw the same message.

The comment before wait_for_cmd_done() function in
linux/drivers/net/eepro100.c says:
/* How to wait for the command unit to accept a command.
   Typically this takes 0 ticks. */

And the initial value for the bogus counter, named "wait", is 1000.
Is it enough for your machine?

I applied attached patch, eepro100.patch.  After that, I've never seen
the message from wait_for_cmd_done().  And, my NIC works fine.

You may want to adjust the initial value for the bogus counter.
I don't know the appropriate value for this bogus counter.

I hope this helps you.

-- 
Masaru Kawashima
--Multipart_Thu__21_Jun_2001_23:19:39_+0900_08750ac0
Content-Type: application/octet-stream;
 name="eepro100.patch"
Content-Disposition: attachment;
 filename="eepro100.patch"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNC41L2RyaXZlcnMvbmV0L2VlcHJvMTAwLmMub3JnCVdlZCBGZWIgMTQgMDY6
MTU6MDUgMjAwMQorKysgbGludXgtMi40LjUvZHJpdmVycy9uZXQvZWVwcm8xMDAuYwlUaHUgSnVu
IDIxIDE2OjMzOjAwIDIwMDEKQEAgLTMxMCw3ICszMTAsOSBAQAogewogCWludCB3YWl0ID0gMTAw
MDsKIAlkbyAgIDsKLQl3aGlsZShpbmIoY21kX2lvYWRkcikgJiYgLS13YWl0ID49IDApOworCXdo
aWxlKGluYihjbWRfaW9hZGRyKSAmJiAtLXdhaXQgPj0gMCl7CisJCXVkZWxheSgxKTsKKwl9CiAj
aWZuZGVmIGZpbmFsX3ZlcnNpb24KIAlpZiAod2FpdCA8IDApCiAJCXByaW50ayhLRVJOX0FMRVJU
ICJlZXBybzEwMDogd2FpdF9mb3JfY21kX2RvbmUgdGltZW91dCFcbiIpOwo=

--Multipart_Thu__21_Jun_2001_23:19:39_+0900_08750ac0--
