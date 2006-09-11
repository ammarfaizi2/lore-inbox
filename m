Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWIKSaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWIKSaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 14:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWIKSaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 14:30:10 -0400
Received: from soloth.lewis.org ([69.28.69.2]:2727 "EHLO soloth.lewis.org")
	by vger.kernel.org with ESMTP id S932276AbWIKSaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 14:30:08 -0400
Date: Mon, 11 Sep 2006 14:29:58 -0400 (EDT)
From: Jon Lewis <jlewis@remove2reply.lewis.org>
X-X-Sender: jlewis@soloth.lewis.org
To: Perego Paolo Franco <p.perego@reply.it>, linux-kernel@vger.kernel.org
cc: Hadmut Danisch <hadmut@danisch.de>, bugtraq@securityfocus.com
Subject: Re: R: Linux kernel source archive vulnerable
In-Reply-To: <D432C2F98B6D1B4BAE47F2770FEFD6B612B8B7@to1mbxs02.replynet.prv>
Message-ID: <Pine.LNX.4.61.0609111334460.2498@soloth.lewis.org>
References: <20060907182304.GA10686@danisch.de>
 <D432C2F98B6D1B4BAE47F2770FEFD6B612B8B7@to1mbxs02.replynet.prv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-milter-ns-Report: remove2reply.lewis.org; NS 31954 ns1.atlantic.net. [209.208.0.7]; NS 31954 ns2.atlantic.net. [209.208.42.140]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006, Perego Paolo Franco wrote:

> Anyway just few considerations:
> 2) a good sysadmin is aware that /usr/src is NOT supposed to be world 
> writable

Ownership/permissions on /usr/src are irrelevant.  For some reason (bug in 
how they're being checked out of git, I assume), the latest kernel source 
tar files have all files and directories world writable.  This is not how 
it's been in the past and is not how it should be.

The change happened between 2.6.13.3 and 2.6.13.4.

$ tar -tvjf /var/ftp/pub/Linux/ftp.kernel.org/pub/linux/kernel/v2.6/linux-2.6.13.3.tar.bz2 | less
tar: Record size = 8 blocks
drwxr-xr-x git/git           0 2005-10-03 19:27:35 linux-2.6.13.3/
-rw-r--r-- git/git       18691 2005-10-03 19:27:35 linux-2.6.13.3/COPYING
-rw-r--r-- git/git       89317 2005-10-03 19:27:35 linux-2.6.13.3/CREDITS
drwxr-xr-x git/git           0 2005-10-03 19:27:35 linux-2.6.13.3/Documentation/
-rw-r--r-- git/git       10244 2005-10-03 19:27:35 linux-2.6.13.3/Documentation/00-INDEX
-rw-r--r-- git/git        3699 2005-10-03 19:27:35 linux-2.6.13.3/Documentation/BUG-HUNTING
-rw-r--r-- git/git       13072 2005-10-03 19:27:35 linux-2.6.13.3/Documentation/Changes
-rw-r--r-- git/git       15351 2005-10-03 19:27:35 linux-2.6.13.3/Documentation/CodingStyle
-rw-r--r-- git/git       20407 2005-10-03 19:27:35 linux-2.6.13.3/Documentation/DMA-API.txt
-rw-r--r-- git/git       31996 2005-10-03 19:27:35 linux-2.6.13.3/Documentation/DMA-mapping.txt
drwxr-xr-x git/git           0 2005-10-03 19:27:35 linux-2.6.13.3/Documentation/DocBook/

$ tar -tvjf /var/ftp/pub/Linux/ftp.kernel.org/pub/linux/kernel/v2.6/linux-2.6.13.4.tar.bz2 | less
tar: Record size = 8 blocks
drwxr-xr-x git/git           0 2005-10-10 14:54:29 linux-2.6.13.4/
-rw-rw-rw- git/git       18691 2005-10-10 14:54:29 linux-2.6.13.4/COPYING
-rw-rw-rw- git/git       89317 2005-10-10 14:54:29 linux-2.6.13.4/CREDITS
drwxrwxrwx git/git           0 2005-10-10 14:54:29 linux-2.6.13.4/Documentation/
-rw-rw-rw- git/git       10244 2005-10-10 14:54:29 linux-2.6.13.4/Documentation/00-INDEX
-rw-rw-rw- git/git        3699 2005-10-10 14:54:29 linux-2.6.13.4/Documentation/BUG-HUNTING
-rw-rw-rw- git/git       13072 2005-10-10 14:54:29 linux-2.6.13.4/Documentation/Changes
-rw-rw-rw- git/git       15351 2005-10-10 14:54:29 linux-2.6.13.4/Documentation/CodingStyle
-rw-rw-rw- git/git       20407 2005-10-10 14:54:29 linux-2.6.13.4/Documentation/DMA-API.txt
-rw-rw-rw- git/git       31996 2005-10-10 14:54:29 linux-2.6.13.4/Documentation/DMA-mapping.txt
drwxrwxrwx git/git           0 2005-10-10 14:54:29 linux-2.6.13.4/Documentation/DocBook/

In the very latest, even the source tree's root is 777.

$ tar -tvjf /var/ftp/pub/Linux/ftp.kernel.org/pub/linux/kernel/v2.6/linux-2.6.17.13.tar.bz2 | less
tar: Record size = 8 blocks
drwxrwxrwx git/git           0 2006-09-08 23:23:25 linux-2.6.17.13/
-rw-rw-rw- git/git         462 2006-09-08 23:23:25 linux-2.6.17.13/.gitignore
-rw-rw-rw- git/git       18693 2006-09-08 23:23:25 linux-2.6.17.13/COPYING
-rw-rw-rw- git/git       89536 2006-09-08 23:23:25 linux-2.6.17.13/CREDITS
drwxrwxrwx git/git           0 2006-09-08 23:23:25 linux-2.6.17.13/Documentation/
-rw-rw-rw- git/git       10581 2006-09-08 23:23:25 linux-2.6.17.13/Documentation/00-INDEX
-rw-rw-rw- git/git        7249 2006-09-08 23:23:25 linux-2.6.17.13/Documentation/BUG-HUNTING
-rw-rw-rw- git/git       11655 2006-09-08 23:23:25 linux-2.6.17.13/Documentation/Changes

----------------------------------------------------------------------
  Jon Lewis                   |  I route
  Senior Network Engineer     |  therefore you are
  Atlantic Net                |
_________ http://www.lewis.org/~jlewis/pgp for PGP public key_________
