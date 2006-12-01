Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031659AbWLAAu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031659AbWLAAu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 19:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031661AbWLAAu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 19:50:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:9694 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1031659AbWLAAu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 19:50:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=Q8UJngZKmJR/lAEJRmwqKCjLDV08LxT5kNuHnx+KrB/Ta9kEorrh4YkEBvaZa1hCMzz9yGz7OjTxzxXVMXz3jlIMvK6TREG42wZzyJBWmPfzl1cl2PaP821W7riO77Elj38vsZZI2lpF9K6zy9a+2HxwG3XHD3RI1orGxywdRjA=
Message-ID: <456F7C69.90800@gmail.com>
Date: Fri, 01 Dec 2006 09:50:49 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: "gary.czek" <gary@czek.info>
CC: linux-kernel@vger.kernel.org
Subject: Re: ICH6M SATA Controller, SATA2 NCQ disk and high iowait CPU time
References: <1164404380.20334.37.camel@localhost>	<456A5936.9080903@gmail.com> <20061130180646.66dc622b@localhost>
In-Reply-To: <20061130180646.66dc622b@localhost>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gary.czek wrote:
> "vmstat 5" when system is really slow shows following:
> 
> procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
>  0  9 285904   3044    832  42088   75   46   247    98  484  746  5  2 80 13
>  0  4 285560   3628    692  43724  686   71   913   418  952 1651 18  3  0 79
>  0  3 285000   3616    688  43100  822   15  1431   766  939 1761 16  4  0 80
>  0  3 284372   3612    700  42344  703    0  1234    43  941 1697 18  3  7 72
>  1  2 284012   3176    580  42800  406    0  1054    74  834 1602 15  4 36 45
>  0  3 283820   3888    824  40044  413   23  1102    95  865 1767 17  3  0 80
>  0  1 286364   3904    900  41508   63  540  1023   629  928 1646 15  3  0 82
>  0  2 287500   4884   1120  44840  388  338  1606   431  902 1670 13  4  0 83
>  0 10 291148   3104   1296  46088  396  827   923   877  917 1521 10  3  0 87
>  0  3 292952   3728   1492  47524  259  474   730   606  889 1754 15  2  0 84
>  0  2 294960   3540   1588  47488  633  632   970   678  863 1630 12  2  0 86
>  0  2 297444   3828   1676  46496  648  674   774   735  886 1906 14  2  0 84
>  0  3 298184   3616   1684  46420  593  290   759   331  844 1792 12  3  0 85
>  0  5 297836   3852   1508  43576  632  168   990   229  814 1605 10  1  0 88

Your machine is thrashing.  Working set size is over the available
memory and pages are continuously getting dropped and then brought back.
 Run top and press 'M' after the list showed up.  It will show who are
consuming all the memory.  Adding 1G should solve the problem but just
another 256M will make a big difference too.

-- 
tejun
