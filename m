Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132387AbRDQRJR>; Tue, 17 Apr 2001 13:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132521AbRDQRJH>; Tue, 17 Apr 2001 13:09:07 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:20714 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S132773AbRDQRHx>; Tue, 17 Apr 2001 13:07:53 -0400
Date: Tue, 17 Apr 2001 19:07:48 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, pavel@janik.cz,
        linux-kernel@vger.kernel.org
Subject: Re: Possible problem with zero-copy TCP and sendfile()
Message-ID: <20010417190748.A2591015@informatics.muni.cz>
In-Reply-To: <20010417151007.F916@informatics.muni.cz> <20010417164103.A9515@gruyere.muc.suse.de> <20010417175003.D2589096@informatics.muni.cz> <20010417175916.A11824@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010417175916.A11824@gruyere.muc.suse.de>; from ak@suse.de on Tue, Apr 17, 2001 at 05:59:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
: I guess to debug this problem it would be useful to get some idea about the
: nature of the corruption. Could you enable sendfile() again, and when a 
: user complains ask to download it again and provide a 
: cmp -cl fileA fileB | head -500 listing of their differences? 

	Well, here it is:

$ cmp -cl seawolf-sendfile.iso seawolf-i386-SRPMS.iso
160628609   0 ^@   276 M->
160628610   0 ^@    32 ^Z
160628611   0 ^@    14 ^L
160628612   0 ^@    55 -
160628613   0 ^@   116 N
160628614   0 ^@   300 M-@
160628615   0 ^@   150 h
160628616   0 ^@   210 M-^H
160628617   0 ^@   271 M-9
160628618   0 ^@   307 M-G
160628619   0 ^@   377 M-^?
[ all bytes in sendfile()d image changed to zero until: ]
160661374   0 ^@   376 M-~
160661375   0 ^@   231 M-^Y
160661376   0 ^@   205 M-^E
160661377   1 ^A   364 M-t
160661378 103 C    277 M-?
160661379 104 D     13 ^K
160661380  60 0     50 (
160661381  60 0    360 M-p
160661382  61 1     77 ?
160661383   1 ^A   304 M-D
160661384   0 ^@   133 [
160661385 114 L    131 Y
160661386 111 I    377 M-^?
160661387 116 N    123 S
160661388 125 U    234 M-^\
160661389 130 X    250 M-(

	Which simply means, that at 160628609 it started to send
the CD image from the beginning. Yes, the original image contains 0x8000 zeros,
and then the text "\001CD001\001\000LINUX".

	So it has probably nothing to do with 3c59x driver, but with sendfile()
or ProFTPd's use of sendfile().

	If anybody wants to test it, I've left running ProFTPd with sendfile()
enabled at ftp.linux.cz, port 2121.

	Thanks,

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
///... in B its 'extrn' not 'extern'.        Alan (yes I programmed in B)\\\

