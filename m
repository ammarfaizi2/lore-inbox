Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945965AbWJaUEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945965AbWJaUEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945966AbWJaUEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:04:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:51046 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1945965AbWJaUEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:04:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=cAcHh0E9MZIKHtF5cdP5O1plwZREKC4GvYgT4N4Rh9VAIO0eqOa4RAEcWAvsq/bUvOG1x2gCz8Lk12phdlArHffW5lVPlxpv6fbkQHgWm/iQNhs5YZFvWFz0MvctjBFo5mvBdj8HCmhYeG3deaNVUIOGtioK0TMIZT6eyAqk42w=
Date: Tue, 31 Oct 2006 21:04:08 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Suspend to disk:  do we HAVE to use swap?
Message-ID: <20061031200407.GA5194@dreamland.darkstar.lan>
References: <20061031174006.GA31555@dreamland.darkstar.lan> <200610311905.33667.s0348365@sms.ed.ac.uk> <200610312019.38368.rjw@sisk.pl> <4547A6D7.5090309@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4547A6D7.5090309@comcast.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Tue, Oct 31, 2006 at 02:41:11PM -0500, John Richard Moser ha scritto: 
> Rafael J. Wysocki wrote:
> > On Tuesday, 31 October 2006 20:05, Alistair John Strachan wrote:
> >> On Tuesday 31 October 2006 17:40, Luca Tettamanti wrote:
> >>> Alistair John Strachan <s0348365@sms.ed.ac.uk> ha scritto:
> >>>> On Tuesday 31 October 2006 06:16, Rafael J. Wysocki wrote:
> >>>> [snip]
> >>>>
> >>>>> However, we already have code that allows us to use swap files for the
> >>>>> suspend and turning a regular file into a swap file is as easy as
> >>>>> running 'mkswap' and 'swapon' on it.
> >>>> How is this feature enabled? I don't see it in 2.6.19-rc4.
> >>> Swap files have been supported for ages. suspend-to-swapfile is very
> >>> new, you need a -mm kernel and userspace suspend from CVS:
> >>> http://suspend.sf.net
> >> I know, I use swap files, and not a partition. This has prevented me from 
> >> using suspend to disk "for ages". ;-)
> >>
> >> Is userspace suspend REQUIRED for this feature?
> > 
> > No, but unfortunately one piece is still missing: You'll need to figure out
> > where your swap file's header is located.
> > 
> > However, if you apply the attached patch the kernel will tell you where it is
> > (after you do 'swapon' grep dmesg for 'swap' and use the value in the
> > 'offset' field).
> 
> Nobody has answered this one yet:  Once you 'swapon' doesn't the kernel
> have (require?) the swap file opened writable?  Simple mode:
> 
>   IS THIS NOT EXTREMELY DANGEROUS?

The trick is that the FS hosting the swapfile is *not* mounted at all;
you don't even activate the swap. resume process uses the block number
(better: the couple <devid, block>) to locate the swapfile.
The "ugly" part of this method is that the user has to figure out the
first block of the swapfile, since at resume time it's not possibile to
mount the fs (not even read only - journaled filesystems will blow up
due to journal replay) to search the swap area...

Luca
-- 
Windows /win'dohz/ n. : thirty-two  bit extension and graphical shell to
a sixteen  bit patch to an  eight bit operating system  originally coded
for a  four bit microprocessor  which was  written by a  two-bit company
that can't stand a bit of competition.
