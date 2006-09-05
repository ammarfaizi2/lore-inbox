Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWIELFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWIELFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 07:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWIELFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 07:05:10 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:5280 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751398AbWIELFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 07:05:08 -0400
Date: Tue, 5 Sep 2006 13:00:52 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 06/16] GFS2: dentry, export, super and vm operations
In-Reply-To: <1157453094.3384.994.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609051259070.20457@yvahk01.tjqt.qr>
References: <1157031245.3384.795.camel@quoit.chygwyn.com> 
 <Pine.LNX.4.61.0609041046380.11217@yvahk01.tjqt.qr> 
 <1157383622.3384.950.camel@quoit.chygwyn.com>  <Pine.LNX.4.61.0609041832010.28823@yvahk01.tjqt.qr>
 <1157453094.3384.994.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >> >+	if (IS_ERR(inode))
>> >> >+		return ERR_PTR(PTR_ERR(inode));
>> >> 
>> >> Just return inode.
>> >
>> >The function returns a dentry, so it would need to be casted and I
>> >thought that would look "more odd" than this construction.
>> 
>> Yes, it is very odd indeed that you return an inode as a dentry at all. How is
>> the caller supposed to know whether it was an inode or dentry that was actually
>> returned?
>> 
>
>This is dealing with the error case only. If the function being called
>returns an error (signaled by IS_ERR(inode) - hence an invalid pointer

Seems reasonable. Would you like to add a comment? (Possibly a little 
shorter than this good explanation, maybe

	/* In case of an error, @inode carries the error value, and we
	have to return that. */

>value) then we need to return that error to the calling routing. Since
>this function in question returns a dentry, we convert the invalid
>pointer value from the function returning an inode into an integer and
>then covert the integer into an invalid pointer value again, but this
>time its an invalid pointer to a dentry and hence the correct return
>type for this function.



Jan Engelhardt
-- 
