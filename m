Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268236AbUHFSKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268236AbUHFSKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 14:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUHFSKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 14:10:41 -0400
Received: from fecls-02.atlarge.net ([129.41.63.107]:32835 "HELO
	fecls-02.atlarge.net") by vger.kernel.org with SMTP id S266561AbUHFSIb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 14:08:31 -0400
Message-ID: <4113C7BA.6060608@cse.wustl.edu>
Date: Fri, 06 Aug 2004 13:02:34 -0500
From: "Mr. Berkley Shands" <berkley@cse.wustl.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fast patch for Severe I/O performance regression 2.6.6 to 2.6.7 or
 2.6.8-rc3
References: <41126811.7020607@dssimail.com> <20040805172531.GC17188@holomorphy.com>
In-Reply-To: <20040805172531.GC17188@holomorphy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Aug 2004 18:04:05.0022 (UTC) FILETIME=[C2DA33E0:01C47BDF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in 2.6.8-rc3/mm/readahead.c line 475 (about label do_io:)
#if 0
            ra->next_size = min(average , (unsigned long)max);
#endif

the comment for the above is here after an lseek. The lseek IS inside 
the window, but the code will always
destroy the window and start again. The above patch corrects the 
performance problem,
but it would be better to do nothing if the lseek is still within the 
read ahead window.

berkley
