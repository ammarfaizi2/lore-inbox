Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVC3QE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVC3QE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 11:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVC3QE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 11:04:27 -0500
Received: from smtp8.poczta.onet.pl ([213.180.130.48]:8145 "EHLO
	smtp8.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262296AbVC3QEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 11:04:22 -0500
Message-ID: <424ACEA9.6070401@poczta.onet.pl>
Date: Wed, 30 Mar 2005 18:07:05 +0200
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files
References: <fa.ed33rit.1e148rh@ifi.uio.no> <E1DGNaV-0005LG-9m@be1.7eggert.dyndns.org>
In-Reply-To: <E1DGNaV-0005LG-9m@be1.7eggert.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> Wiktor <victorjan@poczta.onet.pl> wrote:
>>so i thought that it would be nice to add an attribute to file
>>(changable only for root) that would modify nice value of process when
>>it starts. if there is one byte free in ext2/3 file metadata, maybe it
>>could be used for that? i think that it woundn't be more dangerous than
>>setuid bit.
> 
> I guess there should be a maximum renice value ulimit instead, which would
> allow running allmost any user task on a higher nice level, except the
> important stuff, with the additional benefit of being able to temporarily
> renice some tasks until the more important work is done.
> 
> I remember something similar being discussed for realtime tasks, but I don't
> remember the outcome.

my xmms problem is unimportant here, i've posted this thread to propose 
some new feature in filesystem, not to solve problem with multimedia player!

max renice ulimit is quite good idea, but it allows to change nice of 
*any* process user has permissions to. it could be implemented also, but 
  the idea of 'nice' file attribute is to allow *only* some process be 
run with lower nice. what's more, that nice would be *always* the same 
(at process startup)!
example:
web server runs as user www. it spawns perl interpreter that root wants 
  to be run with lower nice, but he doesn't want to allow 'www' user to 
  renice *any* process (for eg. this user is shared with webmaster, and 
webmaster is malicious person; i know, the webmaster could have another 
accout, but maybe for some file-ownership reasons, root doesn't want to 
create special account for him).
in this situation, setting nice-attribute for /usr/bin/perl solves the 
problem. remember, that this feature would also provide an easy way to 
increase nice level. it can be done with shell script, but setting nice 
value in file attributes is cleaner and easier to manage.

could it be implemented in some near future? thx for replies.

--
wixor
May the Source be with you.
