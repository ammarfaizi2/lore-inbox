Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315423AbSELVSO>; Sun, 12 May 2002 17:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315424AbSELVSN>; Sun, 12 May 2002 17:18:13 -0400
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:55466 "HELO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with SMTP
	id <S315423AbSELVSM>; Sun, 12 May 2002 17:18:12 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
In-Reply-To: <20020512010709.7a973fac.spyro@armlinux.org>
	<abmi0f$ugh$1@penguin.transmeta.com>
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Sun, 12 May 2002 23:17:23 +0200
Message-ID: <873cwx2hi4.fsf@CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds) writes:

> Perl is the obvious choice for doing transformations like these.  Is
> anybody willing to write a perl script that does the "sort by author"
> thing?

#!/usr/bin/perl -w
# Reformat 2.4 ChangeLog

use strict;

my %authors = ();
my $current;

while (<>) {
    chomp;
    if (/^</) {
	if (exists $authors{$_}) {
	    $current = $authors{$_};
	} else {
	    $current = $authors{$_} = [];
	}
    } else {
	die "illegal format" unless defined $current;
	push @$current, $_;
    }
}

my $author;
foreach $author (sort keys %authors) {
    print "$author\n";
    $_ = join "\n", @{$authors{$author}};
    # Add empty line before next author.    
    s/\n*$/\n\n/;
    print;
}

For your example, the result is:

<jsimmons@heisenberg.transvirtual.com>
        A bunch of fixes.

        Pmac updates

        Some more small fixes.

<rmk@arm.linux.org.uk>
        [PATCH] 2.5.13: vmalloc link failure
        
        The following patch fixes this, and also fixes the similar problem in
        scsi_debug.c:

<trond.myklebust@fys.uio.no>
        [PATCH] in_ntoa link failure
        
        Nothing serious. Whoever it was that did that global replacemissed a
        spot is all...

<viro@math.psu.edu>
        [PATCH] change_floppy() fix
        
        Needed both in 2.4 and 2.5


IMHO, it doesn't make much sense.

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
