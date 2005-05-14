Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVENFat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVENFat (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 01:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVENFat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 01:30:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:431 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262526AbVENFan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 01:30:43 -0400
Date: Fri, 13 May 2005 22:30:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: improve output in sysfs files when the TPM fails
Message-Id: <20050513223003.4f9dc539.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505131422350.13489@localhost.localdomain>
References: <Pine.LNX.4.62.0505121717240.11837@localhost.localdomain>
	<20050512225541.GA29958@kroah.com>
	<Pine.LNX.4.62.0505131422350.13489@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Hall <kjhall@us.ibm.com> wrote:
>
>  On Thu, 12 May 2005, Greg KH wrote:
>  > On Thu, May 12, 2005 at 05:20:22PM -0500, Kylene Hall wrote:
>  > > When the TPM is in a disabled or deactivated state the sysfs pcrs and 
>  > > pubek files will appear empty.  To remove any confusion this might cause, 
>  > > the files will instead contain the error the TPM returned (also indicative 
>  > > of what state the TPM is in and what actions might be needed to change 
>  > > that state).
>  > 
>  > No, sysfs files are not error logs.  Please use the standard system wide
>  > error log for this (syslog).
>  > 
>  > Why not just change the mode of the sysfs file instead, or delete it
>  > entirely in this case?
> 
>  Ok, instead of putting error information in the sysfs file this new patch 
>  will put an error entry in syslog.  The sysfs files can't easily be 
>  removed in these cases as the driver does not know this information and it 
>  can be changed by commands sent to the TPM from userspace.

Will this change permit unprivileged users to create large amounts of
syslog output?  If so, this is considered poor form.

IOW: please confirm that the relevant sysfs files are root-read-only?
