Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVAQQQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVAQQQj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 11:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVAQQQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 11:16:39 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:32478 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262046AbVAQQQb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 11:16:31 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16875.61369.54922.114653@tut.ibm.com>
Date: Mon, 17 Jan 2005 11:02:49 -0600
To: karim@opersys.com
Cc: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
       Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41EADA11.70403@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	<m1zmzcpfca.fsf@muc.de>
	<m17jmg2tm8.fsf@clusterfs.com>
	<20050114103836.GA71397@muc.de>
	<41E7A7A6.3060502@opersys.com>
	<Pine.LNX.4.61.0501141626310.6118@scrub.home>
	<41E8358A.4030908@opersys.com>
	<Pine.LNX.4.61.0501150101010.30794@scrub.home>
	<41E899AC.3070705@opersys.com>
	<Pine.LNX.4.61.0501160245180.30794@scrub.home>
	<41EA0307.6020807@opersys.com>
	<Pine.LNX.4.61.0501161648310.30794@scrub.home>
	<41EADA11.70403@opersys.com>
X-Mailer: VM 7.18 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour writes:
 > 
 > Hello Roman,
 > 
 > 
 > What we are dropping for later review: read/write semantics from
 > user-space. It has to be understood that we believe that this is
 > a major drawback. For one thing, you won't be able to do something
 > like:
 > $ cat /relayfs/xchg/my-file > ~/test-data
 > 
 > Instead, you will have to write a custom app that does open(),
 > mmap(), write(). We could still provide a small app/library that
 > did this automagically, but you've got to admit that nothing
 > beats the real thing.
 > 

Maybe we could use FUSE to provide read()/write() for relayfs files -
opening a FUSE relayfs file would open and mmap the actual relayfs
file, read() would move around in the buffer using basically the
current relayfs read logic moved down into the FUSE filesystem read
fileop, and write() could write directly to the buffer...

Tom

 > Also note that there are people who currently use this already,
 > so there will be some unhappy campers.
 > 
 > Karim
 > -- 
 > Author, Speaker, Developer, Consultant
 > Pushing Embedded and Real-Time Linux Systems Beyond the Limits
 > http://www.opersys.com || karim@opersys.com || 1-866-677-4546

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

