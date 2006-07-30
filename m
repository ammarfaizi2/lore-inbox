Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWG3L11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWG3L11 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWG3L11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:27:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:26924 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932211AbWG3L10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:27:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=KfZkB5EuCIQmMMEQsuc95a2vc4rlYYjb1FLcojoboJiDBhKsoPs0m3oFU1Um2s3NGX/2MTmxMBYbZpoDus3xUBI6TxttLLrbGRUQAY93S5iL5ZxqNi9vKmsAK6RUHZvW4ERrbb/SeHtN25jVwHyhpeg1StZgPGP76pWqO5I6AZU=
Message-ID: <44CC97A4.8050207@gmail.com>
Date: Sun, 30 Jul 2006 13:27:09 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: FP in kernelspace
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a driver written for 2.4 + RT patches with FP support. I want it to work 
in 2.6. How to implement FP? Has anybody developped some "protocol" between KS 
and US yet? If not, could somebody point me, how to do it the best -- with low 
latency.
The device doesn't generate irqs *), I need to quickly respond to timer call, 
because interval between two posts of data to the device has to be equal as much 
as possible (BTW is there any way how to gain up to 5000Hz).
I've one idea: have a thread with RT priority and wake the app in US waiting in 
read of character device when timer ticks, post a struct with 2 floats and 
operation and wait in write for the result. App computes, writes the result, we 
are woken and can post it to the device. But I'm afraid it would be tooo slow.

*) I don't know how to persuade it (standard PLX chip with unknown piece of 
logic behind) to generate, because official driver is closed and _very_ 
expensive. Old (2.4) driver was implemented with RT thread and timer, where FP 
is implemented within RT and computed directly in KS.

So 2 questions are:
1) howto FP in kernel
2) howto precise timer (may mingo RT patches help?)
3) any way to have faster ticks (up to 5000Hz)?

Any suggestions, please?

thanks,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
