Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132513AbRDWWoM>; Mon, 23 Apr 2001 18:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132500AbRDWWn7>; Mon, 23 Apr 2001 18:43:59 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:48656 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132512AbRDWWnk>; Mon, 23 Apr 2001 18:43:40 -0400
Date: Mon, 23 Apr 2001 16:37:25 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: NWFS broken on 2.4.3 -- someone removed WRITERAW
Message-ID: <20010423163725.C1131@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hey guys,

Whomever removed WRITERAW has broken NWFS.  WRITE requests call
_refile_buffer() after the I/O request and take my locally created 
buffer heads and munge them back into the linux buffer cache, causing
massive memory corruption in the system.  These buffers don't belong 
in Linus' buffer cache, they are owned by my LRU and ll_rw_block 
should not be blindly filing them back into the buffer cache.

Please put something back in to allow me to write without the buffer
heads always getting filed into Linus' buffer cache.  This has 
broken NWFS on 2.4.3 and above.

As for using Linus' buffer cache, until you put in the ability to 
create logical block mapping instead of physical, I will not be 
able to use it.  Hopefully, this will make it in 2.5.  I have some 
folks trying to use this with 2.4.3 and they are dead in the water
until this gets addressed.

Thanks

Jeff
