Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSGPM2a>; Tue, 16 Jul 2002 08:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317670AbSGPM23>; Tue, 16 Jul 2002 08:28:29 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:44294 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S314085AbSGPM22>; Tue, 16 Jul 2002 08:28:28 -0400
Date: Tue, 16 Jul 2002 14:31:22 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716123122.GE4576@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <s5g7kjwsn12.fsf@egghead.curl.com> <Pine.LNX.4.44.0207151537360.3452-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207151537360.3452-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Thunder from the hill wrote:

> Hi,
> 
> On 15 Jul 2002, Patrick J. LoPresti wrote:
> > Note that this means writing a truly reliable shell or Perl script is
> > tricky.  I suppose you can "use POSIX qw(fsync);" in Perl.  But what do
> > you do for a shell script?  /bin/sync :-) ?
> 
> Write a binary (/usr/bin/fsync) which opens a fd, fsync it, close it, be 
> done with it.

Or steal one from FreeBSD (written by Paul Saab), fix the err() function
and be done with it.

.../usr.bin/fsync/fsync.{1,c}

Interesting side note -- mind the O_RDONLY:

        for (i = 1; i < argc; ++i) {
                if ((fd = open(argv[i], O_RDONLY)) < 0)
                        err(1, "open %s", argv[i]);

                if (fsync(fd) != 0)
                        err(1, "fsync %s", argv[1]);
                close(fd);
        }
