Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbQKGQjr>; Tue, 7 Nov 2000 11:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130193AbQKGQjh>; Tue, 7 Nov 2000 11:39:37 -0500
Received: from dsl-dt-208-38-4-i185-cgy.nucleus.com ([208.38.4.185]:20999 "EHLO
	skaro.l-w.net") by vger.kernel.org with ESMTP id <S129764AbQKGQjY>;
	Tue, 7 Nov 2000 11:39:24 -0500
Date: Tue, 7 Nov 2000 09:38:47 -0700 (MST)
From: lost@l-w.net
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: davids@webmaster.com, RAJESH BALAN <atmproj@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: RE: malloc(1/0) ??
In-Reply-To: <200011071612.KAA318749@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.LNX.4.21.0011070934060.314-100000@skaro.l-w.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > main()
> > > {
> > >    char *s;
> > >    s = (char*)malloc(0);
> > >    strcpy(s,"fffff");
> > >    printf("%s\n",s);
> > > }

I rather suspect that the strcpy() scribbled over malloc()s record keeping
data. However, that memory was in the processes allowed address space so
it didn't SIGSEGV. Now, when you call printf(), there is a very good
chance that printf() tried to allocate some sort of buffer space since it
is the first call to printf() in the program. Now, since malloc()s heap is
messed up from the strcpy(), it crashes. (Probably because
malloc() followed a pointer off into never-never land.) Hence, the crash
appears in printf() instead of strcpy() or malloc(). I won't repeat the
discussion about why malloc(0) succeeded.

William Astle
finger lost@l-w.net for further information

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS/M/S d- s+:+ !a C++ UL++++$ P++ L+++ !E W++ !N w--- !O !M PS PE V-- Y+
PGP t+@ 5++ X !R tv+@ b+++@ !DI D? G e++ h+ y?
------END GEEK CODE BLOCK------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
