Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315476AbSENInp>; Tue, 14 May 2002 04:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315479AbSENIno>; Tue, 14 May 2002 04:43:44 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:21002 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S315476AbSENIno>; Tue, 14 May 2002 04:43:44 -0400
Date: Tue, 14 May 2002 10:43:40 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020514084339.GB1842@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020513144519.GC5134@louise.pinerecords.com> <Pine.LNX.4.44.0205131759480.5254-100000@alumno.inacap.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, Robinson Maureira Castillo wrote:

> +die "Usage $0 [-n] <Changelog file>\nThis Perl script is meant to simplify/beautify BK ChangeLogs\nfor the linux kernel\n\nn\tFormat for the output\n\t0 - Short mode (one changelog == one line)\n\t1 - Full mode (changelogs separated by dashed line)\n\t2 - Original mode (one line consisting of changelog and author)[DEFAULT]\n" unless defined $ARGV[0];

Why forbid filtering?

> +my $fd = $ARGV[0];
> +
> +if (grep(/^-/,$ARGV[0])) {
> +	$mode = $ARGV[0];
> +	$mode =~ s/-//;
> +	$mode = 2 if ($mode > 2);
> +	$fd = $ARGV[1];

It's time for some Getopt::. I'll merge the interesting parts of 0.92 as
posted by Tomas, my plan is: use the LINUX_BK2CHANGELOG variable for
defaults, but allow to override them with command line arguments.

>  # minimum space between entry and author for the original mode
> @@ -160,7 +167,9 @@
>  	}
>  }
>  
> -while (<>)
> +open FD,$fd;

This gives room for nasty surprises, if $ARGV[whatever] starts with a
">" or "|". Easy to fix, but we can avoid this, because Perl already
handles it for us. Check the docs on <> behaviour when extra command
line arguments are left over.

-- 
Matthias Andree
