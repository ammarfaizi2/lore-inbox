Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTKZAZQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 19:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTKZAZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 19:25:16 -0500
Received: from smtpq1.home.nl ([213.51.128.196]:21697 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S263221AbTKZAZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 19:25:10 -0500
From: Gertjan van Wingerde <gwingerde@home.nl>
Reply-To: gwingerde@home.nl
To: Andrew Morton <akpm@osdl.org>
Subject: Re: EXT-3 bug with 2.6.0-test9
Date: Wed, 26 Nov 2003 01:24:28 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200311252051.15501.gwingerde@home.nl> <20031125122504.47de1ea5.akpm@osdl.org>
In-Reply-To: <20031125122504.47de1ea5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311260124.28453.gwingerde@home.nl>
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A forced fsck of all my file-systems seems to have cured this. At least its 
not easy to trigger anymore (not even in test9).
I looked something really had gone wrong sometime. I got multiple filesystems
with errors on it (without it had been noticed; all had to have a forced fsck 
not a "normal" one).

But, so far so good.

	Gertjan.

On Tuesday 25 November 2003 21:25, Andrew Morton wrote:
> Gertjan van Wingerde <gwingerde@home.nl> wrote:
> > Hi,
> >
> > (Please CC me in any replies, as I'm not subscribed to the list)
> >
> > I've just experienced the strange behaviour that my /usr mount
> > auto-magically got mounted read-only, where it was mounted read-write
> > (obviously). Investigating the cause of this I've found the following
> > EXT-3 related BUG in my log-files:
> >
> > 	kernel BUG at fs/jbd/journal.c:1733!
>
> Yes.  This newly-added BUG check was too easy to trigger and in test10 it
> was changed to a printk-and-fix-it-up.
>
> > Nov 25 20:24:20 localhost vmunix: EXT3-fs warning (device md1):
> > ext3_unlink: Deleting nonexistent file (230991), 0
> > Nov 25 20:24:21 localhost vmunix: EXT3-fs warning (device md1):
> > ext3_unlink: Deleting nonexistent file (230990), 0
> > Nov 25 20:24:21 localhost vmunix: EXT3-fs warning (device md1):
> > ext3_unlink: Deleting nonexistent file (346096), 0
>
> And it is this stuff which triggered the bogus BUG.  I do not know why this
> happened, but it is probably some form of data loss problem at the md
> layer.
>
> It could have happened at any time after the most recent fsck, so if you
> have been running earlier kernels on that machine it could even be that the
> bug which caused this has already been fixed.
>
> You should run a fsck across all filesystems, and maybe upgrade to test10
> plus
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.0-test10-bk1
>.gz

