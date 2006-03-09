Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWCIGmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWCIGmZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWCIGmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:42:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:54176 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751358AbWCIGmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:42:24 -0500
Date: Wed, 8 Mar 2006 22:41:19 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, amax@us.ibm.com,
       Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops on ibmasm
Message-ID: <20060309064119.GA10546@kroah.com>
References: <20060308224145.47332.qmail@web52607.mail.yahoo.com> <20060308225924.GB21130@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308225924.GB21130@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 05:59:25PM -0500, Dave Jones wrote:
> On Thu, Mar 09, 2006 at 09:41:45AM +1100, Srihari Vijayaraghavan wrote:
>  > command count: 1
>  > input: ibmasm RSA I remote mouse as
>  > /class/input/input2
>  > input: ibmasm RSA I remote keyboard as
>  > /class/input/input3
>  > ibmasm remote responding to events on RSA card 0
>  > command count: 2
>  > ibmasm_exec_command:130 at 1141819512.780778
>  > do_exec_command:107 at 1141819512.780787
>  > respond to interrupt at 1141819512.782055
>  > exec_next_command:150 at 1141819512.782094
>  > finished interrupt at   1141819512.782103
>  > command count: 1
>  > Unable to handle kernel paging request at virtual
>  > address 6b6b6b6b
> 
> the problem is we do this..
> 
>     command_put(sp->current_command);
> 	exec_next_command(sp);
> 
> command_put drops the refcount of the kobject in sp,
> which then gets freed in the .release (free_command)
> which ends up kfree'ing 'sp'.
> 
> unsurprisingly, it goes bang the next time something
> tries to access it.  (Ie the 2nd line above)
> 
> It's totally busted.

I think there's a patch floating around somewhere to actually fix up
this driver so it works.  Max, any ideas about this?

thanks,

greg k-h
