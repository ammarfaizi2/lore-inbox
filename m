Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281373AbRKEVw6>; Mon, 5 Nov 2001 16:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281372AbRKEVwk>; Mon, 5 Nov 2001 16:52:40 -0500
Received: from ns.suse.de ([213.95.15.193]:62223 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281362AbRKEVwW> convert rfc822-to-8bit;
	Mon, 5 Nov 2001 16:52:22 -0500
To: kaih@khms.westfalen.de (Kai Henningsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] pivot_root and initrd
In-Reply-To: <3BCDCF1D.6030202@usa.net> <8BfMOaZmw-B@khms.westfalen.de>
X-Yow: Did I say I was a sardine?  Or a bus???
From: Andreas Schwab <schwab@suse.de>
Date: 05 Nov 2001 22:52:18 +0100
In-Reply-To: <8BfMOaZmw-B@khms.westfalen.de> (kaih@khms.westfalen.de's message of "27 Oct 2001 14:45:00 +0200")
Message-ID: <jeofmgsx65.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kaih@khms.westfalen.de (Kai Henningsen) writes:

|> ebrower@usa.net (Eric)  wrote on 17.10.01 in <3BCDCF1D.6030202@usa.net>:
|> 
|> > You are simply doing the following, I assume with success:
|> 
|> >    exec /sbin/init "$@"
|> 
|> > whereas I am doing something like the following:
|> 
|> >    exec chroot . sh -c 'umount $OLDROOT; exec -a init.new /sbin/init
|> >      $INITARGS' <dev/console >dev/console 2>&1
|> 
|> > I am mystified that the call to 'exec /sbin/init' works if you are using
|> > the standard (you mention "based on RedHat7.1" util-linux") /sbin/init
|> > proggie, and that a standard RH7.1 initscripts would not complain when
|> > the root filesystem is already mounted r/w.
|> 
|> It works because the PID is 1, of course.
|> 
|> /linuxrc (or however you call it) runs with PID=1, so when it exec's /sbin/ 
|> init, the PID is still 1.
|> 
|> OTOH, you have chroot run a shell as a child, which therefore does *not*  
|> have PID=1.

linuxrc does 'exec chroot', chroot does 'exec sh', sh does 'exec init'.
Thus init should end up with the same pid as linuxrc.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
