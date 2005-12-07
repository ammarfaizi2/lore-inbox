Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbVLGVOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbVLGVOT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbVLGVOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:14:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9679 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751774AbVLGVOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:14:18 -0500
Message-ID: <439750A3.2030805@redhat.com>
Date: Wed, 07 Dec 2005 16:14:11 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kenny Simpson <theonetruekenny@yahoo.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs question - ftruncate vs pwrite
References: <20051207204612.70808.qmail@web34114.mail.mud.yahoo.com>
In-Reply-To: <20051207204612.70808.qmail@web34114.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenny Simpson wrote:

>Sorry about the previous partial message...
>
>If a file is extended via ftruncate, the new empty pages are read in before the the ftruncate
>returns (taking 64mS on my machine), but if the file is extended via pwrite, nothing is read in
>and the system call is very quick (34uS).
>
>Why is there such a difference?  Is there another cheap way to grow a file and map in its new
>pages?  Am I missing some other semantic difference between ftruncate and a pwrite past the end of
>the file?
>

You might use tcpdump or etherreal to see what the different traffic looks
like.  I suspect that ftruncate() leads a SETATTR operation while pwrite()
leads to a WRITE operation.

       ps
