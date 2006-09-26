Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWIZAIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWIZAIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 20:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWIZAIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 20:08:20 -0400
Received: from mail1.webmaster.com ([216.152.64.169]:21765 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751822AbWIZAIT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 20:08:19 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Swap on Fuse deadlocks?
Date: Mon, 25 Sep 2006 17:08:13 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEIEOKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <45184D88.1010203@comcast.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 25 Sep 2006 17:11:11 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 25 Sep 2006 17:11:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Swap on disk I don't get.  A little slow perhaps due to the LZO or zlib
> compression in the middle (lzolayer lets you pick either); but a total
> freeze?  What's wrong here, is lzo_fs data getting swapped out and then
> not swapped in because it's needed to decompress itself?

The filesystem would have to make sure to lock in memory itself and any code it might need. Obviously, if the filesystem code itself gets swapped out, you cannot swap it back in again ever. Any user-space filesystem that expects to handle swap had better call 'mlock'.

DS


