Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVBXDYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVBXDYc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 22:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVBXDYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 22:24:32 -0500
Received: from mserv2.uoregon.edu ([128.223.142.41]:54428 "EHLO
	smtp.uoregon.edu") by vger.kernel.org with ESMTP id S261763AbVBXDY3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 22:24:29 -0500
Date: Wed, 23 Feb 2005 19:24:27 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Ron Peterson <rpeterso@mtholyoke.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext2/3 files per directory limits
In-Reply-To: <20050224031107.GA8656@mtholyoke.edu>
Message-ID: <Pine.LNX.4.61.0502231920000.18737@twin.uoregon.edu>
References: <20050224031107.GA8656@mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005, Ron Peterson wrote:

> I would like to better understand ext2/3's performance characteristics.
>
> I'm specifically interested in how ext2/3 will handle a /var/spool/mail
> directory w/ ~6000 mbox format inboxes, handling approx 1GB delivered as
> 75,000 messages daily.  Virtually all access is via imap, w/ approx
> ~1000 imapd processes running during peak load.  Local delivery is via
> procmail, which by default uses both kernel-supported locking calls and
> .lock files.

At some point it makes sense to subdivide you mail load because 
serialization of i/o on that one filesystem becomes a bigger issue than 
the performance of your filesystem... We deliver into mbox formatted 
mailboxes inside users homedirs, some folks do a similar thing with 
maildir. In the end you can on make one filesystem so fast. beyond that 
you need more filesystems to acheive any kind of reasonable scaling...

> I understand that various tuning parameters will have an impact,
> e.g. putting the journal on a separate device, setting the noatime mount
> option, etc.  I also understand that there are other mailbox formats and
> other strategies for locating mail spools (e.g. in user's home
> directories).
>
> I'm interested in people's thoughts on these issues, but I'm mostly
> interested in whether or not the scenario I described falls within
> ext2/3's designed capabilities.
>
> Best.
>
>

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu 
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

