Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315863AbSEMHfp>; Mon, 13 May 2002 03:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315864AbSEMHfo>; Mon, 13 May 2002 03:35:44 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:15866 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S315863AbSEMHfn>; Mon, 13 May 2002 03:35:43 -0400
Date: Mon, 13 May 2002 09:34:47 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: Marcus Alanen <marcus@infa.abo.fi>
Cc: Weimer@CERT.Uni-Stuttgart.DE, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Changelogs on kernel.org
Message-Id: <20020513093447.04779a0e.kristian.peters@korseby.net>
In-Reply-To: <200205122142.AAA26566@infa.abo.fi>
X-Mailer: Sylpheed version 0.7.1claws7 (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.18-ac3
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I changed your perl-script int that way that it only gives out the first line of the patch. This makes the changelog less verbose but you can read the changes very quickly and if you're interested in a certain patch, you can grep the verbose one.
That makes more sense. IMHO I like it better that way. Most people want to see a little overview and are only really interested in the parts they're working on.

This is now the output:

[...]
<hch@infradead.org>
        - remove global_bufferlist_lock
        - fix config.in syntax errors.
        - architecture-independand si_meminfo

<jsimmons@heisenberg.transvirtual.com>
        - A bunch of fixes.
        - Pmac updates
        - Some more small fixes.

<maxk@qualcomm.com>
        - Bluetooth subsystem sync up
[...]

*Kristian



#!/usr/bin/perl -w

use strict;

my %people = ();
my $addr = "";
my @cur = ();
my $comment = 0;

sub append_item() {
	if (!$addr) {
		return;
	}
	if (!$people{$addr}) {
		@{$people{$addr}} = ();
	}
	push @{$people{$addr}}, [@cur];

	@cur = ();
}

while (<>) {
	# Match address
	if (/^\s*<([^>]+)>/) {
		# Add old item (if any) before beginning new
		append_item();
		$addr = $1;
		$comment = 1;
	} elsif ($addr) {
		# Add line to patch
		s/^\s*(.*)\s*$/- $1/;
		$_ =~ s/\[PATCH\] //g;
		$_ =~ s/\s*PATCH //g;
		if ($comment == 1) {
			push @cur, "\t$_\n";
			$comment = 0;
		}
	} else {
		# Header information
		print;
	}
}

sub print_items($) {
	my @items = @{$people{$_[0]}};
	# Vain attempt to sort patches from one address
	@items = sort @items;
	while ($_ = shift @items) {
		print @$_;
	}
}

append_item();
foreach $addr (sort keys %people) {
	print "<$addr>\n";
	print_items($addr);
	print "\n";
}





  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
