Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUCGDeh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 22:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUCGDeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 22:34:37 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:61589 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S261551AbUCGDef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 22:34:35 -0500
Message-ID: <404A9835.4020602@matchmail.com>
Date: Sat, 06 Mar 2004 19:34:13 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Ramy M. Hassan" <ramy@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Advanced storage management ( suggestion )
References: <003801c402ea$44437190$ba10a8c0@ramy>
In-Reply-To: <003801c402ea$44437190$ba10a8c0@ramy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ramy M. Hassan wrote:
> 1- Very fast block allocation ( Using balanced trees for tracking free
> blocks comes into my mind now, but I still it is early to decide the
> design ).

You most likely want to use extents in addition to whatever else you use 
(ie, trees/etc.).

> 2- Support for multi-disk/multi-host storage pool.

You're mixing layers here.  MD and DM already work in this area.

> 3- Meta data storage and block storage can be isolated for better
> performance.

There is support for journal on a different device in the generic JBD 
code that ext3 uses, and reiserfs (possibly others also).  That may be a 
good place to work from.

Are there any examples of this in other OSes?  If you put the meta-data 
on a separate drive, it would be an inherently seeky load.  How does 
this compare to putting raid below the mixed data and meta-data block 
device?

> 4- Meta data and block replication options.

Coda and Intermezzo do this in a filesystem independent way already. 
This can add flexibility.

> 5- Transactional options for journaling filesystems or transactional
> databases.

Isn't journaling inherently transaction based already?

> 6- Supports clustering through lock managers where multiple hosts can
> read/write to same storage devices concurrently ( suitable for SANs )

This is going to be a very heavy layer, and few people will use it if it 
isn't very light (or can be configured that way)

> 7- Transparent recovery from corruption or hardware failure.

Journaling in ext3 is block based, and the rest are virtual 
(descriptions of the actions are in the journal, not the entire block of 
meta-data -- when you're not running in data journaling mode).

How do you plan on integrating your proposed layer with these two very 
different approaches to filesystem journaling?

> 8- Direct access from userland ( for DBMS, LDAP, and other userland
> applications ). 

You have a separate userspace, and kernel implementation right?

> 9- Plugins support ( like those of reiserfs 4).

This can be good or bad.  Make sure it doesn't bloat your layer.

Mike
