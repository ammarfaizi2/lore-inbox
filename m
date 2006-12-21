Return-Path: <linux-kernel-owner+w=401wt.eu-S1422960AbWLUQyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422960AbWLUQyc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 11:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422970AbWLUQyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 11:54:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45130 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422960AbWLUQyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 11:54:31 -0500
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       "'Trond Myklebust'" <trond.myklebust@fys.uio.no>,
       "'xb'" <xavier.bru@bull.net>, "'Zach Brown'" <zach.brown@oracle.com>,
       <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] aio: fix buggy put_ioctx call in aio_complete
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <000101c724de$1c81d980$1b80030a@amr.corp.intel.com>
From: jmoyer@redhat.com
Date: Thu, 21 Dec 2006 11:55:38 -0500
In-Reply-To: <000101c724de$1c81d980$1b80030a@amr.corp.intel.com> (Kenneth W. Chen's message of "Thu, 21 Dec 2006 00:57:57 -0800")
Message-ID: <m3vek5xk6t.fsf@redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding RE: [patch] aio: fix buggy put_ioctx call in aio_complete; "Chen, Kenneth W" <kenneth.w.chen@intel.com> adds:

kenneth.w.chen> I think I'm going to abandon this whole synchronize thing
kenneth.w.chen> and going to put the wake up call inside ioctx_lock spin
kenneth.w.chen> lock along with the other patch you mentioned above in the
kenneth.w.chen> waiter path.  On top of that, I have another patch attempts
kenneth.w.chen> to perform wake-up only when the waiter can truly proceed
kenneth.w.chen> in aio_read_evt so dribbling I/O completion doesn't
kenneth.w.chen> inefficiently waking up waiter too frequently and only to
kenneth.w.chen> have waiter put back to sleep again. I will dig that up and
kenneth.w.chen> experiment.

In the mean time, can't we simply take the context lock in
wait_for_all_aios?  Unless I missed something, I think that will address
the reference count problem.

Thanks,

Jeff
