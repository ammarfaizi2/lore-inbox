Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267950AbTBMBjf>; Wed, 12 Feb 2003 20:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267953AbTBMBjf>; Wed, 12 Feb 2003 20:39:35 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38098 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267950AbTBMBjc>;
	Wed, 12 Feb 2003 20:39:32 -0500
Date: Wed, 12 Feb 2003 17:46:37 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT foolish question
Message-Id: <20030212174637.3975e7c3.rddunlap@osdl.org>
In-Reply-To: <1045092155.21195.93.camel@urca.rutgers.edu>
References: <1045084764.4767.76.camel@urca.rutgers.edu>
	<20030212140338.6027fd94.akpm@digeo.com>
	<1045088991.4767.85.camel@urca.rutgers.edu>
	<20030212224226.GA13129@f00f.org>
	<1045090977.21195.87.camel@urca.rutgers.edu>
	<1045092155.21195.93.camel@urca.rutgers.edu>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Feb 2003 18:22:35 -0500
Bruno Diniz de Paula <diniz@cs.rutgers.edu> wrote:

| Just to complete the information, I am trying to read a file with 5
| bytes, and here is the piece of code I am using:
| 
|     char *message;
|     int fd = open("/var/tmp/testopen.txt", O_RDONLY|O_DIRECT);
|     int len, pagesize = getpagesize();
| 
|     posix_memalign((void **)&message, pagesize, pagesize);
|     if(fd < 0) {
|         printf("Unable to open file, errno is %d.\n", errno);
|     } else {
|         if((len = read(fd, message, pagesize)) < 0) {
| 			perror("read");
|         } else {
|             printf("%d bytes read from file.\n", len);
| 	    printf("Message: %s", message);
|         }
|     }
|     close(fd);
| 
| Thanks,
| 
| Bruno.
| 
| On Wed, 2003-02-12 at 18:02, Bruno Diniz de Paula wrote:
| > On Wed, 2003-02-12 at 17:42, Chris Wedgwood wrote:
| > > On Wed, Feb 12, 2003 at 05:29:52PM -0500, Bruno Diniz de Paula wrote:
| > > 
| > > > But I am using multiples of page size in both buffer alignment and
| > > > buffer size (2nd and 3rd parameters of read).  The issue is that
| > > > when I try to read files with sizes that are NOT multiples of block
| > > > size (and therefore also not multiples of page size), the read
| > > > syscall returns 0, with no errors.
| > > 
| > > What filesystem?
| > 
| > ext2.
| > 
| > > 
| > > Can you send an strace of this occurring?
| > 
[strace snipped]
| > 
| > Thanks a lot,
| > 
| > Bruno.
| > 
| > > 
| > > > So the question remains, am I able to read just files whose size is
| > > > a multiple of block size?
| > > 
| > > No.
| > > 
| > > You ideally should be able to read any length file with O_DIRECT.
| > > Even a 1-byte file.



Here's what I get using Bruno's and cw's (od) programs:

	2.4.8|2.4.20	2.4.20			2.5.54
	ext2		ext3			ext2|ext3
	====		====			=========
od:	read 0 bytes	read: Inv. arg.		read: Inv. arg.
bruno:	0 bytes read	read: Inv. arg.		read: Inv. arg.

--
~Randy
