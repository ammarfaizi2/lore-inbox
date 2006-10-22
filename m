Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422958AbWJVEG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422958AbWJVEG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 00:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422959AbWJVEG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 00:06:28 -0400
Received: from ns1.suse.de ([195.135.220.2]:31884 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422958AbWJVEG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 00:06:27 -0400
From: Neil Brown <neilb@suse.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
Date: Sun, 22 Oct 2006 14:06:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17722.60989.448470.587430@cse.unsw.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] raid: fix printk format warnings
In-Reply-To: message from Randy Dunlap on Saturday October 21
References: <20061021113406.535d8243.randy.dunlap@oracle.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday October 21, randy.dunlap@oracle.com wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix printk format warnings, seen on powerpc64:
> drivers/md/raid1.c:1479: warning: long long unsigned int format, long unsigned int arg (arg 4)
> drivers/md/raid10.c:1475: warning: long long unsigned int format, long unsigned int arg (arg 4)
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
> 
>  drivers/md/raid1.c  |    4 ++--
>  drivers/md/raid10.c |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff -Naurp linux-2619-rc2g4/drivers/md/raid1.c~raid_printk linux-2619-rc2g4/drivers/md/raid1.c
> --- linux-2619-rc2g4/drivers/md/raid1.c~raid_printk	2006-10-21 11:16:30.066109000 -0700
> +++ linux-2619-rc2g4/drivers/md/raid1.c	2006-10-21 11:20:57.288004000 -0700
> @@ -1474,8 +1474,8 @@ static void fix_read_error(conf_t *conf,
>  					       "raid1:%s: read error corrected "
>  					       "(%d sectors at %llu on %s)\n",
>  					       mdname(mddev), s,
> -					       (unsigned long long)sect +
> -					           rdev->data_offset,
> +					       (unsigned long long)(sect +
> +					           rdev->data_offset),
>  					       bdevname(rdev->bdev,
> b));

So you're saying that if you add an 'unsigned long long int' to an
'unsigned long int', the result is an 'unsigned long int'???
That is not what I would have expected.
I'm happy with the patch, but I'm very surprised that it is needed.
Is this behaviour consistent across various versions of gcc (if it is
convenient to check)??

Thanks,
NeilBrown
