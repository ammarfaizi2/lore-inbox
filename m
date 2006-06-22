Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbWFVBXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbWFVBXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 21:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030483AbWFVBXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 21:23:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38552 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030481AbWFVBXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 21:23:04 -0400
Date: Wed, 21 Jun 2006 18:22:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.17
In-Reply-To: <20060621225134.GA13618@kroah.com>
Message-ID: <Pine.LNX.4.64.0606211814200.5498@g5.osdl.org>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606211519550.5498@g5.osdl.org>
 <20060621225134.GA13618@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Jun 2006, Greg KH wrote:
> 
> Ok, but how?  I'm generating the diffstat in my script with:
> 
> 	git diff origin..HEAD | diffstat -p1 >> $TMP_FILE

Btw, with a recent git (ie 1.4.0+), you can just do

	git diff -M --stat origin..HEAD

to do that much more efficiently, and without any external dependency on 
the "diffstat" program (with rename detection, you really need to do this 
using git itself, because "diffstat" doesn't understand rename patches 
being renames).

In fact, in a script, add the "--summary" option too, which gives a 
summary of file creation/deletion/renames at the end.

And as usual, the diff options work fine with "git log" too, so you can do

	git log -M --stat --summary

and it will do the right thing. Look at your ae0dadcf.. commit, for 
example.

Btw, the _one_ thing to be careful about is that when you generate a real 
patch with "-M", if that patch actually has a rename, then only "git 
apply" will be able to apply it correctly, and if somebody uses a regular 
"patch" program to apply it, they'll miss out on the rename, of course.

Some day maybe the git "extended patch format" is so univerally recognized 
to be superior that everybody understands them, in the meantime you may 
not want to use "-M" to generate patches unless you know the other end 
applies them with git.

(Which also explains why "-M" is not the default, of course).

		Linus
