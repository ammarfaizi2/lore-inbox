Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVC3KTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVC3KTR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 05:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVC3KTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 05:19:17 -0500
Received: from viking.sophos.com ([194.203.134.132]:63761 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S261838AbVC3KTM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 05:19:12 -0500
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 30/03/2005 11:19:04,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 30/03/2005 11:19:04,
	Serialize complete at 30/03/2005 11:19:04,
	S/MIME Sign failed at 30/03/2005 11:19:04: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 30/03/2005 11:19:08,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 30/03/2005 11:19:08,
	Serialize complete at 30/03/2005 11:19:08,
	S/MIME Sign failed at 30/03/2005 11:19:08: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 30/03/2005 11:19:11,
	Serialize complete at 30/03/2005 11:19:11
To: Pavel Machek <pavel@ucw.cz>
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFB111F52D.BD661971-ON80256FD4.00377E92-80256FD4.0038AF50@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Wed, 30 Mar 2005 11:19:08 +0100
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2005 10:45:55 linux-kernel-owner wrote:

>> The solution is fairly well known.  Rather than treating the zillions 
of
>> disk seeks during the boot process as random unconnected events, you
>
>Heh, we actually tried that at SuSE and yes, eliminating seeks helps a
>bit, but no, it is not magicall cure you'd want it to be.
>
>Only solution seems to be "do less during boot".

What about the init scripts? They are all spawned from the master one, 
they all spawn zillions of simple utilities. And udev startup time under 
SuSE 9.2 is just awful. It might be the Unix way but it is killing the 
boot process.

What I tried to do once, and I even contacted somebody from SuSE with a 
working proof of concept code is the following:

Master init script written in Perl. All the service init scripts rewritten 
in Perl which can be invoked independently, but they all follow the 
convention and implement functions such as start() stop() reload() etc.. 
Then the master init script includes one at a time and "evals" them (well 
just the function which it is interested in). Since everything is written 
in Perl there is no need to invoke external greps, seds, cuts etc.. And 
rc.status was also only processed once (by the master init script).

It was fast but I don't have any exact numbers because I only implemented 
rc, rc.boot, rc.status and sshd (AFAIR) before giving up. I think I should 
be able to dig that code from somewhere if someone is interested...

