Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284022AbRLAJbC>; Sat, 1 Dec 2001 04:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284021AbRLAJaw>; Sat, 1 Dec 2001 04:30:52 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:33800 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S284020AbRLAJaj>;
	Sat, 1 Dec 2001 04:30:39 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Did someone try to boot 2.4.16 on a 386 ? [SOLVED] 
In-Reply-To: Your message of "Sat, 01 Dec 2001 10:11:40 BST."
             <20011201091140.62223.qmail@web20502.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 01 Dec 2001 20:29:51 +1100
Message-ID: <13800.1007198991@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2001 10:11:40 +0100 (CET), 
=?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr> wrote:
>Keith Owens wrote
>Anyway, I think that any tool, script or Makefile
>that modifies the source tree and which results in
>a diff between the two trees after a "make distclean"
>is at risk because it can induce diffs between some
>files that can't always apply to another clean tree.

ABSOLUTELY AGREE!!!!! (Is that too many exclamation marks?)

But try telling people that shipping files then overwriting them is a
bad idea.

>> BTW, cp -al of a pristine source tree to multiple
>> source trees followed by multiple compiles in
>> parallel is not safe either.
>
>Never needed to do that yet.

The moment you use cp -al on a kernel source tree, you are running the
risk of time stamp problems.

  cp -al pristine tree1
  cp -al pristine tree2
  cd tree1
  make *config bzImage
  cd tree2
  make *config bzImage

The make in tree1 and tree2 touches the time stamps on included files.
Because most include files are hard linked, it changes the time stamps
on all three trees, including the pristine source.  Even if you never
compile in tree1 and tree2 at the same time, when you switch back and
forth between trees you will get semi-random time stamp changes.

Normally the unwanted time stamp updates only forces spurious
recompiles, but I believe that there are some sequences that create an
incomplete kernel build.

