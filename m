Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268134AbRGZP6z>; Thu, 26 Jul 2001 11:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268141AbRGZP6p>; Thu, 26 Jul 2001 11:58:45 -0400
Received: from pD951F257.dip.t-dialin.net ([217.81.242.87]:45446 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S268134AbRGZP61>; Thu, 26 Jul 2001 11:58:27 -0400
Date: Thu, 26 Jul 2001 17:58:33 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010726175833.X17244@emma1.emma.line.org>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	lkml <linux-kernel@vger.kernel.org>,
	"ext3-users@redhat.com" <ext3-users@redhat.com>
In-Reply-To: <20010726151749.M17244@emma1.emma.line.org> <E15PlYr-0003mr-00@the-village.bc.nu> <20010726163223.Q17244@emma1.emma.line.org> <0107261731550N.00907@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0107261731550N.00907@starship>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Daniel Phillips wrote:

> As I understand it, Ext2 allows much the same semantics.  While we do 
> need to do something about exposing a more elegant interface, with Ext3 
> you should be ok with +S and a "sync" just before you report to the 
> world that the mail transaction is complete.  Ext3 does *not* leave a 
> lot of dirty blocks hanging around in normal operation, so sync is not 
> nearly as slow as it is with good old Ext2.

That wasn't my impression, particularly not with data=journalling which
can drop data into the log. It's just: why sync the world if synching
directories does the job and relevant data is synched manually with
fsync()?

However, how big are chances that these interfaces will spread outside
of Linux? That's the crucial point for portable applications. If it's a
kernel <-> libc interface, OK, no problem, but if it's a user-space
interface, it might easily become a useless invention because no-one
uses it in real life. You don't support multiple interfaces in a
portable application because that's a maintenance disaster and often
causes reliability problems because on different platforms, code takes
different paths, so applications won't usually choose limited-use
interfaces (such as sendfile).

BTW, your Message-ID is unqualified == on a collision course in mail
duplicate killers.
