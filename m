Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752344AbWKGUf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbWKGUf0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbWKGUf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:35:26 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:42214 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1752344AbWKGUfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:35:25 -0500
Date: Tue, 7 Nov 2006 12:34:58 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061107123458.e369f62a.pj@sgi.com>
In-Reply-To: <6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
References: <20061030031531.8c671815.pj@sgi.com>
	<20061030123652.d1574176.pj@sgi.com>
	<6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
	<20061031115342.GB9588@in.ibm.com>
	<6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
	<20061101172540.GA8904@in.ibm.com>
	<6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	<20061106124948.GA3027@in.ibm.com>
	<6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
	<20061107104118.f02a1114.pj@sgi.com>
	<6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wroteL
> One of the issues that crops up with it is what do you put in
> /proc/<pid>/container if there are multiple hierarchies?

Thanks for your rapid responses - good.

How about /proc/<pid>/containers being a directory, with each
controller having one regular file entry (so long as we haven't done
the multiple controller instances in my item (5)) containing the path,
relative to some container file system mount point (which container
mount is up to user space code to track) of the container that contains
that task?

Or how about each controller type, such as cpusets, having its own
/proc/<pid>/<controller-type> file, with no generic file
/proc</pid>/container at all.  Just extend the current model
seen in /proc/<pid>/cpuset ?

Actually, I rather like that last alternative - forcing the word
'container' into these /proc/<pid>/??? pathnames strikes me as
an exercise in branding, not in technical necessity.  But that
could just mean I am still missing a big fat clue somewhere ...

Feel free to keep hitting me with clue sticks, as need be.

It will take a while (as in a year or two) for me and others to train
all the user level code that 'knows' that cpusets are always mounted at
"/dev/cpuset" to find the mount point for the container handling
cpusets anywhere else.

I knew when I hardcoded the "/dev/cpuset" path in various places
in user space that I might need to revisit that, but my crystal
ball wasn't good enough to predict what form this generalization
would take.  So I followed one of my favorite maxims - if you can't
get it right, at least keep it stupid, simple, so that whomever does
have to fix it up has the least amount of legacy mechanism to rip out.

However this fits in nicely with my expectation that we will have
only limited need, if any, in the short term, to run systems with
both cpusets and resource groups at the same time.  Systems just
needing cpusets can jolly well continue to mount at /dev/cpuset,
in perpetuity.  Systems needing other or fancier combinations of
controllers will need to handle alternative mount points, and keep
track somehow in user space of what's mounted where.

And while we're here, how about each controller naming itself with a
well known string compiled into its kernel code, and a file such
as /proc/containers listing what controllers are known to it?  Not
surprisingly, I claim the word "cpuset" to name the cpuset controller ;)

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
