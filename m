Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbUK0HGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUK0HGO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 02:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbUK0HFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 02:05:02 -0500
Received: from zeus.kernel.org ([204.152.189.113]:32190 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261272AbUKZTIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:08:14 -0500
Message-ID: <48406.194.39.131.40.1101374546.squirrel@noto.dyndns.org>
In-Reply-To: <20041125080451.GE10233@suse.de>
References: <33356.192.168.0.2.1101334593.squirrel@192.168.0.10>
    <20041125080451.GE10233@suse.de>
Date: Thu, 25 Nov 2004 10:22:26 +0100 (CET)
Subject: Re: Re: Is controlling DVD speeds via SET_STREAMING supported?
From: "Thomas Fritzsche" <tf@noto.de>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Thomas Fritzsche" <tf@noto.de>, linux-kernel@vger.kernel.org,
       david@2gen.com
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

absolute correct! I just tested it with speed = 1 yesterday night
(quick&duty). This is just a code snap to show that it's possible to set
the speed of a DVD drive this way.

You also wrote about the "End LBA" field in your other mail.
I set this to 0xffffffff but you think that this could be a problem if the
device don't have this LBA. The spec only writes this:
"The End LBA field is the last logical block for which the performance
request is being made." So it should be standard conform if we set here a
higher block number. Do you have experience with other (than NEC ND-3500)
drive that don't support this?

Using this high last block number would make sence, because it looks like
this setting is still valid if the media is changed (other end block!?).

Spec:
"The performance setting is persistent and remains until a new descriptor
is sent. The setting only applies to the extent
identified by the Start and End LBA field. Only zero or one performance
extents shall be valid at any time."

What do you think?

I also found out, that the Realtime-Streaming Feature is mandatory
for all kinds of DVD-+R+-RW-RAM drives. So it might be sufficient to
simply use SET STREAMING for DVD drives and SET SPEED for CD-R's. Isn't
it?

I will also enhance this tool by setting the RDD flag if the user selects
speed = 0.

Thanks and kind regards,
 Thomas Fritzsche

> I should have read this more closely... You need to fill the speed
> fields correctly:
>
> 	unsigned long read_size = 177 * speed;
>
> 	buffer[12] = (read_size >> 24) & 0xff;
> 	buffer[13] = (read_size >> 16) & 0xff;
> 	buffer[14] = (read_size >>  8) & 0xff;
> 	buffer[15] = read_size & 0xff;
>
> Ditto for write size.
>
> --
> Jens Axboe
>
>


