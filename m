Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVJGOaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVJGOaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVJGOaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:30:19 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:38767 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964872AbVJGOaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:30:18 -0400
From: Ian Campbell <ijc@hellion.org.uk>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8qo997np4h6n.1ihs13ptrx2y2.dlg@40tude.net>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	 <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
	 <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca>
	 <4343E7AC.6000607@perkel.com> <20051005153727.994c4709.fmalita@gmail.com>
	 <43442D19.4050005@perkel.com> <Pine.LNX.4.58.0510052208130.4308@be1.lrz>
	 <8qo997np4h6n.1ihs13ptrx2y2.dlg@40tude.net>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 15:30:00 +0100
Message-Id: <1128695400.28620.42.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.3.3
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: Re: 'Undeleting' an open file
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-07 at 16:14 +0200, Giuseppe Bilotta wrote:
> On Wed, 5 Oct 2005 23:05:34 +0200 (CEST), Bodo Eggert wrote:
> 
> > Files are deleted if the last reference is gone. If you play a music file
> > and unlink it while it's playing, it won't be deleted untill the player
> > closes the file, since an open filehandle is a reference.
> 
> BTW, I've always wondered: is there a way to un-unlink such a file?

Access via /proc/PID/fd/* seems to work:

$ echo "Hello World" > testing
$ exec 10>>testing
$ rm testing
$ ls -l /proc/self/fd/
total 5
lrwx------  1 icampbell icampbell 64 Oct  7 15:28 0 -> /dev/pts/9
lrwx------  1 icampbell icampbell 64 Oct  7 15:28 1 -> /dev/pts/9
l-wx------  1 icampbell icampbell 64 Oct  7 15:28 10
-> /home/icampbell/testing (deleted)
lrwx------  1 icampbell icampbell 64 Oct  7 15:28 2 -> /dev/pts/9
lr-x------  1 icampbell icampbell 64 Oct  7 15:28 3 -> /proc/31390/fd/
$ cat /proc/self/fd/10
Hello World
$

Ian.
-- 
Ian Campbell
Current Noise: Rotting Christ - In Domine Sathana

I may not be totally perfect, but parts of me are excellent.
		-- Ashleigh Brilliant

