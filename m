Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267951AbUIGMJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267951AbUIGMJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267973AbUIGMJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:09:29 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:64424 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S267951AbUIGMIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:08:38 -0400
Date: Tue, 7 Sep 2004 14:08:16 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Cc: Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <20040907120816.GB26972@wohnheim.fh-wedel.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de> <20040904153902.6ac075ea.akpm@osdl.org> <413C5BF2.nail2RA1138AG@pluto.uni-freiburg.de> <20040906133523.GC25429@wohnheim.fh-wedel.de> <413C74E6.nail3YF11Y0TT@pluto.uni-freiburg.de> <20040907110913.GA25802@wohnheim.fh-wedel.de> <20040907114536.GA26630@wohnheim.fh-wedel.de> <413DA387.nailA2K1PT2WH@pluto.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <413DA387.nailA2K1PT2WH@pluto.uni-freiburg.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 September 2004 14:03:19 +0200, Gunnar Ritter wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> 
> Also it might perhaps make sense to add the kernel programmer's
> equivalent of
> 
> > +	while (count) {
> > +		size_t n = min(count, (size_t)4096);
> > +		ret = in_file->f_op->sendfile(in_file, ppos, n, actor,out_file);
> > +		if (ret < 0) {
> > +			if (done)
> > +				return done;
> > +			else
> > +				return ret;
> > +		}
> > +
> > +		done += ret;
> > +		count -= ret;
> > +
> > +		if ((ret == 0) || signal_pending(current))
>                 {
> 			if (count == 0) {
> 				done = -1;
> 				errno = EINTR;
> 			}
> > +			break;
> 		}
> > +		cond_resched();
> > +	}
> > +	return done;
> > +}
> 
> here, for write-like semantics, too.

Is that really needed?  If in_file->f_op->sendfile() returns some
error, it's already handled above.  If it returns 0, done remains 0
and we return 0, indicating EOF.  And the check for pending signals
happens after handling the first chunk, so -EINTR shouldn't be
necessary.

But I could be stupid and miss something.

Jörn

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."
