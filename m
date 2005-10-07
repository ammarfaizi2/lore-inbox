Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVJGBFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVJGBFo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 21:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVJGBFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 21:05:44 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:42510 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1751277AbVJGBFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 21:05:43 -0400
Message-ID: <4345C9CE.4060101@symas.com>
Date: Thu, 06 Oct 2005 18:05:18 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20050925 SeaMonkey/1.1a
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: Michael Concannon <mike@concannon.net>,
       Chase Venters <chase.venters@clientec.com>,
       Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <20051002204703.GG6290@lkcl.net> <200510041840.55820.chase.venters@clientec.com> <20051005102650.GO10538@lkcl.net> <200510060005.09121.chase.venters@clientec.com> <43453E7F.5030801@concannon.net> <20051006192857.GV10538@lkcl.net> <4345855B.3@concannon.net> <20051006212001.GZ10538@lkcl.net>
In-Reply-To: <20051006212001.GZ10538@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton wrote:
>
>  ... but heck - we do configuration of pretty much every major service
>  under the sun out of ldap, don't we?
>
>  and openldap itself just got the ability to read its own
>  config out of its own database, right?
>
>  it's not _that_ far off, not _that_ unachievable, s/ldap/registry. 

I think both you and Michael have interesting points on this topic. Fyi, 
OpenLDAP now has dynamic config (accessible/modifiable via LDAP) but the 
backing store is still a bunch of flat files. There were two objectives 
here - (1) make every knob tunable via LDAP, and (2) don't prevent an 
admin from fixing things with vi if they have to. I've spent too many 
times rescuing systems in single-user mode with only /bin/sh, to ever 
commit to using a binary config database.

Yes, KISS is a good policy, you just have to understand what the 'It' is 
that you're talking about in each instance. Putting a filesystem driver 
on top of a registry.dat file seems to provide a simple user interface, 
so it *looks* like you're adhering to KISS, but the innards are still 
both complex and fragile. Hell, even the simplest filesystem driver you 
can write is a couple hundred lines of code.

The LDAP-enabled config engine in OpenLDAP looks more structured / more 
complex than the old flat slapd.conf file, but under the covers it's all 
still plain text. In one case, you're taking something very complex and 
putting a simple cover on it, in the other you have very simple building 
blocks and put a complex / richer interface on top of it. Guess which 
design is more likely to keep functioning in the face of a system failure.

The Unix programming philosophy is about taking small simple tools and 
combining them to perform more complex tasks. You could say it's one of 
the world's earliest object-oriented UIs. If you don't keep that in 
mind, and try to build complexity in starting at your most basic 
building blocks on the bottom (i.e., the kernel) then you're going to 
have a nightmare trying to keep anything you build on top of it working. 
One only need look at MS Windows to see how true this is.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

