Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135483AbRDSAEG>; Wed, 18 Apr 2001 20:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135485AbRDSAD4>; Wed, 18 Apr 2001 20:03:56 -0400
Received: from femail1.sdc1.sfba.home.com ([24.0.95.81]:11250 "EHLO
	femail1.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S135483AbRDSADr>; Wed, 18 Apr 2001 20:03:47 -0400
Date: Wed, 18 Apr 2001 08:04:35 -0400
From: kambo@home.com
X-Mailer: The Bat! (v1.41) UNREG / CD5BF9353B3B7091
Reply-To: kambo@home.com
X-Priority: 3 (Normal)
Message-ID: <10336.010418@home.com>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_PACKET_MMAP help
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I upgrading an application to the CONFIG_PACKET_MMAP
interface, and was trying to figure out how the api works.  I 'RTFS'
But had a few questions:

1. for tp_frame_size, I dont want to truncate any data on ethernet, I
need 1514 bytes, is this the best way to do it and not waste space?

static const int  TURBO_FRAME_SIZE=TPACKET_ALIGN(TPACKET_ALIGN(sizeof(tpacket_hdr))+TPACKET_ALIGN(sizeof(struct sockaddr_ll)+ETH_HLEN) + 1500);

2. what is tp_block_nr for?  I dont understand it, I just set it to 1
and make tp_block_size big enough for all the frames I need, so its
just one contiguous space, all I need is about a megabyte I think.

3. is this the general approach for the api?

open socket
set ring size
mmap()

h starts at frame[0] of the mmaped area
while(1) {
   if (tp->status == 0) poll() for pollin on the socket  /* is there a
   race here? */
   parse/copy out what I want from h + h->tp_mac
   set tp->status to 0 when I am done
   h = next packet in ring, or wraps
}

4. what does the copy threshold setsockopt tuning accomplish? doesnt it always
have to copy anyway, to the mmaped area?

Thanks,
c.c. me por favor...

K. Lohan
------------------------
kambo at home dawt com


