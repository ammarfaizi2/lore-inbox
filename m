Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030721AbWJKAPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030721AbWJKAPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 20:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030724AbWJKAPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 20:15:39 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:51823 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030721AbWJKAPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 20:15:37 -0400
Date: Tue, 10 Oct 2006 17:15:14 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: Paul Menage <menage@google.com>, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061011001514.GP7911@ca-server1.us.oracle.com>
Mail-Followup-To: Chandra Seetharaman <sekharan@us.ibm.com>,
	Paul Menage <menage@google.com>, akpm@osdl.org,
	ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com> <20061010215808.GK7911@ca-server1.us.oracle.com> <1160522032.6389.26.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160522032.6389.26.camel@linuxchandra>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 04:13:52PM -0700, Chandra Seetharaman wrote:
> On Tue, 2006-10-10 at 14:58 -0700, Joel Becker wrote:
> > 	Well, they now have to learn seq_file.  They now get to assume
> 
> If they are simple users, they don't have to "learn" seq_file semantics,
> they would just replace their sprintf's with seq_printfs (as my changes
> in OCFS2 show).

	The sed(1) is trivial sure.  seq_file isn't terribly complex.
It's less about mere code knowledge and more about intention.  Really,
it's how people understand configfs will deal with their attributes.

> "char *" can also be used to spew out large amount of data (ok, maybe up
> to PAGESIZE in configfs's case :). My point is that changing char * to
> seq_file doesn't necessarily "introduce" the issue (of spewing large
> amounts of data).

	If I see a seq_file, I assume there are multiple things to
iterate over.  Don't you?

> This issue is moot, unless you have intentions of changing the user
> interface of configfs to be anything other than a file system, isn't
> it ?

	It could be today, without much trouble.  The entire point is to
prevent client modules from implementing a filesystem or any filesystem
semantics.  They implement an item hierarchy with attributes.  The
attributes are read-write with ->show() and ->set().  The filesystem
should be invisible to the client.

> Now we are in need of *large* reads. We can add this feature and let it
> evolve to the next level later when somebody needs to *set* a large
> attribute.

	I don't want some set of ad-hoc rules based on legacy broken
ideas.  "Well, you can do this, or this, or this, or even this, and all
sort of work, but it's a mess" is not a good thing.

Joel

-- 

Life's Little Instruction Book #20

	"Be forgiving of yourself and others."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
