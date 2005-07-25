Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVGYT1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVGYT1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVGYTZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:25:04 -0400
Received: from smtpsrv0.isis.unc.edu ([152.2.1.139]:24975 "EHLO smtp.unc.edu")
	by vger.kernel.org with ESMTP id S261468AbVGYTYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:24:00 -0400
Message-ID: <20050725152348.6o1f03u9r4k8cgk0@webmail1.isis.unc.edu>
Date: Mon, 25 Jul 2005 15:23:48 -0400
From: uma@email.unc.edu
To: linux-kernel@vger.kernel.org
Cc: anderegg@cs.unc.edu
Subject: Re: kernel debugging
References: <42E3946E.4010009@cs.unc.edu>
In-Reply-To: <42E3946E.4010009@cs.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=US-ASCII;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: UNC-CH Webmail 2.0
X-Organization: University of North Carolina at Chapel Hill
X-Originating-IP: 152.2.128.169
X-Remote-Browser: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10)
	Gecko/20050719 Red Hat/1.0.6-1.4.1 Firefox/1.0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using Red Hat sources, which has function open_kcore() hardcoded to
return -EPERM always.

Changing this function to the way it is defined in the public sources (as
shown below) did the trick.

open_kcore(struct inode * inode, struct file * filp)
{
    return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
}

I am now able to use gdb to examine kernel symbols.

Uma.


Quoting UmaMaheswari Devi <uma@cs.unc.edu>:

> I am new to kernel hacking and am facing problems in tryingstatic int
to peek at the
> runtime values of some kernel variables using gdb.
>
> I am issuing the gdb command as follows:
>     gdb vmlinux /proc/kcore
> This displays the message
>    /proc/kcore: Operation not permitted
> before the (gdb) prompt is displayed.
> gdb then prints a value of 0 for any valid variable that is requested.
>
> vmlinux appears to be OK, as gdb correctly identifies undefined variables.
> The problem seems to be with /proc/kcore. This file has a permission 
> of 400. I
> am using the Red Hat distribution.
>
> Any help is appreciated. Thanks,
> Uma.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


