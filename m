Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVDFOUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVDFOUh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 10:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVDFOUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 10:20:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49097 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262213AbVDFOUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 10:20:30 -0400
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems (ext3 gurus : please check)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Hifumi Hisashi <hifumi.hisashi@lab.ntt.co.jp>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       vherva@viasys.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
References: <20050326162801.GA20729@logos.cnet>
	 <20050328073405.GQ16169@viasys.com> <20050328165501.GR16169@viasys.com>
	 <16968.40186.628410.152511@cse.unsw.edu.au>
	 <20050329215207.GE5018@logos.cnet>
	 <16970.9679.874919.876412@cse.unsw.edu.au>
	 <20050330115946.GA7331@logos.cnet>
	 <1112740856.4148.145.camel@sisko.sctweedie.blueyonder.co.uk>
	 <6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1112797205.3377.16.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 06 Apr 2005 15:20:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-04-06 at 11:01, Hifumi Hisashi wrote:

>  >Certainly it's normal for a short read/write to imply either error or
>  >EOF, without the error necessarily needing to be returned explicitly.
>  >I'm not convinced that the Singleunix language actually requires that,
>  >but it seems the most obvious and consistent behaviour.

> When an O_SYNC flag is set , if commit_write() succeed but 
> generic_osync_inode() return
> error due to I/O failure, write() must fail .

Yes.  But it is conventional to interpret a short write as being a
failure.  Returning less bytes than were requested in the write
indicates that the rest failed.  It just doesn't give the exact nature
of the failure (EIO vs ENOSPC etc.)  For regular files, a short write is
never permitted unless there are errors of some description.

--Stephen

