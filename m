Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWD0BMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWD0BMv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 21:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWD0BMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 21:12:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3718 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964860AbWD0BMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 21:12:50 -0400
Message-ID: <44501A97.2060104@engr.sgi.com>
Date: Wed, 26 Apr 2006 18:12:55 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Patch 5/8] taskstats interface
References: <444991EF.3080708@watson.ibm.com> <444996FB.8000103@watson.ibm.com>
In-Reply-To: <444996FB.8000103@watson.ibm.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shailabh,

Thanks for your effort in taskstats interface! Really appreciated!
I think this interface can offer a good foundation for other packages
to build on.

Here are a few more comments:

1) You mentioned the "version number within the (taskstats)
    structure" in taskstats.txt and a few other places, but i do not see
    that field defined in struct taskstats in taskstats.h?

2) In taskstats.txt "Extending taskstats" section, you mentioned two
    ways to extend the interface. The second method looks like a method
    to encoureage other package developers to create their own interface
   (ie, not taskstats) based on generic netlink to avoid reading large
number
    of fields not interested to other particular applications? I will be
fine
    with this as long as it is understood and agreed.

    Alternatively, you may have considered the pros and cons of #ifdef
    fields specific to only one accounting package in the struct taskstats.
    If you do, care to share your thoughts? Specific payload information
    can be carried in the version field. I am sure the version number of
struct
    taskstats does not need 64 bits. With the version number and payload
    info, application can surely interpret the taskstats data correctly.  

3) In taskstats.txt "Usage" section, you mentioned "... in the Advanced
    Usage section below...", but that section does not exist.

4) In do_exit() routine, you do:
+ taskstats_exit_alloc(&tidstats, &tgidstats);

    The tidstats and tgidstats are checked in taskstats_exit_send() in
    taskstats.c for allocation failure, but a lot has been processed before
    the check. The allocation failure happens when system is stressed in
    memory. I  think we want to do the check earlier?
   
Regards,
 - jay

