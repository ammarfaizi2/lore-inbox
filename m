Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130420AbQKGQMl>; Tue, 7 Nov 2000 11:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130543AbQKGQMb>; Tue, 7 Nov 2000 11:12:31 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:43346 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S130420AbQKGQM2>; Tue, 7 Nov 2000 11:12:28 -0500
Date: Tue, 7 Nov 2000 10:12:26 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200011071612.KAA318749@tomcat.admin.navo.hpc.mil>
To: davids@webmaster.com, "RAJESH BALAN" <atmproj@yahoo.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: malloc(1/0) ??
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > hi,
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
> 
> 	The program does not work. A program works if it does what it's supposed to
> do. If you want to argue that this program is supposed to print "ffffff"
> then explain to me why the 'malloc' contains a zero in parenthesis.
> 
> 	The program can't possibly work because it invokes undefined behavior. It
> is impossible to determine what a program that invokes undefined behavior is
> 'supposed to do'.

All true, but the reason it "works" is that malloc WILL allocate some memory,
even if it's only a few bytes of header.:

       |       |   (other memory block controled by malloc/free...)
       |-------|
       | header|
       |       |    - address returned to program
       | next  |
       | header|    (next memory block...)

Now the strcpy may have copied the string "fffff" over the next header.
The copy worked, the printf worked (its buffers were already allocated...)
BUT... If you allocate more memory via malloc, you will get an error
(eventually). I believe malloc(0) allocates 4 bytes as a minimum, though
this particular call IS undefined. You also did not check to see if
malloc did return something (It did, or you would have gotten a segmentation
fault from writing to location 0 with strcpy).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
