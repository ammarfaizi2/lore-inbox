Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262695AbSJBW5g>; Wed, 2 Oct 2002 18:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262696AbSJBW5g>; Wed, 2 Oct 2002 18:57:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11185 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262695AbSJBW5f>;
	Wed, 2 Oct 2002 18:57:35 -0400
Date: Wed, 2 Oct 2002 19:02:57 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Kevin Corry <corryk@us.ibm.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: EVMS Submission for 2.5
In-Reply-To: <02100217031903.18102@boiler>
Message-ID: <Pine.GSO.4.21.0210021848420.13480-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Oct 2002, Kevin Corry wrote:

> So the question is, will there be a method to simply get a list of registered 
> disks on the system, or an API to call to run a function for each disk? If 
> so, we'll gladly switch to using that. If not, do you have any suggestions 
> for how this kind of functionality can be achieved with your upcoming changes?

That _really_ depends on the nature of functions you want to call that
way.

I might agree with something along the lines of
	* when evms is initialized, it's notified of all existing gendisks
	* whenever disk is added after evms initialization, we notify evms
	* whenever disk is removed, we notify evms

However, I doubt that it's what you really want.  In particular, you
probably want to see partitioning changes as well as gendisk ones
(and no, "evms will handle all partitioning" is _not_ an acceptable
answer).  Moreover, "gendisk is here" != "something is in the drive".

IOW, the real question is what are you going to do with that list of
gendisks?

