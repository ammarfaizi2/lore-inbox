Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280848AbRKYM1y>; Sun, 25 Nov 2001 07:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280843AbRKYM1o>; Sun, 25 Nov 2001 07:27:44 -0500
Received: from [212.18.232.186] ([212.18.232.186]:38918 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S280848AbRKYM1a>; Sun, 25 Nov 2001 07:27:30 -0500
Date: Sun, 25 Nov 2001 12:25:57 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove trailing whitespace
Message-ID: <20011125122557.A23807@flint.arm.linux.org.uk>
In-Reply-To: <3BFE8559.1040403@antefacto.com> <01112514004301.00864@manta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01112514004301.00864@manta>; from vda@port.imtp.ilyichevsk.odessa.ua on Sun, Nov 25, 2001 at 02:00:43PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2001 at 02:00:43PM -0200, vda wrote:
> Isn't it easier to write a script 'clean_trailing_ws' (or whatever)
> and add it to scripts/ ?
> Linus can apply such 'cleaning' scripts at times like 2.4 -> 2.5

It's best to have a script that you pass all patches through which
strips off trailing space on any line that gets added (you can't
do it blindly since the context lines must obviously match the
original, as must the lines being removed).

I do this automatically when people send stuff to my patch system.
Appears to work well.

It solves the problem of the trailing space getting into the source
in the first place, and doesn't produce a huge 25MB patch.

I suppose you could also remove anything which matched 1-7 spaces
and a tab character, but this might be less reliable.  Obviously
you can't replace 8 spaces with a tab character, since it might
be part of a printk string.

If anyone's interested, this is a fragment from the perl script which
processes incoming patches.  Might be useful to someone.

	#
	# And now the actual patch itself
	#
	while (<STDIN>)
	{
		chomp;
		s/\s+$// if m/^\+/;
		$mail .= "$_\n";
		$patchtext .= "$_\n";
	}

I'm sure someone can come up with something more efficient. 8)

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

