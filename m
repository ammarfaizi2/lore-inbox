Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282508AbRKZUul>; Mon, 26 Nov 2001 15:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282505AbRKZUtE>; Mon, 26 Nov 2001 15:49:04 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:4612 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S282490AbRKZUsN>;
	Mon, 26 Nov 2001 15:48:13 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 26 Nov 2001 21:47:38 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: New ac patch???
CC: marcel@mesa.nl (Marcel J.E. Mol), roy@karlsbakk.net (Roy Sigurd Karlsbakk),
        linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <A4F55DE05E2@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Nov 01 at 20:39, Alan Cox wrote:
> > If it will go into mainstream, please change it to config option or
> > something like that. I'm doing 
> > 
> > for a in /dev/hd[a-z]; do hdparm -Y $a; done
> 
> Thats somewhat undefined in its behaviour. You might also page after the
> hdparm -Y

cat /sbin/halt > /dev/null
cat /bin/sleep > /dev/null
for a in /dev/hd[a-z]; do /sbin/hdparm -Y $a; done
/bin/sleep 1
/sbin/halt -d -f -i -p -h

works without a glitch - libc & co. is already in memory due to running
other code, hdparm is read during first pass through the loop, and cat 
brings /sbin/halt into the memory. And as root filesystem is mounted 
read-only at that time, there are of course no atime updates pending from 
these accesses.
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
