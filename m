Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317598AbSFIK5g>; Sun, 9 Jun 2002 06:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSFIK5f>; Sun, 9 Jun 2002 06:57:35 -0400
Received: from khms.westfalen.de ([62.153.201.243]:37526 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S317596AbSFIK5d>; Sun, 9 Jun 2002 06:57:33 -0400
Date: 09 Jun 2002 11:49:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8QXHSZTXw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0206081523410.11630-100000@home.transmeta.com>
Subject: Re: [PATCH] Futex Asynchronous Interface
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 08.06.02 in <Pine.LNX.4.44.0206081523410.11630-100000@home.transmeta.com>:

> On Fri, 7 Jun 2002, Peter Waechtler wrote:
> >
> > What about /proc/futex then?
>
> Why?
>
> Tell me _one_ advantage from having the thing exposed as a filename?

None, of course - the shell can't do the other futex ops, either. Futex  
file handles mean you can implement select() on them, but that's about all  
they have in common with files - there is certainly no read() or write()  
operation here!

> > Give it an entry in the namespace, why not with sockets (unix and ip)
> > also?
>
> Perhaps because you cannot enumerate sockets and pipes? They don't _have_
> names before they are created. Same as futexes, btw.

Now *there* I disagree, at least for sockets. First of all, there's  
absolutely no need to be able to enumerate unopened sockets to justify  
putting them into the namespace - you can create them (in a special fs, of  
course) at the moment they are opened. (As in fact is done, in /proc/<pid>/ 
fd/.) And second, you *can* read() and write() there.

However, I don't think that's all that important. What I'd rather see is  
making the network devices into namespace nodes. The situation of eth0 and  
friends, from a Unix perspective, is utterly unnatural.

MfG Kai
