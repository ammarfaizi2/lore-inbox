Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161343AbWG1WoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161343AbWG1WoE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 18:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161345AbWG1WoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 18:44:04 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:23176 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1161343AbWG1WoD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 18:44:03 -0400
Date: Sat, 29 Jul 2006 00:43:58 +0200
From: DervishD <lkml@dervishd.net>
To: Edgar Toernig <froese@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] /dev/itimer
Message-ID: <20060728224358.GA1824@DervishD>
Mail-Followup-To: Edgar Toernig <froese@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20060728235951.7de534eb.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060728235951.7de534eb.froese@gmx.de>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Edgar :)

 * Edgar Toernig <froese@gmx.de> dixit:
> Everytime I have to write code to do something at regular
> intervals I face the problem that the time routines on Unix 
> are pretty archaic.  Only a single process wide timer which
> notifies via signals.  The single timer asks for a dedicated
> roll-your-own timer infrastructur, usually implemented via
> a lot of gettimeofday calls and appropriate select timeouts.

    I wrote a timer multiplexor library a time ago, but it had
problems due to signals (if a SIGALRM was lost, the entire timer
multiplexor stopped), wasn't very precise and although portable, it
depended entirely on reliable signals.

    With your /dev/itimer, ALL problems are gone. It's a very good
idea, simple to use, very practical and almost language independent.
You're an effin genius ;)))

    I hope this goes into the kernel, because I'm not sure how to do
this from userspace reliably. My timer multiplexor library was just a
queue of events, with a SIGALRM raised when the nearest event
expired. When the signal was raised, the expiration time for the next
event is computed and the next SIGALRM is programmed to that time.
There is some precission loss :(( and sometimes a SIGALRM was missed
and the entire multiplexor stopped. I didn't investigate the issue
because I wanted a better solution instead of trying to beat a dead
horse ;)) This looks like a better solution! At least, I don't know
about any other timer multiplexor (or multiple timers for an
applicatoin) library or code.

    Thanks a lot!, and good luck getting this into the kernel. Any
chance of it being backported to 2.4.x?

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
