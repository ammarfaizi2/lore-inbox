Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTEKRdm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 13:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTEKRdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 13:33:42 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:15117 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP id S261801AbTEKRdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 13:33:41 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: The disappearing sys_call_table export.
Date: 11 May 2003 17:20:26 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <b9m0oq$2sp$1@abraham.cs.berkeley.edu>
References: <200305111234_MC3-1-3865-CD21@compuserve.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1052673626 2969 128.32.153.211 (11 May 2003 17:20:26 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 11 May 2003 17:20:26 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert  wrote:
>  How about:

Here's a good rule of thumb:
  In security, if you need to ask, it's probably broken.

The way to do security design is NOT by throwing a few kludgy hacks
against the wall and seeing if any of them stick.  That's a recipe for
security holes.  The way you get security right is by building a clean,
simple design that you can convincingly argue to be correct.  In security,
you don't write code until you've got your assurance argument down pat.

If you can't convince yourself it's correct, it's probably not.

>        copy_from_user(name1, userfilename, ...);
>        ret = original_unlink(userfilename);
>        copy_from_user(name2, userfilename, ...);

Insecure.  Simply exploit the race condition twice: once just before
the original_unlink() to change the string to a dangerous filename,
then a second time just after the original_unlink() to change it back.
