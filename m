Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbTDFSoE (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 14:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTDFSoE (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 14:44:04 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:58772 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S263052AbTDFSoD (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 14:44:03 -0400
Date: Sun, 6 Apr 2003 11:55:37 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Stephan van Hienen <raid@a2000.nu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: tuning disk on 3ware /performance problem
In-Reply-To: <200304061131_MC3-1-333A-E630@compuserve.com>
Message-ID: <Pine.LNX.4.53.0304061153050.2993@twinlark.arctic.org>
References: <200304061131_MC3-1-333A-E630@compuserve.com>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Apr 2003, Chuck Ebbert wrote:

>
>
>
> > Is there anything i can do to tune the drives connected to he 3ware
> > controller ? (37MB/sec vs 43MB/sec) (and why is the seq. output block
> > 65MB/sec on the 3ware vs 41MB/sec on 'ide controllers')
>
>
> Try doing a real test with a 1 GB file on an empty filesystem:
>
>
> # mount /fs && date
> # time dd if=/dev/zero of=/fs/file1 bs=128k count=8k

that should be:

time 'dd if=/dev/zero of=/fs/file1 bs=128k count=8k && sync'

otherwise you're not measuring the time it takes to get all the data to
disk.

or use lmdd from lmbench, and its built in syncing options.

> # umount /fs && date && mount /fs

or i suppose if you're not looking at the output of "time" and rather hand
subtracting the two dates?

-dean

> # time dd if=/fs/file1 of=/dev/null bs=128k
>
>
> I get numbers that disagree with hdparm by a large amount.
>
> --
>  Chuck
>  I am not a number!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
