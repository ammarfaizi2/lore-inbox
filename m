Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264979AbUFXNwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbUFXNwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbUFXNwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 09:52:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:186 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264979AbUFXNv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 09:51:26 -0400
Date: Thu, 24 Jun 2004 15:51:23 +0200
From: Olaf Dabrunz <od@suse.de>
To: Sam Elstob <samelstob@fastmail.fm>
Cc: linux-kernel@vger.kernel.org, Amit Gud <gud@eth.net>
Subject: Re: Elastic Quota File System (EQFS)
Message-ID: <20040624135123.GB3614@suse.de>
Mail-Followup-To: Sam Elstob <samelstob@fastmail.fm>,
	linux-kernel@vger.kernel.org, Amit Gud <gud@eth.net>
References: <40d9ac40.674.0@eth.net> <200406231853.35201.mrwatts@fast24.co.uk> <1088016048.15211.10.camel@sage.kitchen> <001901c459cd$bc436e40$868209ca@home> <20040624115019.GA3614@suse.de> <40DADF72.5060308@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40DADF72.5060308@fastmail.fm>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-Jun-04, Sam Elstob wrote:
> Amit
> 
> I agree that the situation with 10000+ users is where such a filesystem 
> becomse useful.  It is the difference between actual disk usage and sum 
> of all disk quota that provides the elastisicty.
> 
> Imagine an ISP providing free mail with an advertised quota of 1GB per 
> user.  With 100,000 users, 100TB of storage would be needed.  However, 
> it is likely that most users would not use their full quota meaning a 
> lot of wasted storage capacity, at the expense of the mail provider. 
> What if the EFS could allow the sum of all advertised quotas to total 
> more than the actual online disk capacity.  Assuming average quota usage 
> settles down and doesn't suddenly change on mass the actual online 
> storage capacity of the system could be much lower (and thus cheaper) 
> than the case where every user is at full quota.  When the actual disk 
> usage reaches, say 70%, of the attached capacity the administrator could 
> be notified and action taken e.g. attach more disks and extend the 
> volume, or backup and delete dead accounts.

This case is easily solved without any new mechanism. Simply assign a
quota of 1GB to each user while providing physical disk space only for
the expected filling + free space margin. Handle additional space
requirements as you described above.

What Amid tries to solve is obviously a different "scenario": how to put
more files on the disks than fit in the physically available space.

He tries to do that by
   - squeezing in more data by compressing other data
   - deleting files
   - backing up files

And he provides a mechanism how a user can buy more space by marking
other files as "shrink/delete/back up at filesystems discretion". So in
effect he says: buy more space by marking files as "not needed, may be
removed (deleted or moved to some unreachable place) at any time". Then
I would rather opt to "clean up" my files myself whenever I need more
space within my quota.

(The compression case is actually not working out, since it will only
get back as much space as the compression achieves. So the elastic quota
may only be expanded by the space saved when the file is compressed. To
find out this ratio, you have to compress the file. But then you can as
well have your filesystem transparently compress the file.)

> I'm talking about the case where large (10000>) numbers of users are 
> involved with a habit of using less than some advertised quota. 
> Obviously the adverised quota is still available to those who want it, 
> but overall the necessary disk space is less than the sum of all 
> advertised disk quotas.
> 
> Sam Elstob

-- 
Olaf Dabrunz (od/odabrunz), SUSE Linux AG, Nürnberg

