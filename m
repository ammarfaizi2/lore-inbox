Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279054AbRKDVOU>; Sun, 4 Nov 2001 16:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279003AbRKDVOJ>; Sun, 4 Nov 2001 16:14:09 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:27151 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S278958AbRKDVN5>;
	Sun, 4 Nov 2001 16:13:57 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111042112.fA4LCNR241720@saturn.cs.uml.edu>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
To: jakob@unthought.net (=?iso-8859-1?Q?Jakob_=D8stergaard?=)
Date: Sun, 4 Nov 2001 16:12:23 -0500 (EST)
Cc: linux-kernel@alex.org.uk (Alex Bligh - linux-kernel),
        viro@math.psu.edu (Alexander Viro), moz@compsoc.man.ac.uk (John Levon),
        linux-kernel@vger.kernel.org,
        phillips@bonn-fries.net (Daniel Phillips), tim@tjansen.de (Tim Jansen)
In-Reply-To: <20011104204502.O14001@unthought.net> from "=?iso-8859-1?Q?Jakob_=D8stergaard?=" at Nov 04, 2001 08:45:02 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?Jak writes:

> Please tell me,  is "1610612736" a 32-bit integer, a 64-bit integer, is
> it signed or unsigned   ?
> 
> I could even live with parsing ASCII, as long as there'd just be type
> information to go with the values.

You are looking for something called the registry. It's something
that was introduced with Windows 95. It's basically a filesystem
with typed files: char, int, string, string array, etc.

> These interfaces need to be "correct", not "mostly correct".
>
> Example:   I make a symlink from "cat" to "c)(t" (sick example,
> but that doesn't change my point), and do a "./c)(t /proc/self/stat":
>
> [albatros:joe] $ ./c\)\(a /proc/self/stat
> 22482 (c)(a) R 22444 22482 22444 34816 22482 0 20 0 126 0 0 0 0 0 14 0 0 0 24933425 1654784 129 4294967295 134512640 134525684 3221223504 3221223112 1074798884 0 0 0 0 0 0 0 17 0
>
> Go parse that one !  What's the name of my applications ? 

Funny you should mention that one. I wrote the code used by procps
to read this file. I love that file! The parentheses issue is just
a beauty wart. People rarely feel the urge to screw with raw numbers.
In all the other files, idiots like to: add headers, change the
spelling of field names, change the order, add spaces and random
punctuation, etc. Nothing is as stable and easy to use as the
/proc/self/stat file.

> If you want ASCII, we should at least have some approved parsing
> library to parse this into native-machine binary structures

No.

>> 2. Flag those entries which are sysctl mirrors as such
>>    (perhaps in each /proc directory /proc/foo/bar/, a
>>    /proc/foo/bar/ctl with them all in). Duplicate for the
>>    time being rather than move. Make reading them (at
>>    least those in the ctl directory) have a comment line
>>    starting with a '#' at the top describing the format
>>    (integer, boolean, string, whatever), what it does.
>>    Ignore comment lines on write.

Now you are proposing to dink with the format. See above comments.

>> 3. Try and rearrange all the /proc entries this way, which
>>    means sysctl can be implemented by a straight ASCII
>>    write - nice and easy to parse files.

This is exactly what the sysctl command does.

> I'm not a big fan of huge re-arrangements. I do like the idea of providing
> a machine-readable version of /proc.

Linus clearly doesn't give a fuck about /proc performance.
That's his right, and you are welcome to patch your kernel to
have something better: http://lwn.net/2000/0420/a/atomicps.html
