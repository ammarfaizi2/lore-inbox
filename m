Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWFTRSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWFTRSI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWFTRSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:18:08 -0400
Received: from javad.com ([216.122.176.236]:24580 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1751433AbWFTRSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:18:06 -0400
From: Sergei Organov <osv@javad.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org, rmk+serial@arm.linux.org.uk
Subject: Re: [PATCH] moxa: do not ignore input
References: <200506021220.47138.vda@ilport.com.ua>
	<200506021554.07316.vda@ilport.com.ua>
	<20050602225805.GB9628@devserv.devel.redhat.com>
	<200506031601.21180.vda@ilport.com.ua>
Date: Tue, 20 Jun 2006 21:17:44 +0400
In-Reply-To: <200506031601.21180.vda@ilport.com.ua> (Denis Vlasenko's
 message
	of "Fri, 3 Jun 2005 16:01:21 +0300")
Message-ID: <87y7vrpwzr.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@ilport.com.ua> writes:

> Stop using tty internal structure in mxser_receive_chars(),
> use tty_insert_flip_char(tty, ch flag); istead.
>
> Without this change driver ignores any rx'ed chars.
>
> Run tested, please apply.
>
> Any suggestions on further cleanups this driver may need
> while I have access to this hardware?

I have 8-port board, but mxser creates 16 devices anyway, and forces any
application accessing one of those inexistent devices to segfault, e.g.:

osv@osv ~$ cat /dev/ttyM9
Segmentation fault
osv@osv ~$

This is on 2.6.14 kernel though, -- didn't try with more recent kernels
as I have other troubles with them on my hardware/distribution.

Not a big deal, but you've asked yourself ;)

-- 
Sergei.
