Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266110AbUFJEiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbUFJEiY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 00:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266113AbUFJEiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 00:38:24 -0400
Received: from mail1.panix.com ([166.84.1.72]:9688 "EHLO mail1.panix.com")
	by vger.kernel.org with ESMTP id S266110AbUFJEiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 00:38:19 -0400
Date: Thu, 10 Jun 2004 00:38:19 -0400
From: Henry Yen <henry@panix.com>
To: "A. op de Weegh" <aopdeweegh@rockopnh.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Granting some root permissions to certain users
Message-ID: <20040610043818.GA3708@panix.com>
Mail-Followup-To: "A. op de Weegh" <aopdeweegh@rockopnh.nl>,
	linux-kernel@vger.kernel.org
References: <jbm.20040525185001.f766d1ea@TOSHIBA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jbm.20040525185001.f766d1ea@TOSHIBA>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 06:50:01PM +0200, A. op de Weegh wrote:
> At our school, we have a installed Fedora Core 1 on a machine which acts as a 
> server. Our students may store reports and other products, that they have 
> created for their lessons, on this machine. Also the teachers have an 
> account.
>  
> I would like the teachers to have list access on ALL directories. Just as the 
> root user has. I wouldn't like the teachers to have all root permissions, but 
> they should only be able to list ALL directories available. Viewing only, no 
> writing.
>  
> Any idea how I can achieve this?

It sounds like the students are working on machines that are _not_ the
machine that stores their "reports and other products".  If so, what
machines are the students using, and what mechanism is employed to
allow the students to store to that separate server machine?  Depending
on your answer, a good solution might be more obvious.

However, for a general solution that could work even in same-machine setups,
(I suspect this might work differently on different kernels/distributions)
you could try mounting the subtree containing this "read-all" piece as
an NFS mount, by specifying "ro,all_squash,anonuid=0" as the options.
Make the local mount-point "hidden" (underneath another directory only
accessible to the teachers).  Note that this gives you read-only access
to also read files, not just list directories.
  
For example, in /etc/exports, you'd have:
/students teacher(ro,all_squash,anonuid=0)
/students localhost(ro,all_squash,anonuid=0)

On the "teacher" machine, you could have /hidden as a directory,
mode 750, group "teachers", with a subdirectory called "mnt".
Then "mount studentserver:/students /hidden/mnt".  Anyone in the
"teachers" group on the "teacher" machine could read-access anything
in the /students tree via /hidden/mnt/*.

Perhaps there are some security issues with NFS on a local-machine-only
setup, though.
-- 
Henry Yen <henry@panix.com>
netcom shell refugee '94.  henry@netcom.com,henryyen@netcom.com
Hicksville, New York
