Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267588AbUJHDLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267588AbUJHDLy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 23:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUJHDHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 23:07:07 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8320 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267730AbUJGSZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:25:30 -0400
Date: Thu, 7 Oct 2004 14:25:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stephen Hemminger <shemminger@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Probable module bug in linux-2.6.5-1.358
In-Reply-To: <1097169934.29576.4.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0410071419300.4263@chaos.analogic.com>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com> 
 <1097143144.2789.19.camel@laptop.fenrus.com>  <Pine.LNX.4.61.0410070753060.9988@chaos.analogic.com>
  <20041007121741.GB23612@devserv.devel.redhat.com> 
 <Pine.LNX.4.61.0410070823300.10118@chaos.analogic.com> 
 <20041007122815.GC23612@devserv.devel.redhat.com> 
 <Pine.LNX.4.61.0410070830140.10213@chaos.analogic.com> 
 <Pine.LNX.4.61.0410070850480.10751@chaos.analogic.com>
 <1097169934.29576.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Stephen Hemminger wrote:

> Still haven't full source so this is still guess work.
> But assuming it is a character device, did you forget to add an owner
> field to the file ops structure?
>
> static struct file_operations xxx_fops = {
> 	.owner	= THIS_MODULE,
> 	.read	= my_read,
> ...
>
> The owner field is used by the character device layer to maintain module
> ref counts in 2.6.
>

No. The owner field is properly filled in and I did provide
the complete source code and build files for anybody who didn't
delete the email. Scanner.tar.gz was attached.

Further, unregister_chrdev() is called. Its return value is
checked. Everything is fine. I can manually remove and
reinstall the module multiple times and the resources are
always released and re-acquired.

The problem is that if you install the module and then
remove it, if you attempt to open the device-file, the
kernel will crash because it calls where the properly-
removed module used to be. It isn't there anymore.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

