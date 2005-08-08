Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVHHSdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVHHSdB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVHHSdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:33:01 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:11959 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932182AbVHHSdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:33:00 -0400
Message-ID: <42F7A557.3000200@zabbo.net>
Date: Mon, 08 Aug 2005 11:32:55 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       mark.fasheh@oracle.com
Subject: Re: GFS
References: <20050802071828.GA11217@redhat.com>            <84144f0205080203163cab015c@mail.gmail.com>            <20050803063644.GD9812@redhat.com> <courier.42F768D5.000046F2@courier.cs.helsinki.fi>
In-Reply-To: <courier.42F768D5.000046F2@courier.cs.helsinki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:

> Sorry if this is an obvious question but what prevents another thread
> from doing mmap() before we do the second walk and messing up num_gh?

Nothing, I suspect.  OCFS2 has a problem like this, too.  It wants a way
for a file system to serialize mmap/munmap/mremap during file IO.  Well,
more specifically, it wants to make sure that the locks it acquired at
the start of the IO really cover the buf regions that might fault during
the IO.. mapping activity during the IO can wreck that.

- z
