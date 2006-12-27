Return-Path: <linux-kernel-owner+w=401wt.eu-S932904AbWL0EZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904AbWL0EZU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 23:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932907AbWL0EZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 23:25:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:13500 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932904AbWL0EZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 23:25:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dXCgDJrECrFWEmdrpR5+6dZuDKnOlXy4VDUsZ/ba9YOsfrRGElb1NbTeCChiDUtHrYkVDEhhG5BmIa4I8wsXx0Jc1mxAcChCAFeos8F9IuXKO6jYGIpa67D6JyMud9Eu7CoE89fQ+BB7BlDieaKv+dkH+2orQNqRTh2pNY9zJ7M=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: Feature request: exec self for NOMMU.
Date: Wed, 27 Dec 2006 05:24:36 +0100
User-Agent: KMail/1.8.2
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
       David McCullough <david_mccullough@au.securecomputing.com>
References: <200612261823.07927.rob@landley.net> <Pine.LNX.4.63.0612261549050.24795@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0612261549050.24795@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612270524.36157.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 00:55, David Lang wrote:
> On Tue, 26 Dec 2006, Rob Landley wrote:
> 
> > I'm trying to make some nommu-friendly busybox-like tools, which means using
> > vfork() instead of fork().  This means that after I fork I have to exec in
> > the child to unblock the parent, and if I want to exec my current executable
> > I have to find out where it lives so I can feed the path to exec().  This is
> > nontrivial.
> >
> > Worse, it's not always possible.  If chroot() has happened since the program
> > started, there may not _be_ a path to my current executable available from
> > this process's current or root directories.
> 
> does this even make sense (as a general purpose function)? if the executable 
> isn't available in your path it's likly that any config files it needs are not 
> available either.

busybox needs it in order to spawn, for example, gzip/bzip2 helper
for tar. We know that our own executable has this function.
How to execute _our own executable_? exec("/proc/self/exe")
works only if /proc is mounted. I can imagine that some embedded
people want to be able to not rely on that.
--
vda
