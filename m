Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbVJGOZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVJGOZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbVJGOZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:25:58 -0400
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:10915 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S964873AbVJGOZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:25:57 -0400
X-AntiVirus: PTMail-AV 0.3.87
Date: Fri, 7 Oct 2005 15:25:47 +0100
From: Jose Celestino <japc@co.sapo.pt>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'Undeleting' an open file
Message-ID: <20051007142546.GC4404@co.sapo.pt>
Mail-Followup-To: Giuseppe Bilotta <bilotta78@hotpop.com>,
	linux-kernel@vger.kernel.org
References: <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca> <4343E7AC.6000607@perkel.com> <20051005153727.994c4709.fmalita@gmail.com> <43442D19.4050005@perkel.com> <Pine.LNX.4.58.0510052208130.4308@be1.lrz> <8qo997np4h6n.1ihs13ptrx2y2.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8qo997np4h6n.1ihs13ptrx2y2.dlg@40tude.net>
X-URL: http://xpto.org/~japc
X-System: Linux morgoth.sl.pt 2.6.13
X-By: japc@morgoth.sl.pt
X-GPG-key-ID: 0x07B1363B
X-GPG-key-Fingerprint: D3F3 B47B F20C 3B1E 488C B949 1B8B 8141 07B1 363B
User-Agent: mutt-ng/devel-r445 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Words by Giuseppe Bilotta [Fri, Oct 07, 2005 at 04:14:27PM +0200]:
> On Wed, 5 Oct 2005 23:05:34 +0200 (CEST), Bodo Eggert wrote:
> 
> > Files are deleted if the last reference is gone. If you play a music file
> > and unlink it while it's playing, it won't be deleted untill the player
> > closes the file, since an open filehandle is a reference.
> 
> BTW, I've always wondered: is there a way to un-unlink such a file?
> 

Well, you can go to /proc/$PID_OF_PROCESSING_OPENING_THE_FILE/fd/

do an ls -la, identify the fd of the file deleted but still open
and do a cp $FD ~/my_deleted_file

Example:

[japc@morgoth:/proc/3743/fd]$ ls -al
total 4
dr-x------  2 japc japc  0 Oct  7 15:25 .
dr-xr-xr-x  4 japc japc  0 Oct  7 15:23 ..
lr-x------  1 japc japc 64 Oct  7 15:25 0 -> /dev/null
l-wx------  1 japc japc 64 Oct  7 15:25 1 -> /home/japc/.xsession-errors
l-wx------  1 japc japc 64 Oct  7 15:25 2 -> /home/japc/.xsession-errors
lr-x------  1 japc japc 64 Oct  7 15:25 255 -> /usr/bin/startkde
[japc@morgoth:/proc/3743/fd]$ cp 255 ~/startkde


-- 
Jose Celestino | http://xpto.org/~japc/files/japc-pgpkey.asc
----------------------------------------------------------------
"Thus the metric system did not really catch on in the States, unless you count
the increasing popularity of the nine-millimeter bullet." -- Dave Barry
