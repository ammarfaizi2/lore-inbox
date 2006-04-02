Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWDBAxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWDBAxe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 19:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWDBAxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 19:53:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9117 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932347AbWDBAxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 19:53:33 -0500
Date: Sat, 1 Apr 2006 16:52:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: torvalds@osdl.org, stable@kernel.org, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, scjody@modernduck.com
Subject: Re: [PATCH] sbp2: fix spinlock recursion
Message-Id: <20060401165241.5989d67f.akpm@osdl.org>
In-Reply-To: <tkrat.11bf8809a766b402@s5r6.in-berlin.de>
References: <tkrat.11bf8809a766b402@s5r6.in-berlin.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>
> @@ -2540,6 +2537,7 @@ static int sbp2scsi_abort(struct scsi_cm
>   				command->Current_done(command->Current_SCpnt);
>   			}
>   		}
>  +		spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);

This changes the call environment for all implementations of
->Current_done().  Are they all safe to call under this lock?
