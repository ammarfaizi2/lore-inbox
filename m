Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264458AbRFTApc>; Tue, 19 Jun 2001 20:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264461AbRFTApW>; Tue, 19 Jun 2001 20:45:22 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:55206 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S264458AbRFTApJ>; Tue, 19 Jun 2001 20:45:09 -0400
Date: Tue, 19 Jun 2001 18:45:01 -0600
Message-Id: <200106200045.f5K0j1B18267@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Bind oddity/trap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, Al. Here's an oddity I just ran across with VFS bindings:

# mkfifo /dev/modem   (BTW: it would be nice not to have to make the node)
# mount --bind /dev/tts/0 /dev/modem
# kermit
kermit> set line /dev/modem
kermit> set speed 4800
?Sorry, you must SET LINE first

The reason this is happening is because Kermit will do a readdir(2),
scanning /dev for a node with the same inum as it gets from fstat(2).
In this case, fstat(2) is giving the inum of /dev/tts/0, which is of
course the correct behaviour. However, the d_ino field from readdir(2)
is giving the inum of the "mount point" (the FIFO I created). So there
is an inconsistency, and kermit gets confused.

Perhaps readdir(2) should return the same inum as fstat(2) does? I
realise that could be quite nasty to implement. However, it is an
inconsistency, and a potential trap. But there probably isn't a good
solution to this one.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
