Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbSJXKQk>; Thu, 24 Oct 2002 06:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265377AbSJXKQk>; Thu, 24 Oct 2002 06:16:40 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:18328 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S265368AbSJXKQj> convert rfc822-to-8bit;
	Thu, 24 Oct 2002 06:16:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: "David S. Miller" <davem@rth.ninka.net>
Subject: sendfile64() anyone? (was [RESEND] tuning linux for high network performance?)
Date: Thu, 24 Oct 2002 12:30:46 +0200
User-Agent: KMail/1.4.1
Cc: bert hubert <ahu@ds9a.nl>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200210231218.18733.roy@karlsbakk.net> <200210231542.48673.roy@karlsbakk.net> <1035432669.9628.1.camel@rth.ninka.net>
In-Reply-To: <1035432669.9628.1.camel@rth.ninka.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210241230.46848.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 October 2002 06:11, David S. Miller wrote:
> On Wed, 2002-10-23 at 06:42, Roy Sigurd Karlsbakk wrote:
> > As far as I've understood, sendfile() won't do much good with large
> > files. Is this right?
>
> There is always a benefit to using sendfile(), when you use
> sendfile() the cpu doesn't touch one byte of the data if
> the network card support TX checksumming.  The disk DMAs
> to ram, then the net card DMAs from ram.  Simple as that.

Are there any plans of implementing sendfile64() or sendfile() support for 
-D_FILE_OFFSET_BITS=64?

(from man 2 sendfile)
ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count);

int main() {
        ssize_t s1;
        size_t count;
        off_t offset;

        printf("sizeof ssize_t: %d\n", sizeof s1);
        printf("sizeof size_t: %d\n", sizeof count);
        printf("sizeof off_t: %d\n", sizeof offset);
        return 0;
}
$ make
...
$ ./sendfile_test
sizeof ssize_t: 4
sizeof size_t: 4
sizeof off_t: 4
$ 

and - when attempting to build this with -D_FILE_OFFSET_BITS=64 

[roy@roy-sin micro_httpd-O_DIRECT]$ make sendfile_test
gcc -D_DEBUG -Wall -W -D_GNU_SOURCE -D_NO_DIR_ACCESS -D_FILE_OFFSET_BITS=64 
-D_LARGEFILE_SOURCE -DUSE_O_DIRECT -DINETD -Wno-unused -O0 -ggdb -c 
sendfile_test.c
In file included from sendfile_test.c:1:
/usr/include/sys/sendfile.h:26: #error "<sys/sendfile.h> cannot be used with 
_FILE_OFFSET_BITS=64"
make: *** [sendfile_test.o] Error 1

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

