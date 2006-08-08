Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWHHUiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWHHUiU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 16:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWHHUiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 16:38:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:26018 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030268AbWHHUiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 16:38:19 -0400
Date: Tue, 8 Aug 2006 21:38:14 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, viro@zeniv.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mishin Dmitry <dim@openvz.org>
Subject: Re: [PATCH] move IMMUTABLE|APPEND checks to notify_change()
Message-ID: <20060808203814.GO29920@ftp.linux.org.uk>
References: <44D87907.6090706@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D87907.6090706@sw.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 03:44:07PM +0400, Kirill Korotaev wrote:
> [PATCH] move IMMUTABLE|APPEND checks to notify_change()
> 
> This patch moves lots of IMMUTABLE and APPEND flag checks
> scattered all around to more logical place in notify_change().
 
NAK.  For example, you are allowed to do unames(file, NULL) on
any file you own or can write to, whether it's append-only or
not.  With your change that gets -EPERM.
