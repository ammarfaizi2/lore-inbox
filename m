Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279326AbRKSCqM>; Sun, 18 Nov 2001 21:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281885AbRKSCqD>; Sun, 18 Nov 2001 21:46:03 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:6528 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S279326AbRKSCps>; Sun, 18 Nov 2001 21:45:48 -0500
Date: Sun, 18 Nov 2001 20:48:19 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: st.c SCSI Tape ioctl() bug
Message-ID: <20011118204819.A968@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kai/Linux,

The ioctl() function to enable/disable code 15 comrpession has 
some problems.  I have a fix to the code, but it does not 
always seem to work properly, so I think you should do this 
review.  

If you call the ioctl() tape command from kernel space to 
enable and disable **DEFAULT** compression (not MTCOMPRESSION
ioctl, the MT_ST_DEF_COMPRESSION code path) there is a case
where the default_compression/compression_changed flags
can horribly out of sync.

Please take a look at this code.  We have gotten around it 
by simply calling MTCOMPRESSION everytime we need to use it,
however, but the other path seems busted, and it would be 
nice for it to work properly.

Thanks,

Jeff

