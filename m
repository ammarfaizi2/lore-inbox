Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422666AbWJOTHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWJOTHp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbWJOTHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:07:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14310 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161153AbWJOTHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:07:44 -0400
Date: Sun, 15 Oct 2006 12:07:14 -0700
From: Paul Jackson <pj@sgi.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: matthltc@us.ibm.com, linux-kernel@vger.kernel.org, gregkh@suse.de,
       sekharan@us.ibm.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
 configfs
Message-Id: <20061015120714.b0d67b9d.pj@sgi.com>
In-Reply-To: <20061014000951.GC2747@ca-server1.us.oracle.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	<20061010203511.GF7911@ca-server1.us.oracle.com>
	<6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	<20061010215808.GK7911@ca-server1.us.oracle.com>
	<1160527799.1674.91.camel@localhost.localdomain>
	<20061011012851.GR7911@ca-server1.us.oracle.com>
	<20061011220619.GB7911@ca-server1.us.oracle.com>
	<1160619516.18766.209.camel@localhost.localdomain>
	<20061012070826.GO7911@ca-server1.us.oracle.com>
	<1160782659.18766.549.camel@localhost.localdomain>
	<20061014000951.GC2747@ca-server1.us.oracle.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel, responding to Matt, wrote:
> > Hmm, that suggests a good point. While some one *can* do that or:
> > 
> > ATTR=( $(cat /sys/kernel/config/ckrm/myresource/attr) )
> > 
> > the space available for environment variables is limited. So attempting
> > to store a large (What's "large"?) attribute in an environment variable
> > is a potentially buggy practice. This is a significant problem affecting
> > large attributes in general.
> 
> 	If you can't do it in sh, it's pretty much out of scope.  This
> is a taste rule I use, because like to shell program.  Sure, not the end
> of the world (not a hard rule, I guess), but worth thinking about.

I too like to shell program.  Such potentially long vectors can
be worked in the shell, just not placed in a single command line
argument or environment variable.

Constructs that do work (using the list of process id's in the
file /dev/cpuset/tasks for these examples) include:

  1.  while read pid
      do
	  ... do something with each $pid ...
      done < /dev/cpuset/tasks


  2.  < /dev/cpuset/tasks xargs ps -flp


  3.  sed -un p < /dev/cpuset/foo/tasks > /dev/cpuset/tasks

Such shell constructs for dealing with vectors that might be longer
than argument or environment length limits have been needed and known
for decades.

In an earlier message, Joel wrote:
> 	You're effectively suggesting that a specific attribute type of
> "repeated value of type X".  No mixed types, no exploded structures,
> just a "list of this attr" sort of thing.  This does fit my personal
> requirement of avoiding a generic, abusable system.

Yes - what I call above a "vector."

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
