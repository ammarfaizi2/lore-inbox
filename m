Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbVIVDIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbVIVDIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 23:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbVIVDIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 23:08:48 -0400
Received: from web8406.mail.in.yahoo.com ([202.43.219.154]:60822 "HELO
	web8406.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1030193AbVIVDIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 23:08:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hJAKhMre0Lrt51ZVAKqm1W2Yn/TCWuTsOsDYc9d8g4Yqqxwigc9VwjxWpdI5d1WVCzUhWrFZpXcKGevJ9M7Mi7cxzWGZLFl7HRSBVMHp85dG2Ve3dUWABdKPCdbZgKvWrKAv2kvuwLdoC1a2iSQptSHIvP6Zq/WxigwTU8tNQRI=  ;
Message-ID: <20050922030844.14682.qmail@web8406.mail.in.yahoo.com>
Date: Thu, 22 Sep 2005 04:08:44 +0100 (BST)
From: vikas gupta <vikas_gupta51013@yahoo.co.in>
Subject: AIO Support and related package information??
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: suparna@in.ibm.com, bcrl@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello ALL ,

I am very curious about the AIO support in kernel. I
have downloaded the
recent kernel 2.6.13 and applied suparna's patches on
that but now i got stuck as
now there are two different packages are available.

1) libaio rpm

There are many rpm available such as
libaio-0.3.xxx-02.src rpm and many
more but at http://lse.sourceforge.net/io/aio.html
,Somebody has said to use
libaio-0.3.99 package ..

So can you please give me some guidelines on after
applying the patch how
to proceed further???

Is these packages are part of linux kernel
installation ????

Is this package implementation is really necessary and
if yes then what
are the packages we need to install.

And if any other resource is required then from where
i can get that
resource.

2) libposix API library of 
http://www.bullopensource.org/posix.

        How to use it???
        Is it any other way of implementing the AIO
Support or it is to
provide posix conformance to the kernel.

3) What is the relation between libposixaio pacakage
supported by bullsource.net and libaio pacakage
supported by redhat ....

4) I am able to built that libposix package without
libaio ??????

5) are these pacakages are supported for othewr
platforms such as arm and ppc ,I am not able to build
libposix for arm platform.Do Cross compiling is
supported ???



6) How to use these api in test program

  Can i use it as mentioned below ????

  Test1.c

  #include <aio.h>
  #include <errno.h>
  #include <stdio.h>
  #include <string.h>
  #include <unistd.h>

  #define BYTES 8

  int main( int argc, char *argv[] )
  {
      int i, r;
      int fildes;
      struct aiocb cb;
      char buff[BYTES];

      if ((fildes = open( "/etc/resolv.conf", O_RDONLY
)) < 0) {
          perror( "opening file" ); return 1;
      }

      cb.aio_fildes = fildes;
      cb.aio_offset = 0;
      cb.aio_buf = buff;
      cb.aio_nbytes = BYTES;
      cb.aio_reqprio = 0;
      cb.aio_sigevent.sigev_notify = SIGEV_NONE;

      errno = 0;
      r = aio_read( &cb );
      printf( "aio_read() ret: %i\terrno: %i\n", r,
errno );

      while (aio_error( &cb ) == EINPROGRESS) {
usleep( 10 ); }

      for (i = 0; i < BYTES; i++) { printf( "%c ",
buff[i] ); } printf(
"\n" );

      errno = 0;
      r = aio_return( &cb );
      printf( "aio_return() ret: %i\tBYTES: %i\terrno:
%i\n", r, BYTES,
errno );

      return 0;
}



Any other information, if u can provide then it will
be of great use ...


Thanks in advance ...

Vikas



		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
