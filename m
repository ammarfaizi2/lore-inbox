Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271407AbTGXBJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 21:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271403AbTGXBJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 21:09:14 -0400
Received: from remt22.cluster1.charter.net ([209.225.8.32]:19364 "EHLO
	remt22.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S271407AbTGXBJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 21:09:12 -0400
Message-ID: <3F1F3555.2020109@mrs.umn.edu>
Date: Wed, 23 Jul 2003 20:24:37 -0500
From: Grant Miner <mine0057@mrs.umn.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: directory inclusion in ext2/ext3
References: <20030723202225.F257B371@mendocino> <20030724005431.GJ1176@matchmail.com>
In-Reply-To: <20030724005431.GJ1176@matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would also like this enhancement.  Plan 9 is built around this 
feature, and it does it as an int argument 'flag' to mount, such that 
'flag' may be (these are defined in a header):

MREPL: Replace the old file by the new one. Henceforth, an evaluation of 
old will be translated to the new file. If they are directories (for 
mount, this condition is true by definition), old becomes a union 
directory consisting of one directory (the new file).

MBEFORE: Both the old and new files must be directories. Add the 
constituent files of the new directory to the union directory at old so 
its contents appear first in the union. After an MBEFORE bind or mount, 
the new directory will be searched first when evaluating file names in 
the union directory.

MAFTER: Like MBEFORE but the new directory goes at the end of the union.

In addition, there is an MCREATE flag that can be OR'd with any of the 
above. When a /create /system call (see /open/(2)) 
<http://plan9.bell-labs.com/magic/man2html/2/open> attempts to create in 
a union directory, and the file does not exist, the elements of the 
union are searched in order until one is found with MCREATE set. The 
file is created in that directory; if that attempt fails, the /create 
/fails.
...
(from http://plan9.bell-labs.com/magic/man2html/2/bind )

Further rationale can be provided if desired; just ask.

