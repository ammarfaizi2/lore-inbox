Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVDJJ3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVDJJ3E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 05:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVDJJ3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 05:29:03 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:13242 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261452AbVDJJ26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 05:28:58 -0400
To: Christopher Li <lkml@chrisli.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	<7vhdifcbmo.fsf@assigned-by-dhcp.cox.net>
	<20050410055340.GB13853@64m.dyndns.org>
From: Junio C Hamano <junkio@cox.net>
Date: Sun, 10 Apr 2005 02:28:54 -0700
In-Reply-To: <20050410055340.GB13853@64m.dyndns.org> (Christopher Li's
 message of "Sun, 10 Apr 2005 01:53:40 -0400")
Message-ID: <7v7jjbc755.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "CL" == Christopher Li <lkml@chrisli.org> writes:

CL> On Sun, Apr 10, 2005 at 12:51:59AM -0700, Junio C Hamano wrote:
>> 
>> But I am wondering what your plans are to handle renames---or
>> does git already represent them?
>> 

CL> Rename should just work.  It will create a new tree object and you
CL> will notice that in the entry that changed, the hash for the blob
CL> object is the same.

Sorry, I was unclear.  But doesn't that imply that a SCM built
on top of git storage needs to read all the commit and tree
records up to the common ancestor to show tree diffs between two
forked tree?

I suspect that another problem is that noticing the move of the
same SHA1 hash from one pathname to another and recognizing that
as a rename would not always work in the real world, because
sometimes people move files *and* make small changes at the same
time.  If git is meant to be an intermediate format to suck
existing kernel history out of BK so that the history can be
converted for the next SCM chosen for the kernel work, I would
imagine that there needs to be a way to represent such a case.
Maybe convert a file rename as two git trees (one tree for pure
move which immediately followed by another tree for edit) if it
is not a pure move?


