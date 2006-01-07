Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWAGHD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWAGHD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 02:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWAGHD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 02:03:28 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:62841 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030320AbWAGHD1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 02:03:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=beOp4eHkxKotoQL7PkuUohoc9ZWOSWnNuxOR0blrXiqkQgy1a+MltI5GFdTx97ZeiqPjtld19+2oy+OL6XWRuJ4SGKy3WWH6zO4RFksD2DOr8c6uoZrCCfTweTQkmbyuJZgSGNm8+WPUIi+YjleHC53O4bX0iZvtA+GG34sfOVM=
Message-ID: <f69849430601062303n331ab0aaue8635f69d75d8510@mail.gmail.com>
Date: Fri, 6 Jan 2006 23:03:26 -0800
From: kernel coder <lhrkernelcoder@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Almost 80% of UDP packets dropped
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
    I was trying to measure the UDP reception speed on my borad which
has MIPS 4kc processor with 133 MHZ speed.I was transfering 10mb file
from intel pentium 4 machine to MIPS board,but the recieved file was
only 900kB.

When i further investigated the problem ,i came to know that the user
application was not getting enough opportunities to get data from
socket queue which caused almost 80% of packets to be dropped as
socket queue had no free space.

When i increased the socket recieve buffer size,it resulted in
increase in no. of packets recieved .When i slow slowed down the
transmitter , it also caused more packets to be recieved.

But the above mentioned mechanism only decreased no. of lost
packets.But there was no way that i could increase UDP reception speed
because the user application was not getting enough opportunities to
read packets in burst of UDP packets.

I noticed that user application started recieveing packets after
Kernel had recieved all the UDP packets.

Please tell me how can i make sure that user application or udp client
running MIPS 4kc processor gets enough opportunities to dequeue
packets from socket buffer so that lost of packets could be reduced to
minimal and also the size of UDP recieved file in a specific interval
of time could be increased.

lhrkernelcoder
