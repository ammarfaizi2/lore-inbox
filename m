Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129369AbQKGIgN>; Tue, 7 Nov 2000 03:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbQKGIgD>; Tue, 7 Nov 2000 03:36:03 -0500
Received: from shodan.ibl.sk ([195.46.65.37]:6923 "HELO shodan.ibl.sk")
	by vger.kernel.org with SMTP id <S129369AbQKGIfr> convert rfc822-to-8bit;
	Tue, 7 Nov 2000 03:35:47 -0500
From: Andrej Hosna <hosna@ibl.sk>
Organization: IBL Software
To: "David Schwartz" <davids@webmaster.com>
Subject: RE: malloc(1/0) ??
Date: Tue, 7 Nov 2000 08:59:40 +0100
X-Mailer: KMail [version 1.0.29.2]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKEEAJLMAA.davids@webmaster.com>
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKEEAJLMAA.davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00110709373507.05397@adino>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,
> > why does this program works. when executed, it doesnt
> > give a segmentation fault. when the program requests
> > memory, is a standard chunk is allocated irrespective
> > of the what the user specifies. please explain.
> >
> > main()
> > {
> >    char *s;
> >    s = (char*)malloc(0);
> >    strcpy(s,"fffff");
> >    printf("%s\n",s);
> > }
> >
> > NOTE:
> >   i know its a 'C' problem. but i wanted to know how
> > this works

C problem? You would better say , library problem(but it's not a problem at
all).

> The program does not work. A program works if it does what it's supposed to
> do. If you want to argue that this program is supposed to print "ffffff"
> then explain to me why the 'malloc' contains a zero in parenthesis.
> 
> The program can't possibly work because it invokes undefined behavior. It
> is impossible to determine what a program that invokes undefined behavior is
> 'supposed to do'.

I dont think it's undefined behaviour ...

Text from malloc.c <glibc2.something>
<------snip-------->
Malloc Algorithm:
 
    The requested size is first converted into a usable form, `nb'.
    This currently means to add 4 bytes overhead plus possibly more to
    obtain 8-byte alignment and/or to obtain a size of at least
    MINSIZE (currently 16, 24, or 32 bytes), the smallest allocatable
    size.  (All fits are considered `exact' if they are within MINSIZE
    bytes.)
<----- snip --------->
So some area of MINSIZE is alloced , and you can write there... 
Problems will arrive with writing over this area, and overwriting next memory
chunk header. Write is not a problem ... in your code you have 4KB to spare,
but when you try to free() you'd probably get SIGSEG. 

Hope that you have idea how it works now. If not, read the malloc.c comments to
find about about how malloc realy works.

Adino
-- 
/* Andrej Hosna - http://people.ibl.sk/adino - +421 903 852 696  */
/* IBL Software Engineering - http://www.ibl.sk - +421 7 43427214 */
                                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
