Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267935AbUIGMDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbUIGMDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267930AbUIGMDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:03:35 -0400
Received: from mx02.qsc.de ([213.148.130.14]:30647 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S267916AbUIGMDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:03:25 -0400
Date: Tue, 07 Sep 2004 14:03:19 +0200
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: =?utf-8?Q?J=C3=B6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <413DA387.nailA2K1PT2WH@pluto.uni-freiburg.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de>
 <20040904153902.6ac075ea.akpm@osdl.org>
 <413C5BF2.nail2RA1138AG@pluto.uni-freiburg.de>
 <20040906133523.GC25429@wohnheim.fh-wedel.de>
 <413C74E6.nail3YF11Y0TT@pluto.uni-freiburg.de>
 <20040907110913.GA25802@wohnheim.fh-wedel.de>
 <20040907114536.GA26630@wohnheim.fh-wedel.de>
In-Reply-To: <20040907114536.GA26630@wohnheim.fh-wedel.de>
User-Agent: nail 11.6pre 9/7/04
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

Also it might perhaps make sense to add the kernel programmer's
equivalent of

> +	while (count) {
> +		size_t n = min(count, (size_t)4096);
> +		ret = in_file->f_op->sendfile(in_file, ppos, n, actor,out_file);
> +		if (ret < 0) {
> +			if (done)
> +				return done;
> +			else
> +				return ret;
> +		}
> +
> +		done += ret;
> +		count -= ret;
> +
> +		if ((ret == 0) || signal_pending(current))
                {
			if (count == 0) {
				done = -1;
				errno = EINTR;
			}
> +			break;
		}
> +		cond_resched();
> +	}
> +	return done;
> +}

here, for write-like semantics, too.

	Gunnar
