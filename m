Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSELVnD>; Sun, 12 May 2002 17:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSELVnC>; Sun, 12 May 2002 17:43:02 -0400
Received: from infa.abo.fi ([130.232.208.126]:28431 "EHLO infa.abo.fi")
	by vger.kernel.org with ESMTP id <S315427AbSELVnB>;
	Sun, 12 May 2002 17:43:01 -0400
Date: Mon, 13 May 2002 00:42:56 +0300
From: Marcus Alanen <marcus@infa.abo.fi>
Message-Id: <200205122142.AAA26566@infa.abo.fi>
To: Weimer@CERT.Uni-Stuttgart.DE, linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
In-Reply-To: <873cwx2hi4.fsf@CERT.Uni-Stuttgart.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:
>torvalds@transmeta.com (Linus Torvalds) writes:
>
>> Perl is the obvious choice for doing transformations like these.  Is
>> anybody willing to write a perl script that does the "sort by author"
>> thing?

[snip]
Basically the same, this treats each patch separately:

#!/usr/bin/perl

use strict;

my %people = ();
my $addr = "";
my @cur = ();

sub append_item() {
	if (!$addr) { return; }
	if (!$people{$addr}) { @{$people{$addr}} = (); }
	push @{$people{$addr}}, [@cur];

	@cur = ();
}

while (<>) {
	# Match address
	if (/^<(.+)>/) {
		# Add old item (if any) before beginning new
		append_item();
		$addr = $1;
	} elsif ($addr) {
		# Add line to patch
		push @cur, $_;
	} else {
		# Header information
		print
	}
}


sub print_items($) {
	my @items = @{$people{$_[0]}};
	# Vain attempt to sort patches from one address
	@items = sort @items;
	while ($_ = shift @items) {
		# Item separator
		print "        --------------------------------------------------------------\n";
		print @$_;
	}
}

append_item();
foreach $addr (sort keys %people) {
	print "<$addr>\n";
	print_items($addr);
	print "\n";
}


Output:


Summary of changes from v2.5.14 to v2.5.15
============================================

<acme@brinquedo.oo.ps>
        --------------------------------------------------------------
        - remove spurious spaces and tabs at end of lines
        - make sure if, while, for, switch has a space before the opening '('
        - make sure no line has more than 80 chars
        - move initializations to the declaration line where possible
        - bitwise, logical and arithmetic operators have spaces before and after,
          improving readability of complex expressions
        - remove uneeded () in returns
        - other minor cleanups


<acme@conectiva.com.br>
        --------------------------------------------------------------
        net/ipv4/arp.c:
        - htons cleanups
        - remove duplicated code
        - apply CodingStyle

...
...
<davej@suse.de>
        --------------------------------------------------------------
        [PATCH] capabilities for mtrr driver.


        --------------------------------------------------------------
        [PATCH] region handling cleanup

        Done by William Stinson.
        Adds error handling to request_region() calls,
        and converts some old check_region() calls too.

        --------------------------------------------------------------
        [PATCH] region handling cleanup

        Done by William Stinson.
        Adds error handling to request_region() calls,
        and converts some old check_region() calls too.
...
...




-- 
Marcus Alanen
maalanen@abo.fi
