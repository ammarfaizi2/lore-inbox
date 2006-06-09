Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030524AbWFIVcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbWFIVcm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030523AbWFIVcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:32:42 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:28325 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030520AbWFIVcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:32:41 -0400
Message-ID: <4489E8EF.5020508@garzik.org>
Date: Fri, 09 Jun 2006 17:32:31 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Theodore Tso <tytso@mit.edu>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com> <20060609205036.GI7420@redhat.com>
In-Reply-To: <20060609205036.GI7420@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> Am I missing something fundamental that precludes the use of both
> extent-based and current existing filesystems from the same code
> simultaneously ?

Nothing precludes it.  The point is that introducing major format 
changes inline in this manner just complicates the code progressively to 
the point where your directory walking, inode block walking, and other 
code winds up being

	if (new)
		...
	else
		...

_anyway_, at which point it is essentially multiple independent 
filesystems.  I guarantee this won't be the last fundamental fs metadata 
design change people will want to make...

	Jeff


