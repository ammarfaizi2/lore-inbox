Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313453AbSDGT5P>; Sun, 7 Apr 2002 15:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313455AbSDGT5O>; Sun, 7 Apr 2002 15:57:14 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:60422 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S313453AbSDGT5N>; Sun, 7 Apr 2002 15:57:13 -0400
Date: Sun, 7 Apr 2002 22:55:04 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Steven N. Hirsch" <shirsch@adelphia.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Message-ID: <20020407225504.Z10733@actcom.co.il>
In-Reply-To: <20020407173343.GA18940@compsoc.man.ac.uk> <E16uIf7-0006Zw-00@the-village.bc.nu> <20020407194114.GA21800@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 08:41:14PM +0100, John Levon wrote:
> On Sun, Apr 07, 2002 at 08:49:17PM +0100, Alan Cox wrote:
> 
> > Removing it in the -ac tree is a good way to stimulate discussion
> 
> OK
> 
> > fixing the code that relies on it (except for the 99% of code relying on it
> > which is cracker authored trojans)
> 
> No doubt, but it's not much harder to look at nm vmlinux or System.map,
> so I don't see the security angle...
> 
> I'd be happy to bear the brunt of users moaning at me because they now
> have to apply a kernel patch (and I have to maintain it ...), iff there
> was some strongly technical reason the code has to change.

I'd like to second that. syscalltrack (http://syscalltrack.sf.net)
hijacks syscall entries in the sys_call_table as well, because we
want it to work as a module and not require patching the kernel. Our
solution to the module unload race on syscall de-hijacking is simple,
splitting the system call hijacking code into a single small module
which once loaded cannot be unloaded.

So please keep the sys_call_table exported and marked as "ugh, not
portable and racy, please dont hijack system calls unless you really
have to" unless there's a strongly technical reason otherwise. Our
users (all 7 of them) will appreciate it ;)
-- 
The ill-formed Orange
Fails to satisfy the eye:       http://vipe.technion.ac.il/~mulix/
Segmentation fault.             http://syscalltrack.sf.net/
