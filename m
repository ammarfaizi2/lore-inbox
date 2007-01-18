Return-Path: <linux-kernel-owner+w=401wt.eu-S932300AbXARVkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbXARVkr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbXARVkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:40:47 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:41580 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932300AbXARVkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:40:47 -0500
In-Reply-To: <20070118042731.GA15859@in.ibm.com>
References: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com> <20070116015450.9764.52713.patchbomb.py@nate-64.agami.com> <20070116021438.GA15774@infradead.org> <20070118042731.GA15859@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5B15B741-3D7E-4C32-BC9C-7109250A83C1@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: Vectored AIO breakage for sockets and pipes ?
Date: Thu, 18 Jan 2007 13:40:45 -0800
To: suparna@in.ibm.com
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not sure what the best way to fix this is. One option is to  
> always make
> a copy of the iovec and pass that down. Any other thoughts ?

Can we use this as another motivation to introduce an iovec container  
struct instead of passing a raw iov/seg?  The transition could turn  
hand-rolled functions like pipe_iov_copy_to_user() into functions  
that this iovec struct API provides.

I don't know if this would specifically help aio_rw_vect_retry() to  
know if it should advance the iovec on behalf of its callee who  
returned positive result codes.

Maybe it could use the API to discover a case where ret < size &&  
cur_pos(iov_struct) == initial_pos(iov_struct) via some iovec pos  
query before rw_op is called?

Or maybe the introduction of the API could normalize where the  
responsibility of advancing the iovec lies.  That might be a bit much.

Just talkin' here.

- z
