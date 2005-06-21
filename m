Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVFUIyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVFUIyu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVFUIOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:14:40 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:38366 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261602AbVFUHPZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:15:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=N42Zw9PGMeB6bYOHj9Ue7PmmelhdkMWeyp25ZR5D4PxX0uo8uOxcKGc5wLLfvY9oAnlInH56Kpg11QLEKa+C6ZmA3GGYg9KeMN54dJisclSVDfHOTLoXYEI9Ywq5jqhApjUsGyvYX8jJ9t+9GbmP74eJLCmLZkUzGPvMq29wRNQ=
Message-ID: <699a19ea05062100157c17c09c@mail.gmail.com>
Date: Tue, 21 Jun 2005 12:45:20 +0530
From: k8 s <uint32@gmail.com>
Reply-To: k8 s <uint32@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: struct iphdr in include/linux/ip.h (probably bug in headerfile)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following definition in linux/include/ip.h is creating problems.

How does Endianness affect BIT ORDER 
IT affetc only  BYTE ORDER
------------------------------------------------------------------------
struct iphdr {
#if defined(__LITTLE_ENDIAN_BITFIELD)
        __u8    ihl:4,
                version:4;
#elif defined (__BIG_ENDIAN_BITFIELD)
        __u8    version:4,
                ihl:4;
--------------------------------------------------------------------------
Here I have a network device which works on both little endian and big
endian machines.
I found out that the driver of the device was saying unrecognizable
packet when i assign
strcut iphdr *ip;
ip->version=4
ip->ihl=5
on bigendian machines.
It is because the two fields are swapped and start of the iphdr is 5
instead of 4.
The device is seeing 5 at the version and saying neither ipv4 nor ipv6
packet found.
I had to do the following to remove the error

*((unsigned char*)ip) = 0x45;

Had anyone noticed IT

S Kartikeyan
