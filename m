Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262465AbTCMQfu>; Thu, 13 Mar 2003 11:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262466AbTCMQft>; Thu, 13 Mar 2003 11:35:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61059 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262465AbTCMQfp>;
	Thu, 13 Mar 2003 11:35:45 -0500
Date: Thu, 13 Mar 2003 17:46:17 +0100
From: Jens Axboe <axboe@suse.de>
To: James Stevenson <james@stev.org>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Message-ID: <20030313164617.GI836@suse.de>
References: <20030227221017.4291c1f6.skraw@ithnet.com> <014b01c2e978$701050e0$0cfea8c0@ezdsp.com> <20030313163707.GH836@suse.de> <016c01c2e980$b2d4ee60$0cfea8c0@ezdsp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016c01c2e980$b2d4ee60$0cfea8c0@ezdsp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13 2003, James Stevenson wrote:
> > > strange looks alot like the ones i have seen though the whole 2.4.x
> tree.
> > >
> > > this was discussed before somebody said they would send a patch myself
> > > and sombody else were going to test it but the patch never happens.
> > > >From what i can work out an error occurs on the cd drive and the
> request
> > > queue is then empty and the ide-scsi driver then attempts to access the
> > > reuest queue that doesnt exist i never did manage to find out
> > > where the request get removed from the queue though.
> >
> > Your explanation doesn't quite make sense, but I can take a look at the
> > problem :-)
> >
> > What kernel is the below oops from? What compiler?
> 
> i can trigger this on any 2.4.x series kernel.
> -> Insert dmaged / lightly scratched cd into drive
>    dd /dev/scd0 bs=8192k of=file
>    wait for opps.
>    opps also cd tries to re read several times
>    short hang then the following output
> 
> gcc versions.
> Whatever shits with redhat 7.1 + 7.2 + 7.3 and the
> updates between them in each of the redhat versions.
> but normally
> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)
> 
> or
> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113)

weee ok not my choice for compilers, but probably alright. do me a favor
then:

# cd /to/kernel/source
# rm drivers/scsi/ide-scsi.o
# EXTRA_CFLAGS=-g make drivers/scsi/ide-scsi.o
# objdump -S drivers/scsi/ide-scsi.o > /tmp/some_file

 and then mail me some_file (privately), thanks.

-- 
Jens Axboe

