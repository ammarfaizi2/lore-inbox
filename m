Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131724AbRDTVBS>; Fri, 20 Apr 2001 17:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131742AbRDTVBI>; Fri, 20 Apr 2001 17:01:08 -0400
Received: from tangens.hometree.net ([212.34.181.34]:10196 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S131724AbRDTVAr>; Fri, 20 Apr 2001 17:00:47 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@mail.hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: IP Acounting Idea for 2.5
Date: Fri, 20 Apr 2001 21:00:45 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9bq81t$9ct$1@forge.intermeta.de>
In-Reply-To: <Pine.LNX.4.33.0104152039130.1616-100000@asdf.capslock.lan> <01041708461209.00352@workshop> <20010416020732.30431.qmail@logi.cc> <20010416224321.O16697@corellia.laforge.distro.conectiva> <9bgpfa$329$1@forge.intermeta.de> <20010420131719.A2461@tatooine.laforge.distro.conectiva>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 987800445 25910 212.34.181.4 (20 Apr 2001 21:00:45 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 20 Apr 2001 21:00:45 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte <laforge@gnumonks.org> writes:

>On Tue, Apr 17, 2001 at 06:56:42AM +0000, Henning P. Schmiedehausen wrote:
>> 
>> Resettable counters in a security sensitive environment are just a
>> call for trouble. That's why you can't reset the SNMP counters on any
>> Cisco device I've encountered today. They learned their lesson. Maybe
>> you will, too.

>Well, I'm not sure about which SNTP counters you are talking, but I suppose
>it is not about per-filtering-rule counters, but something like per-interface
>counters, etc.

You don't want your counters going backward. Full stop. If a program
can reset your counter, your application will never know, if it was a
legal, correct, valid reason or just a hacker trying to hide his
traces. At least provide some sort of lock-down.

>There's always a way for somebody with root access to reset the counters of
>a rule: 

>just delete and re-insert the rule.

Bad thing. If you want to use the rules in a security sensitive
environment, don't allow removal. If you need to, reset the whole
module and notify the user. Better, shut down the filter and yell for
help.

ipfilter is about security, isn't it?

>If somebody wants to reset the counter, he can. If we remove the functionality
>from iptables, people still can - but it's more difficult.

There is no "more difficult", just "different ways". If you bother to
use a filtering environment where the filter counters tell e.g. "we
rejected xxx attacks", you don't want anyone to mess with these
counters. If this is a counter for a filtering rule, don't allow the
rule (and its counters) to be removed. Inactivate the rule but keep
the evidence (counter settings) around till module removal or reboot.

Sorry, I may be anal about security but as more and more people start
thinking "why should I bother with FW-1 or PIX when I can get a $99
Linux box and hack some filters", at least I want the $99 software
trying not to be sloppy about security.


 	Regards
 		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
