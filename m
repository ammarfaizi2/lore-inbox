Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270274AbRHHCji>; Tue, 7 Aug 2001 22:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270276AbRHHCjS>; Tue, 7 Aug 2001 22:39:18 -0400
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:39930
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S270274AbRHHCjL>; Tue, 7 Aug 2001 22:39:11 -0400
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: Keith Owens <kaos@ocs.com.au>,
        Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Subject: Re: using mount from SUID scripts?
Date: Tue, 7 Aug 2001 21:29:07 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Kernel Developer List <linux-kernel@vger.kernel.org>
In-Reply-To: <27034.997233173@kao2.melbourne.sgi.com>
In-Reply-To: <27034.997233173@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Message-Id: <01080721385400.15022@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2001, Keith Owens wrote:
>On Tue, 7 Aug 2001 16:29:39 -0700, 
>Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
>>I've got an SUID perl script (yes, it's EUID is really 0) which I'd like to
>>use mount from to mount a file via loopback...
>>
>>Unfortunately, it looks like mount refuses to actually mount anything if
>>the EUID and UID aren't the same....
>
>Are you sure the problem is mount?  Some versions of bash drop euid(0)
>when they execute scripts from setuid programs.
>

not mount, and likely not the shell - the thing is that perl doesn't like it
when the  effective uid is not equal to the real uid. Perl is very good at
limiting the damange an unsuspecting script does. This is to prevent passing
a "confused" environment to the shell.

The following can work around this:

	($r,$e) = ( $>, $< );	# save real and effective uid's
	$< = $e;		# force real uid to the effective
	`/bin/mount ....`
	($>, $<) = ($r,$e);	# restore mixed state

Remember, the options to mount should come from a fixed table with user
selected input used to select which table entry to use... or a strictly
fixed mount command.

Otherwise you have an even bigger security hole.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
