Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315887AbSEGQOA>; Tue, 7 May 2002 12:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315888AbSEGQN7>; Tue, 7 May 2002 12:13:59 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:33408 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S315887AbSEGQN6>;
	Tue, 7 May 2002 12:13:58 -0400
Date: Tue, 7 May 2002 18:13:57 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: Fwd: NLS mappings for iso-8859-* encodings
Message-ID: <20020507161357.GC15298@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I sent message below to linux-fsdevel yesterday, but I received no
feedback. Meanwhile I also created patch which does changes proposed
below (map 0x80-0x9F to unicode 0x80-0x9F for ISO encodings).
Patch is available at http://platan.vc.cvut.cz/nls3.patch (39KB).

  If I'll not receive any feedback, I plan to send it to Linus soon.
Currently if you'll mount NCP filesystem with accented characters
without proper iocharset/codepage options, you'll not see filenames
with accented characters at all, as they will not pass through
char2uni of default (iso8859-1) NLS (there was warning printk,
but it was way to DoS...).

  I do not want to use way SMB does (map unknown characters to
:x## string) as it is not trivial to map them back. But if you
think that it is correct that some NLS tables contain characters
without unicode equivalents...
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

----- Forwarded (typos cleared) message -----

Resent-Message-Id: <200205071658.RAA26606@zikova.cvut.cz>
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization:  CC CTU Prague
To: linux-fsdevel@vger.kernel.org
Subject:       NLS mappings for iso-8859-* encodings
X-Mailing-List: 	linux-fsdevel@vger.kernel.org

Hi,
  today it was pointed to me (see Debian bugreport #145654,
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=145654) that
all nls_iso8859-* mappings available in kernel refuse to map
characters in range 0x80-0x9F to anything reasonable.

  This behavior means, that with NLS default set to any of
iso8859-* encoding (including default iso-8859-1) filesystems
which contain data in cp850/852/437 codepages will have bad
problems, as majority of accented characters live in 0x80-0x9F
range in these codepages.

  And worse is that old 2.2.x kernels defaulted to 1:1 mapping,
so people were used to see wrong accented characters, but all filenames.
Now they see nothing :-( 

  Is there any reason why 0x80-0x9F range is not mapped identically
to 0x80-0x9F unicode range? I believe that unicode is even defined
as having first 256 characters identical to iso8859-1.
                                                Thanks,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

----- End forwarded message -----
