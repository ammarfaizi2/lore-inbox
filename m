Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVDNCTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVDNCTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 22:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVDNCTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 22:19:12 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:37644 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261417AbVDNCTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 22:19:08 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Catalin Marinas" <catalin.marinas@arm.com>
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: RE: Why system call need to copy the date from the userspace before using it
Date: Wed, 13 Apr 2005 19:18:03 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEHODCAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <425DD105.7010304@haha.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 13 Apr 2005 19:17:10 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 13 Apr 2005 19:17:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Catalin Marinas wrote:

> >Tomko <tomko@haha.com> wrote:

> >>Inside the system call , the kernel often copy the data by calling
> >>copy_from_user() rather than just using strcpy(), is it because the
> >>memory mapping in kenel space is different from user space?

> >No, it is because this function checks whether the access to the user
> >space address is OK. There are situations when it can also sleep (page
> >not present).

> what u means "OK"?  kernel space should have right to access any memory
> address , can u expained in details what u means "OK"?

	Kernel space does have the right to access any memory but user space
doesn't, so the kernel can't just take an address from user space and use
it. Consider:

int i=open("/dev/null", O_RDWR);
write(i, NULL, 4);

	Are you seriously suggesting the kernel should just read from address zero
because a user-space program asked it to?

	DS


