Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318223AbSIOTIl>; Sun, 15 Sep 2002 15:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318229AbSIOTIl>; Sun, 15 Sep 2002 15:08:41 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:61908 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S318223AbSIOTIg>;
	Sun, 15 Sep 2002 15:08:36 -0400
Date: Sun, 15 Sep 2002 21:13:30 +0200 (MEST)
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Hans-Peter Jansen <hpj@urpla.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] binfmt_script: interpreted interpreter doesn't work
In-Reply-To: <200209152055.05322.hpj@urpla.net>
Message-ID: <Pine.GSO.4.30.0209152057580.22107-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Sep 2002, Hans-Peter Jansen wrote:

> > Consider these two scripts:
> >
> > /home/pozsy/a:
> > #!/usr/bin/perl
> > print <>;
> >
> > /home/pozsy/b:
> > #!/home/pozsy/a
> > "This is some text to printed out by the 'a' script"

> What's the problem?

I have a script written in perl, which interprets its input (or the files
in its arguments) [this is "a" in the above example]. I want to use this
script, as an interpreter to another "script" [the "b" in the above
example].

I well know bash, but this has nothing to do with shell coding.

Try my above example and you will understand what the problem is.
If you execute /home/pozsy/b, you _should_ get this as the output (2
lines) (the "a" program simply cats its input or argument files to its
output):
#!/home/pozsy/b
"This is some text to printed out by the 'a' script"

BUT this is what you get (1 line):
/home/pozsy/b: This is some text to printed out by the 'a' script: command
not found

This is because the kernel cannot execute the "/home/pozsy/b" script, and
then bash tries to interpret it itself. (but this in *not* what I want: I
want the "b" 'script' interpreted by the "a" script).
If you try this:
  strace -f /home/pozsy/b
You will get this:
execve("/home/pozsy/b", ["/home/pozsy/b"], [/* 24 vars */]) = 0
strace: exec: Exec format error

The root of the problem is still that /home/pozsy/b cannot be execve'd.
That is a kernel problem.

-- 
pozsy


