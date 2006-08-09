Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030571AbWHIHP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030571AbWHIHP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 03:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbWHIHP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 03:15:27 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:38443 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030571AbWHIHP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 03:15:26 -0400
From: Dmitry Mishin <dim@openvz.org>
Organization: SWsoft
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] move IMMUTABLE|APPEND checks to notify_change()
Date: Wed, 9 Aug 2006 11:15:12 +0400
User-Agent: KMail/1.9.1
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       viro@zeniv.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44D87907.6090706@sw.ru> <20060808203814.GO29920@ftp.linux.org.uk>
In-Reply-To: <20060808203814.GO29920@ftp.linux.org.uk>
X-Face: 'h\woBm&GL5>q=4~&$7\8J0Sv3c2a98rBl,dx/@?L4)Tg!C-nz4]2>M>=?utf-8?q?6ZwpyJ=7Ek=7EqqVT-=0A=09=7CIm?=(,W)U}CZo`G#(&OpK?El5u#-mi~%Uo)?X/qE[LE-H88#x'Y<GId$mZ]i%"iG|<=?utf-8?q?Zm/4u=0A=09Ld=2E=23=5B/Am=7D=5DV10UW0qjZUu7?=@;6SQI%Uy^H
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091115.12949.dim@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you meant utimes(file, NULL)?
But is it correct behaviour? Why then do you get -EPERM on utimes(file, smth) 
if the file is append-only? And why do you get -EACCESS on utimes(file, 
NULL), if this file is immutable?

Could you explain, why is it done so?

On Wednesday 09 August 2006 00:38, Al Viro wrote:
> On Tue, Aug 08, 2006 at 03:44:07PM +0400, Kirill Korotaev wrote:
> > [PATCH] move IMMUTABLE|APPEND checks to notify_change()
> >
> > This patch moves lots of IMMUTABLE and APPEND flag checks
> > scattered all around to more logical place in notify_change().
>
> NAK.  For example, you are allowed to do unames(file, NULL) on
> any file you own or can write to, whether it's append-only or
> not.  With your change that gets -EPERM.

-- 
Thanks,
Dmitry.
