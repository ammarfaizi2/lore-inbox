Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVIUVGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVIUVGV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVIUVGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:06:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:18636 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964881AbVIUVGU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:06:20 -0400
Date: Thu, 22 Sep 2005 02:30:20 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com
Subject: Re: dentry_cache using up all my zone normal memory -- also seen on 2.6.14-rc2
Message-ID: <20050921210019.GF4569@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com> <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org> <4331C9B2.5070801@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4331C9B2.5070801@nortel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 02:59:30PM -0600, Christopher Friesen wrote:
> Sonny Rao wrote:
> 
> >Over one million files open at once is just asking for trouble on a
> >lowmem-crippled x86 machine, IMHO.
> 
> I don't think there actually are.  I ran the testcase under strace, and 
> it appears that there are two threads going at once.
> 
> thread 1 spins doing the following:
> fd = creat("./rename14", 0666);
> unlink("./rename14");
> close(fd);
> 
> thread 2 spins doing:
> rename("./rename14", "./rename14xyz");

Ewww.. Looks like a leak due to a race.

Does this happen on a non-nfs filesystem ?

Thanks
Dipankar
