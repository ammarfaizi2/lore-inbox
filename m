Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbVFWQE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVFWQE3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 12:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVFWQE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 12:04:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60139 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262594AbVFWQEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 12:04:21 -0400
Date: Thu, 23 Jun 2005 09:06:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
In-Reply-To: <42BA6177.8060202@pobox.com>
Message-ID: <Pine.LNX.4.58.0506230833170.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
 <42BA18AF.2070406@pobox.com> <Pine.LNX.4.58.0506221915280.11175@ppc970.osdl.org>
 <42BA6177.8060202@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Jun 2005, Jeff Garzik wrote:
> 
> Chuckle.  What does one call a Freudian slip, in computer-land?

A "Knuthian slip"?

> WARNING:  You have previously called git-changes-script quite ugly (not 
> surprising), and this 'git log x..y' will probably replace it in my 
> usage, long term.

Even short-term, you could actually make it prettier. 

You can actually use git across multiple directories by setting the
GIT_ALTERNATE_OBJECT_DIRECTORIES environment variable to point to the
alternate ones, so you should be able to do a "compare with remote" with 
something like this:

	export GIT_ALTERNATE_OBJECT_DIRECTORIES=$remote/.git/objects
	remote_head=$(cat $remote/.git/HEAD)
	git log $remote_head..

which should literally give a nice log of what is in your HEAD but not in 
$remote_head. And if you want to see it the other way? Just change the 
last line to

	git log HEAD..$remote_head

and voila, you're done.

The nice thing about this approach is that this works with other git
programs too, ie you can replace "git log" with "gitk", and suddenly you
see graphically the commits that are in your tree but not in the remote
HEAD or vice versa.

Yeah, yeah, totally untested and maybe I'm talking through by *ss, but it 
should work in theory.

		Linus
