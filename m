Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274681AbRKDTZD>; Sun, 4 Nov 2001 14:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274299AbRKDTYy>; Sun, 4 Nov 2001 14:24:54 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:44707 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S274681AbRKDTYl> convert rfc822-to-8bit;
	Sun, 4 Nov 2001 14:24:41 -0500
Date: Sun, 04 Nov 2001 19:24:36 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: =?ISO-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
        Alexander Viro <viro@math.psu.edu>
Cc: John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <620744650.1004901876@[195.224.237.69]>
In-Reply-To: <20011104200452.L14001@unthought.net>
In-Reply-To: <20011104200452.L14001@unthought.net>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Sunday, 04 November, 2001 8:04 PM +0100 Jakob Østergaard 
<jakob@unthought.net> wrote:

> I'm a little scared when our VFS guy claims he never heard of excellent
> programmers using scanf in a way that led to parse errors.

I'd be far more scared if Al claimed he'd never heard of excellent
programmers reading binary formats, compatible between multiple
code revisions both forward and backwards, endian-ness etc., which
had never lead to parse errors of the binary structure.

If you feel it's too hard to write use scanf(), use sh, awk, perl
etc. which all have their own implementations that appear to have
served UNIX quite well for a long while.

Constructive suggestions:

1. use a textual format, make minimal
   changes from current (duplicate new stuff where necessary),
   but ensure each /proc interface has something which spits
   out a format line (header line or whatever, perhaps an
   interface version number). This at least
   means that userspace tools can check this against known
   previous formats, and don't have to be clairvoyant to
   tell what future kernels have the same /proc interfaces.

2. Flag those entries which are sysctl mirrors as such
   (perhaps in each /proc directory /proc/foo/bar/, a
   /proc/foo/bar/ctl with them all in). Duplicate for the
   time being rather than move. Make reading them (at
   least those in the ctl directory) have a comment line
   starting with a '#' at the top describing the format
   (integer, boolean, string, whatever), what it does.
   Ignore comment lines on write.

3. Try and rearrange all the /proc entries this way, which
   means sysctl can be implemented by a straight ASCII
   write - nice and easy to parse files. Accept that some
   /proc reads (especially) are going to be hard.

--
Alex Bligh
