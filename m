Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262970AbREWDWE>; Tue, 22 May 2001 23:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262968AbREWDVy>; Tue, 22 May 2001 23:21:54 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35492 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262967AbREWDVl>;
	Tue, 22 May 2001 23:21:41 -0400
Message-ID: <3B0B2CBA.19D081C9@mandrakesoft.com>
Date: Tue, 22 May 2001 23:21:30 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <Pine.LNX.4.21.0105221936030.4713-100000@penguin.transmeta.com> <3B0B28A9.7556908D@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> /dev/sda <-> partition_blkdev <-> /dev/disk{0,1,2,3,4}
> /dev/hda <-> partition_blkdev <-> /dev/disk{5,6,7}

I also point out that handling disk partitions as a -tiny- remapping
blkdev also has the advantage of making it easy to have a single request
device per hardware device (a simple remap shouldn't require its own
request queue, right?), while remapping devices flexibility to do their
own request queue management.


> I do grant you that an offset at bh submit time is faster, but IMHO
> partitions -not- as a remapping blkdev are an ugly special case.

think of the simplifications possible, when partitions are just another
block device, just like anything else...  No special partitions arrays
in the lowlevel blkdev, etc.
