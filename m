Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbRF2Lgs>; Fri, 29 Jun 2001 07:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265866AbRF2Lgi>; Fri, 29 Jun 2001 07:36:38 -0400
Received: from mail.bmlv.gv.at ([193.171.152.34]:19152 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S265865AbRF2Lg3>;
	Fri, 29 Jun 2001 07:36:29 -0400
Message-Id: <3.0.6.32.20010629133915.0091e470@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Fri, 29 Jun 2001 13:39:15 +0200
To: linux-kernel@vger.kernel.org
From: "Ph. Marek" <marek@bmlv.gv.at>
Subject: Q: sparse file creation in existing data?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

though looking and grepping through the sources I couldn't find a way (via
fcntl() or whatever) to allow an existing file to get holes.

I found that cp has a parameter --sparse (or suchlike) - but strace shows
it doing a open(,O_TRUNC) which has a bit of impact on previous filedata :-)


What I'd like to do is something like

  fh=open( ... , O_RDWR);
  lseek(fh, position ,SEEK_START); 
// where position is a multiple of fs block size
  fcntl(fh,F_MAKESPARSE,16384);

to create a 16kB hole in a file.
If the underlying fs doesn't support holes, I'd get ENOSYS or something.


What I'd like to use that for:

I imagine having a file on hd (eg. tar) and not enough space to decompress.
So with SOME space at least I'd open the file and stream it's data to tar,
after each few kB read I'd free some space - so this could eventually succeed.

I also thought about simple reversing the filedata - so I'd read off the
end of the file and truncate() downwards - but that would mean reversing
the whole file which could take some time on creation and would solve only
this specific case.


Ideas, anyone?


Regards,

Phil

