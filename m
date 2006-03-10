Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752121AbWCJCdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbWCJCdQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 21:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbWCJCdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 21:33:16 -0500
Received: from mail.fieldses.org ([66.93.2.214]:12459 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1752121AbWCJCdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 21:33:15 -0500
Date: Thu, 9 Mar 2006 21:33:05 -0500
To: Daniel Phillips <phillips@google.com>
Cc: Mark Fasheh <mark.fasheh@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Ocfs2-devel] Ocfs2 performance bugs of doom
Message-ID: <20060310023305.GB28722@fieldses.org>
References: <4408C2E8.4010600@google.com> <20060303233617.51718c8e.akpm@osdl.org> <440B9035.1070404@google.com> <20060306025800.GA27280@ca-server1.us.oracle.com> <440BC1C6.1000606@google.com> <20060306195135.GB27280@ca-server1.us.oracle.com> <p733bhvgc7f.fsf@verdi.suse.de> <20060307045835.GF27280@ca-server1.us.oracle.com> <440FCA81.7090608@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440FCA81.7090608@google.com>
User-Agent: Mutt/1.5.11+cvs20060126
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 10:26:09PM -0800, Daniel Phillips wrote:
> After untarring four kernel trees, number of locks hits a peak of 128K.
> With 64K buckets the hash, a typical region of the table looks like:
> 
>   3 0 3 6 1 2 2 1 2 6 1 0 1 2 1 0 0 3 1 2 2 3 1 2 5 3 2 2 1 0 3 1
>   1 1 3 5 2 2 1 0 2 3 3 1 3 0 5 2 2 3 0 2 1 3 1 2 4 2 0 2 5 1 4 3
>   5 3 3 3 3 1 4 1 2 1 2 6 2 1 3 0 2 2 2 8 1 2 2 2 3 1 0 1 3 2 1 1
>   1 2 2 2 2 3 2 0 2 2 2 5 2 3 2 1 1 2 6 6 1 2 2 4 2 0 3 0 3 3 3 0
>   2 2 1 1 2 3 2 0 2 3 3 1 3 3 3 1 4 2 8 3 2 2 2 4 3 0 1 2 3 4 2 0
>   3 1 0 1 2 2 3 1 4 2 1 1 3 3 4 3 3 3 4 2 1 4 2 1 5 2 1 3 1 2 3 2
>   1 0 1 5 3 2 1 2 3 0 1 1 2 3 4 4 4 1 3 1 4 3 2 2 4 4 1 3 1 0 0 1
>   3 1 1 3 0 3 0 1 1 1 1 1 3 4 4 2 4 3 4 2 3 3 0 3 4 2 1 5 4 1 3 1
>   1 0 1 0 1 4 1 2 1 4 2 0 2 2 5 2 1 1 1 2 3 6 4 5 5 1 1 2 3 1 5 1
>   3 0 1 0 3 3 2 0 2 1 2 1 0 4 3 2 1 0 1 0 2 7 1 3 2 1 1 2 4 1 3 1
>   2 2 3 1 3 3 1 2 0 2 1 3 1 2 0 4 4 1 2 1 2 3 3 6 0 5 2 1 1 0 3 0
>   1 0 2 0 4 3 2 1 0 0 2 0 1 4 2 4 5 1 0 1 3 2 2 1 1 3 2 3 0 2 1 1
>   3 0 0 0 2 5 3 1 0 2 0 1 0 0 2 0 4 2 1 2 4 3 0 1 2 4 1 3 0 0 1 4
> 
> A poor distribution as you already noticed[1].

How did you decide that? The distribution of bucket sizes is:

0: 58
1: 108
2: 105
3: 82
4: 37
5: 16
6: 7
7: 1
8: 2

which, without running any statistics, looks pretty close to a binomial
distribution:

0 52.884
1 109.21
2 112.63
3 77.349
4 39.793
5 16.358
6 5.5972
7 1.6397
8 0.41980

so it's probably about what you'd get if the hash function were choosing
buckets uniformly at random, which is the best I'd think you could do
without special knowledge of the inputs.

--b.
