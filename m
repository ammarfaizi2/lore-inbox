Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268520AbUILHrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268520AbUILHrX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 03:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268525AbUILHrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 03:47:23 -0400
Received: from polaris.galacticasoftware.com ([206.45.95.222]:13515 "EHLO
	polaris.galacticasoftware.com") by vger.kernel.org with ESMTP
	id S268520AbUILHrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 03:47:07 -0400
Message-ID: <4143FEFE.7020800@galacticasoftware.com>
Date: Sun, 12 Sep 2004 02:47:10 -0500
From: Adam Majer <adamm@galacticasoftware.com>
Organization: Galactica Software Corporation
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wolfpaw - Dale Corse <admin-lists@wolfpaw.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [grsec] Linux 2.4.27 SECURITY BUG - TCP Local (probable Remote)
 Denial of Service
References: <004c01c49848$2608e180$0200a8c0@wolf>
In-Reply-To: <004c01c49848$2608e180$0200a8c0@wolf>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfpaw - Dale Corse wrote:

>Greetings,
>
> My apologies if this is to the wrong place - it happens to be the
>first kernel bug I have found (or what appears to be one), and I'm
>not entirely sure how to properly inform the Linux community about
>it. 
>
>Anyway - on to the bug :)
>==========================
>Severity: HIGH
>Title: KERNEL: TCP Local (probable remote) Denial of Service
>Date: September 11, 2004
>  
>

Actually, it seems that the sockets that are not closing properly are
the ones opened by your proof of concept code, *NOT* the server. The
servers (mysql and Apache), close their sockets properly. I could verify
this over a network. Locally, I got

tcp        0      0 192.168.53.2:41440      192.168.53.1:3306      
TIME_WAIT
tcp        0      0 192.168.53.2:41442      192.168.53.1:3306      
TIME_WAIT
tcp        0      0 192.168.53.2:41443      192.168.53.1:3306      
TIME_WAIT
tcp        0      0 192.168.53.2:41452      192.168.53.1:3306      
TIME_WAIT
tcp        0      0 192.168.53.2:41468      192.168.53.1:80        
TIME_WAIT
tcp        0      0 192.168.53.2:41441      192.168.53.1:80        
TIME_WAIT
tcp        0      0 192.168.53.2:41447      192.168.53.1:80        
TIME_WAIT
tcp        0      0 192.168.53.2:41444      192.168.53.1:80         TIME

etc..

But on the server, only 1 or two ESTABISHED entries, nothing more.

I don't see much of a DOS, except maybe to DOS a localhost. And you can
do that already.

>The socket table looks like this while it is going on:
>
>http://www.ancients.org/LG.txt
>(it is 29,000+ lines, so I didn't put it here)
>  
>


-- 
Building your applications one byte at a time
http://www.galacticasoftware.com


