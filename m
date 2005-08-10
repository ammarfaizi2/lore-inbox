Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbVHJQ5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbVHJQ5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 12:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbVHJQ5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 12:57:47 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:10658 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965208AbVHJQ5r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 12:57:47 -0400
References: <20050802071828.GA11217@redhat.com>
            <84144f0205080203163cab015c@mail.gmail.com>
            <20050803063644.GD9812@redhat.com>
            <courier.42F768D5.000046F2@courier.cs.helsinki.fi>
            <42F7A557.3000200@zabbo.net>
            <1123598983.10790.1.camel@haji.ri.fi>
            <20050810072121.GA2825@infradead.org>
            <courier.42F9AD38.000018F9@courier.cs.helsinki.fi>
            <20050810162618.GH21228@ca-server1.us.oracle.com>
In-Reply-To: <20050810162618.GH21228@ca-server1.us.oracle.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Zach Brown <zab@zabbo.net>,
       David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Date: Wed, 10 Aug 2005 19:57:43 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42FA3207.00002648@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, 

Mark Fasheh writes:
> This may sound naive, but so far OCFS2 has avoided the nead for deadlock
> detection... I'd hate to have to add it now -- better to try avoiding them
> in the first place.

Surely avoiding them is preferred but how do you do that when you have to 
mmap'd regions where userspace does memcpy()? The kernel won't much saying 
in it until ->nopage. We cannot grab all the required locks in proper order 
here because we don't know what size the buffer is. That's why I think lock 
sorting won't work of all the cases and thus the problem needs to be taken 
care of by the dlm. 

                       Pekka 

