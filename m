Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288290AbSACTit>; Thu, 3 Jan 2002 14:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288287AbSACTik>; Thu, 3 Jan 2002 14:38:40 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:46328 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S288258AbSACTi0>;
	Thu, 3 Jan 2002 14:38:26 -0500
Date: Thu, 3 Jan 2002 12:36:23 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Message-ID: <20020103123623.X12868@lynx.no>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <200201031605.g03G57e22947@guppy.limebrokerage.com> <E16MAp4-00018b-00@starship.berlin> <20020103143630.D25846@conectiva.com.br> <E16MBIw-00018y-00@starship.berlin> <20020103150705.F25846@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20020103150705.F25846@conectiva.com.br>; from acme@conectiva.com.br on Thu, Jan 03, 2002 at 03:07:05PM -0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 03, 2002  15:07 -0200, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 03, 2002 at 06:05:19PM +0100, Daniel Phillips escreveu:
> > On January 3, 2002 05:36 pm, Arnaldo Carvalho de Melo wrote:
> > > Maybe CodingStyle should have an entry for this, I'd vote for this style:
> > >
> > > static inline struct inode *new_inode(struct super_block *sb)
> > 
> > OK, I'll revise it to that style.  Shall we start an official janitor's
> > style guide? ;-)
> 
> Nah, I'll try and submit some patches do CodingStyle, for discussion. Hey,
> people here _love_ to discuss important things like coding style, dontcha?

While you are at it, the following patch to scripts/Lindent makes it do the
right thing as well.  From what I can see, the following is more consistent
with the actual practise in the kernel code.  Sadly, indent (v2.2.4) will
break the indenting of any line with a colon (e.g. labels, named struct
initialization), so it is not possible to just run Lindent on the whole
tree.


I removed the following two options:
-bs: Put a space between sizeof and its argument.
-psl: Put the type of a procedure on the line before its name.

I added the following options:
-nbbo: don't prefer to break lines before boolean operators
-ci8: indent continuation lines 8 characters
-ncs: Do not put a space after cast operators.
-lps: Leave space between # and preprocessor directive.
-pmt: Preserve access and modification times on output files.
-npro: Do not read .indent.pro files.


diff -u linux.orig/scripts/Lindent linux/scripts/Lindent
--- linux.orig/scripts/Lindent	Wed Nov 28 23:25:14 2001
+++ linux/scripts/Lindent	Thu Jan  3 12:10:00 2002
@@ -1,2 +1,37 @@
 #!/bin/sh
-indent -kr -i8 -ts8 -sob -l80 -ss -bs -psl "$@"
+indent -kr -nbbo -ci8 -ncs -i8 -l80 -lps -pmt -npro -sob -ss -ts8 "$@"

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

