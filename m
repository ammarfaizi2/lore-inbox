Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVC3Uy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVC3Uy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVC3UwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:52:14 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:56810 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S261686AbVC3Usp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:48:45 -0500
Date: Wed, 30 Mar 2005 21:40:34 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Wiktor <victorjan@poczta.onet.pl>
Cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files
In-Reply-To: <424ACEA9.6070401@poczta.onet.pl>
Message-ID: <Pine.LNX.4.58.0503301939040.6713@be1.lrz>
References: <fa.ed33rit.1e148rh@ifi.uio.no> <E1DGNaV-0005LG-9m@be1.7eggert.dyndns.org>
 <424ACEA9.6070401@poczta.onet.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, Wiktor wrote:

> my xmms problem is unimportant here, i've posted this thread to propose 
> some new feature in filesystem, not to solve problem with multimedia player!

You don't need a solution if there is no problem.

> max renice ulimit is quite good idea, but it allows to change nice of 
> *any* process user has permissions to.

In both of your examples (including the one below), the same thing 
applies.

> it could be implemented also, but 
>   the idea of 'nice' file attribute is to allow *only* some process be 
> run with lower nice. what's more, that nice would be *always* the same 
> (at process startup)!
> example:
> web server runs as user www. it spawns perl interpreter that root wants 
>   to be run with lower nice, but he doesn't want to allow 'www' user to 
>   renice *any* process (for eg. this user is shared with webmaster, and 
> webmaster is malicious person; i know, the webmaster could have another 
> accout, but maybe for some file-ownership reasons, root doesn't want to 
> create special account for him).

chown root.root /usr/local/cgi-bin/somescript
chmod 755 /usr/local/cgi-bin/somescript

---/etc/su1.priv---
alias somescript /usr/bin/nice -n -5 su wwwrun -- exec /usr/local/cgi-bin/somescript.pl

ask never
allow wwwrun prefix somescript
---

ln -s /usr/bin/su1 /srv/wwwroot/cgi-bin/somescript


If you need the same command for a group of users, you can use a wrapper 
scritp that will look at the $HOME variable (which is set from 
/etc/passwd)

> in this situation, setting nice-attribute for /usr/bin/perl solves the 
> problem.

perl -e'exec("/bin/sh");' would grant nice privileges to anybody, and 
that's not nice!

> remember, that this feature would also provide an easy way to 
> increase nice level.

Not for running processes.

> it can be done with shell script, but setting nice 
> value in file attributes is cleaner and easier to manage.

Obviously not.
-- 
Top 100 things you don't want the sysadmin to say:
35. Ummm... Didn't you say you turned it off?
