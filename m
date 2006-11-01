Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946428AbWKACZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946428AbWKACZF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 21:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946429AbWKACZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 21:25:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:26574 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946428AbWKACZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 21:25:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mZHcmCk/TN3fbcR+pAzqRZ/Ra5ldvFR51VdWUuFYp0+XQEZR/9mFt1iWcwOeDdmDZ/A4oHbBJ9u5a1ecYbpUn4MF6hlvCvxgsSEPhc1zjSppr8WKUdkX9BQ5685lYH/WrHYbch7Qlf8lVL8WY1g0Iegz0jaxajzVUyWYV4cI7d8=
Message-ID: <aaf959cb0610311825j3c1767cbp764580d28a127bc3@mail.gmail.com>
Date: Wed, 1 Nov 2006 10:25:00 +0800
From: "zhou drangon" <drangon.mail@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: reiser4 panic
In-Reply-To: <aaf959cb0610311744w2a9aa7a8o9d38cf957e52bcf1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <aaf959cb0610311744w2a9aa7a8o9d38cf957e52bcf1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seams ok to copy or cat the file, but panic when browse the file from apache.
Apache use sendfile() to read the file

[pid  3536] read(10, "GET /Fedora/core/updates/6/i386/"..., 8000) = 513
[pid  3536] gettimeofday({1162347890, 56510}, NULL) = 0
[pid  3536] stat64("/opt/wwwroot/html/Fedora/core/updates/6/i386/repodata/repomd.xml",
{st_mode=S_IFREG|0644, st_size=1197, ...}) = 0
[pid  3536] open("/opt/wwwroot/html/Fedora/core/updates/6/i386/repodata/repomd.xml",
O_RDONLY|O_LARGEFILE) = 12
[pid  3536] setsockopt(10, SOL_TCP, TCP_CORK, [1], 4) = 0
[pid  3536] writev(10, [{"HTTP/1.1 200 OK\r\nDate: Wed, 01 N"...,
277}], 1) = 277
[pid  3536] sendfile64(10, 12, [0], 1197

2006/11/1, zhou drangon <drangon.mail@gmail.com>:
> Hi, all
>
> I try reiser4 and got a kernel panic.
>
> I use kernel 2.6.19-rc3-mm1, config kernel to enable reiser4,
> then I use reiser4progs-1.0.5 to excute following command,
>
> mkfs.reiser4 /dev/hda5
> mount -t reiser4 /dev/hda5 /hda5
> cd /hda5
> mkdir FC6_mirror
> nohup wget -m -np -nH --cut-dirs=3 -R *-debuginfo-*
> ftp://ftp.nara.wide.ad.jp/pub/Linux/fedora/core/updates/6/i386/ &
> nohup wget -m -np -nH --cut-dirs=3 -R *-debuginfo-*
> ftp://ftp.kddilabs.jp/Linux/packages/fedora/core/updates/6/x86_64/ &
>
> then I make a link at $wwwroot/html/Fedora to /hda5/FC6_mirror
> my web server is apache 2.2.3, use worker mpm,
>
> when I use web browser to access the Fedora mirror
> http://<myip>/Fedora/core/update/6/i386/
> download the rpm files if fine.
>
> until I try to access one file
> http://<myip>/Fedora/core/update/6/i386/repodata/repomd.xml
> the kernel panic.
>
> this file's size is 1197 bytes, a common file.
>
> the infomation print on the screen is something like :
> kernel panic, at reiser4/plugin/item/tail.c:426
>
> I reformat the partition and try again, the bug can reproduced.
>
> any idea?
>
> Best regards!
>
> drangon
> 2006-11-01
>
