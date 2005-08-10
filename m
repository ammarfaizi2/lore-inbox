Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbVHJUSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbVHJUSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbVHJUSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:18:50 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:42424 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030242AbVHJUSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:18:50 -0400
References: <20050802071828.GA11217@redhat.com>
            <84144f0205080203163cab015c@mail.gmail.com>
            <20050803063644.GD9812@redhat.com>
            <courier.42F768D5.000046F2@courier.cs.helsinki.fi>
            <42F7A557.3000200@zabbo.net>
            <1123598983.10790.1.camel@haji.ri.fi>
            <20050810072121.GA2825@infradead.org>
            <courier.42F9AD38.000018F9@courier.cs.helsinki.fi>
            <20050810162618.GH21228@ca-server1.us.oracle.com>
            <courier.42FA3207.00002648@courier.cs.helsinki.fi>
            <20050810182155.GI21228@ca-server1.us.oracle.com>
In-Reply-To: <20050810182155.GI21228@ca-server1.us.oracle.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Zach Brown <zab@zabbo.net>,
       David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Date: Wed, 10 Aug 2005 23:18:48 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42FA6128.000009AE@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh writes:
> Hmm, well today in OCFS2 if you're not coming from read or write, the lock
> is held only for the duration of ->nopage so I don't think we could get into
> any deadlocks for that usage.

Aah, I see GFS2 does that too so no deadlocks here. Thanks. You, however,
don't maintain the same level of data consistency when reads and writes
are from other filesystems as they use ->nopage. 

Fixing this requires a generic vma walk in every write() and read(), no?
That doesn't seem such an hot idea which brings us back to using ->nopage
for taking the locks (but now the deadlocks are back). 

                       Pekka 

