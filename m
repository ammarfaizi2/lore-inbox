Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268772AbUHTWGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268772AbUHTWGh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 18:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268775AbUHTWGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 18:06:36 -0400
Received: from lakermmtao07.cox.net ([68.230.240.32]:5260 "EHLO
	lakermmtao07.cox.net") by vger.kernel.org with ESMTP
	id S268772AbUHTWGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 18:06:04 -0400
In-Reply-To: <4125FFA2.nail8LD61HFT4@burner>
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <4124BA10.6060602@bio.ifi.lmu.de> <1092925942.28353.5.camel@localhost.localdomain> <200408191800.56581.bzolnier@elka.pw.edu.pl> <4124D042.nail85A1E3BQ6@burner> <1092938348.28370.19.camel@localhost.localdomain> <4125FFA2.nail8LD61HFT4@burner>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <101FDDA2-F2F5-11D8-8DEC-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       fsteiner-mail@bio.ifi.lmu.de, kernel@wildsau.enemy.org,
       diablod3@gmail.com, B.Zolnierkiewicz@elka.pw.edu.pl
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Fri, 20 Aug 2004 18:05:35 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 20, 2004, at 09:41, Joerg Schilling wrote:
>> While Sun did spend a year refusing to fix security holes I found -  
>> for
>> "compatibility reasons" - long ago back when I was a sysadmin at NTL,
>> the Linux world does not work that way.
>
> Unless you tell us what kind of "security holes" you found _and_ when 
> this has
> been, it looks like a meaningless remark.

Further discussion on such a topic is irrelevant.  There is at least 
one case
where a vendor has chosen compatibility over security (*cough* *cough*
Windows *cough*).  From the previous emails on the issue, the general
opinion of most Linux developers is to choose security over 
compatibility,
after all, with free software users are free to fix the 
bugs/incompatibilities
themselves.

Security issue:
	Anybody with read access to certain block devices (Like CD-RW
drives.) could reflash the firmware or otherwise turn the drive into a
rather expensive doorstop.

Chosen solution for 2.6.8.1:
	Only allow certain known-safe commands, anything else needs
root privileges, specifically CAP_SYS_RAWIO or CAP_SYS_ADMIN,
  (Seems sane, and follows with the general design of the  rest of the
kernel).

Problems with the solution:
	It breaks software, *whine*!  Well, if Microsoft suddenly fixed all
the remaining security flaws in its software, almost _all_ Windows
software would break, because they depend on silly things like writable
files on the root of the C drive.  Just because software does something
doesn't mean it's secure.

Personally, I'd rather have a setuid executable on my system than
allow anybody in the cdwriters group to reflash my CDROM drive. For
you there is a _really_ simple solution akin to the warning message
that already exists in linuxcheck(), if the version is >= 2.6.8, just 
tell
the user that it's unsupported and won't work without a patched
kernel.  That's a change that could even go in during a code freeze!

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


