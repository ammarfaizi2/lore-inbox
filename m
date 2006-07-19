Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWGSDoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWGSDoa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 23:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWGSDoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 23:44:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:32968 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932483AbWGSDo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 23:44:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OvImEpfFwSacQxqfpENg2F1tjBxENSuDdwh7VHE4NmTddpCVD17JzM9TyWgJg0iEEqVOMODv/sXkgLkT5ycIAcy3oKkDph/XG8DMLRUPJVWdhJLZ1xfppdIC5FoUcKJ4tCNZtv+5HRmd0OkgcN2hbyGrupSgjfH6gXsf7noCEMk=
Message-ID: <4df04b840607182044o2514d7ddi8893c268b759ca41@mail.gmail.com>
Date: Wed, 19 Jul 2006 11:44:27 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Improvement on memory subsystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200607181218.k6ICIgeS027067@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
	 <200607181218.k6ICIgeS027067@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 18 Jul 2006 18:03:54 +0800, yunfeng zhang said:
>
> But wouldn't that end up causing a seek storm, rather than handling the pages
> in the order that minimizes the total seek distance, no matter where they are
> in memory? Remember - if you have a 2Ghz processor, and a disk that seeks in 1
> millisecond, every seek is (*very* roughly) about 2 million instructions.  So
> if we can burn 20 thousand instructions finding a read order that eliminates
> *one* seek, we're 1.98M instructions ahead.

Further sample is showd below

to page-fault (page-in operation) scan the pte triggering page-fault and its
following ptes in its VMA, if its followers are swap_entry_t type and their
relative offset is enough closer to the host pte, read them together.

to swap daemon (page-out operation), let's scan every pte of a VMA in the OS, if
we find an appropriate candidate, lock it and its following ptes if all ptes are
appropriate swap-out objects, then allocate a consecutive swap pages from swap
space, if we're success, do an efficient asynchronous IO operation; if we're
failed, shrink those ptes.

Isn't it right?

By the way, all improvements listed by me are introduced briefly, most of them
are complex, maybe only my documentation can descript them clearly.
