Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280776AbRKGMqM>; Wed, 7 Nov 2001 07:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280749AbRKGMqC>; Wed, 7 Nov 2001 07:46:02 -0500
Received: from mta.sara.nl ([145.100.16.144]:58799 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S280776AbRKGMpt>;
	Wed, 7 Nov 2001 07:45:49 -0500
Message-Id: <200111071245.NAA25075@zhadum.sara.nl>
X-Mailer: exmh version 2.1.1 10/15/1999
From: Remco Post <r.post@sara.nl>
To: Erik Andersen <andersen@codepoet.org>, dank@trellisinc.com,
        linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff] 
In-Reply-To: Message from Erik Andersen <andersen@codepoet.org> 
   of "Tue, 06 Nov 2001 15:22:15 MST." <20011106152215.A31923@codepoet.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Nov 2001 13:45:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

still,

char name[80]
if (sscanf(line, "%4u %4u %llu %80s", &major, &minor, &size, name) == 4)

would safeguard you agains whatever you might read from your line, this is 
better protection agains buffer overflows than looking up the code that you 
think you'll be reading the output from. This code is NOT under your control, 
usually...

> On Tue Nov 06, 2001 at 02:49:23PM -0500, dank@trellisinc.com wrote:
> > In article <20011105155955.A16505@codepoet.org> Erik Anderson wrote:
> > > Come now, it really isn't that difficult: 
> > 
> > >    char name[80];
> > >    if (sscanf(line, "%4u %4u %llu %s", &major, &minor, &size, name) == 4)
> > 
> > if it's so easy to do, why do you have a great big buffer overflow here?
> 
> 
> Sorry, no doughnut for you.  drivers/block/genhd.c:
> 
>     #ifdef CONFIG_PROC_FS
>     int get_partition_list(char *page, char **start, off_t offset, int count)
>     {
> 	...
> 	char buf[64];
> 
> 	...
> 
> 	len += snprintf(page + len, 63, "%4d  %4d %10d %s\n", gp->major, n, 
> 		gp->sizes[n], disk_name(gp, n, buf));
> 
> so each /proc/partitions line maxes out at 63 bytes.  So not only
> is there no overflow, I am providing 16 extra bytes of padding.
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams


