Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276347AbRJHFC6>; Mon, 8 Oct 2001 01:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276429AbRJHFCs>; Mon, 8 Oct 2001 01:02:48 -0400
Received: from c009-h019.c009.snv.cp.net ([209.228.34.132]:56518 "HELO
	c009.snv.cp.net") by vger.kernel.org with SMTP id <S276347AbRJHFCi>;
	Mon, 8 Oct 2001 01:02:38 -0400
X-Sent: 8 Oct 2001 05:02:20 GMT
Date: Sun, 7 Oct 2001 22:03:15 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@desktop>
To: <linux-kernel@vger.kernel.org>
Subject: Throttling DVD spin rate on powerbook
Message-ID: <Pine.LNX.4.33.0110072131330.1879-100000@desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

A few months ago I tried to change the kernel to allow changing the spin
rate of my DVD drive.  Normally this is done with hdparm -E n where n is
the spin rate.  But, the drive expects a SET STREAMING command (Mt.  Fuji
rev. 0.90 section 13.44) where the kernel is currently sending a SET CD
SPEED command.

So far my attempts to make the kernel send the SET STREAMING command have
resulted only in resetting the ATA bus.  That's bad :(

The thing that I'm not clear on is that the specification calls for a
28-byte performance descriptor to be sent along with the command.  The SET
CD SPEED command doesn't require this.  For SET STREAMING, the performance
descriptor tells the beginning and ending blocks of relevance, and the
requested reading and writing speeds.

I'm really not clear about how to send this extra 28-byte payload along
with the command.  It seems like I should be able to just stick it in
pc.buffer, set pc.buflen to 28, and send it down the chute with
cdrom_queue_packet_command(), but as I've said the only result to date has
been to reset the ATA bus.

I appreciate any help you guys can throw out.

-jwb

